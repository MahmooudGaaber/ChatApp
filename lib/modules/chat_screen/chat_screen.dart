import 'package:chat_app/modules/chat_screen/cubit/cubit.dart';
import 'package:chat_app/modules/chat_screen/cubit/states.dart';
import 'package:chat_app/modules/contacts_screen/contacts_screen.dart';
import 'package:chat_app/modules/settings_screen/settings_screen.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatScreenCubit , ChatScreenStates>(listener: (BuildContext context, state) {
      if(state is ChatScreenInitialState)
      ChatScreenCubit.get(context).updateStatus();

    }, builder: (BuildContext context, state) {

      Map data = ChatScreenCubit.get(context).data;
      List chats = ChatScreenCubit.get(context).chats;
      print(chats.length);

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: InkWell(
            onTap: (){
              navigateTo(context, SettingScreen());
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:  NetworkImage(data['image']??'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png') ,
                  radius: 15.0,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'Chat App',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.grey,
                size: 30.0,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
                size: 30.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateTo(context, ContactsScreen());
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListView.builder(
                  itemCount: chats.length,

                  itemBuilder: (BuildContext context, int index) => chatBuildItem(chats[index]),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      );
    },

    );
  }
}
