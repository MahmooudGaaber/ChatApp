


import 'dart:io';

import 'package:chat_app/modules/register_screen/cubit/cubit.dart';
import 'package:chat_app/modules/register_screen/cubit/states.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterScreen extends StatelessWidget {


  var fNameController = TextEditingController();

  var lNameController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => RegisterScreenCubit(),
      child: BlocConsumer<RegisterScreenCubit , RegisterStates>(listener: (BuildContext context, state) {

      }, builder: (BuildContext context, state) {
        File image = RegisterScreenCubit.get(context).image;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text('Enter Your Data' , style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),),
                SizedBox(height: 25.0,),

                InkWell(
                  onTap: (){
                    RegisterScreenCubit.get(context).pickImage();

                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: (image !=null) ? FileImage(image) : AssetImage('assets/10.png' ,),
                      ),
                      Container(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 14.0,
                        ),
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.lightBlue,

                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.0,),

                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0,),),
                    labelText: 'First Name',


                  ),
                  controller: fNameController,
                ),
                SizedBox(height: 15.0,),

                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0,),),
                    labelText: 'Last Name',


                  ),
                  controller: lNameController,
                ),
                SizedBox(height: 25.0,),
                defaultButton('Start', (){
                  RegisterScreenCubit.get(
                  context).saveUser(id: FirebaseAuth.instance.currentUser.uid , fName: fNameController.text , lName: lNameController.text , context: context);

                }, 0.0),
              ],
            ),
          ),
        );
      },

      ),
    );
  }



}
