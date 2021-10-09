import 'package:chat_app/modules/chat_screen/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenCubit extends Cubit<ChatScreenStates> {
  ChatScreenCubit() : super(ChatScreenInitialState());

  static ChatScreenCubit get(context) => BlocProvider.of(context);
  Map data = {};
  List chats = [];

  void getData() {
    emit(ChatScreenGetDataState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      data = value.data();
      print(data);
      emit(ChatScreenSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChatScreenErrorState(error: error));
    });
  }
  void getChats()
  {
    emit(ChatScreenGetChatsState());
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('chats').snapshots().listen((event) {
      chats = event.docs;
      emit(ChatScreenSuccessState());
    });
  }
  void updateStatus ()
  {
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
      'status' : 'online'
    }
    ).then((value)
    {
      emit(ChatScreenSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChatScreenErrorState(error: error));
    });
  }
}
