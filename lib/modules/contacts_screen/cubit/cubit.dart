import 'package:chat_app/modules/contacts_screen/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsCubit extends Cubit<ContactsStates> {
  ContactsCubit() : super(ContactsInitialState());

  static ContactsCubit get(context) => BlocProvider.of(context);
  List users = [];

  void getUsers() {
    emit(ContactsGetUsersState());
    FirebaseFirestore.instance.collection('users').snapshots().listen((
        event) {
      users = event.docs;
      emit(ContactsSuccessState());
    });
  }
}