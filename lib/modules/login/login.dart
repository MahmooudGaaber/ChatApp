import 'package:chat_app/modules/verification/verification_screen.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';

class LoginScreen extends StatelessWidget {
 var  codeController = TextEditingController()..text = '+20';
 var  phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0,),
          child: Column(

            children: [
              Text('Enter your phone number to' , style: TextStyle(
                fontWeight: FontWeight.w600 ,
                fontSize: 28.0 ,
              ),) ,
              Text('get started' , style: TextStyle(
                fontWeight: FontWeight.w600 ,
                fontSize: 28.0 ,
              ),) ,
              SizedBox(height: 20.0,),
              Text('you will receive a verification code ' , style: TextStyle(
                fontWeight: FontWeight.w400 ,
                fontSize: 20.0,
              ),) ,
              SizedBox(height: 5.0,),
              Text('Carrier rates may apply.' , style: TextStyle(
                fontWeight: FontWeight.w400 ,
                fontSize: 20.0,
              ),) ,
              SizedBox(height: 30.0 ,),
              Container(
                height: 55.0,
                child: DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: ["Egypt", "Italia", "Tunisia", 'Canada'],
                    hint: "Egypt",
                    selectedItem: "Egypt"),
              ),
              SizedBox(height: 20.0 ,),


              Row(
                children: [
                  Container(
                    width: 80.0,

                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0,),),
                        hintText: '+20',


                      ),
                      controller: codeController,
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      autofocus: true ,
                      controller: phoneController,
                      decoration:InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                        labelText: 'Phone Number',



                    ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0,),
              defaultButton('Next', (){
                phoneVerification(phoneController.text , context);
              }  , 0.0,) ,
            ],

          ),
        ),
      ),
    );
  }
 void phoneVerification( String phone , context) async
 {
   await FirebaseAuth.instance.verifyPhoneNumber(
     phoneNumber: '+20 $phone',

     verificationCompleted: (PhoneAuthCredential credential) {

     },
     verificationFailed: (FirebaseAuthException e) {
       print('hhhhhhhhhhhh');
     },
     codeSent: (String verificationId, int resendToken) {
       navigateTo(context, VerificationScreen(verificationId));

     },
     codeAutoRetrievalTimeout: (String verificationId) {

     },
   );
 }

}
