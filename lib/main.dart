import 'package:chat_app/shared/components/componenets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/chat_screen/chat_screen.dart';
import 'modules/chat_screen/cubit/cubit.dart';
import 'modules/welcome_screen/welcome_screen.dart';
import 'shared/network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget myWidget;

  var user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    myWidget = ChatScreen();
  } else {
    myWidget = WelcomeScreen();
  }

  runApp(MyApp(myWidget));
}

class MyApp extends StatelessWidget {
  Widget myWidget;

  MyApp(this.myWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DioHelper();
   // printContacts();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatScreenCubit()
            ..getData()
            ..getChats(),
        ),
      ],
      child: MaterialApp(
        home: myWidget,
        debugShowCheckedModeBanner: false,
      ),
    );
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    //  return MaterialApp(
    //    home: myWidget,
    //    debugShowCheckedModeBanner: false,
    //  );
  }
}
