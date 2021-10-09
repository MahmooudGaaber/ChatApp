import 'dart:io';

import 'package:chat_app/modules/chat_screen/chat_screen.dart';
import 'package:chat_app/modules/register_screen/cubit/states.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterScreenCubit extends Cubit<RegisterStates>
{
  RegisterScreenCubit() : super(RegisterInitialState());

  static RegisterScreenCubit get(context) => BlocProvider.of(context);
  File image;
  Future<void> pickImage() async {
    await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = File(value.path);
        emit(RegisterSetImageState());

        print(value.path);
        uploadImage();

      }
    });
  }
  uploadImage()
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .onComplete
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .set({
          'image': value.toString(),
          'first_name' : '',
          'last_name' : '',
          'id' : '',
          'phone' : '',
          'status' : 'online'
        }).then((value) {

          print('success');
          emit(RegisterUploadImageState());

        }).catchError((error) {
          print(error.toString());
          emit(RegisterErrorState(error: error));
        });
      });
    });
  }
  void saveUser({
    fName,
    lName,
    id,
    context,
  }) async {
    FirebaseFirestore.instance.collection('users').doc(id).update({
      'first_name': fName,
      'last_name': lName,
      'id': id,
      'phone' : FirebaseAuth.instance.currentUser.phoneNumber,
    }
    ).then((value)
    {
      emit(RegisterUploadDataState());

      navigateAndFinish(
        context,
        ChatScreen(),

      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error: error));
    });
  }



}