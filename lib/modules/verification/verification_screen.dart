import 'package:chat_app/modules/register_screen/register_screen.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:code_field/code_field.dart';

class VerificationScreen extends StatelessWidget {
  var codeController = InputCodeControl(inputRegex: '^[0-9]*');
  String smsCode;

  VerificationScreen(this.smsCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                'assets/9.png',
              ),
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Enter your sms code ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 28.0,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InputCodeField(
                    control: codeController,
                    autofocus: true,
                    count: 6,
                    inputType: TextInputType.number,
                    decoration: InputCodeDecoration(
                      focusColor: Colors.lightBlue,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  defaultButton(
                    'Next',
                    () {
                      phoneAuth(codeController.value , context);
                    },
                    0.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void phoneAuth(String code , context) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this.smsCode, smsCode: code);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((value) {
      print(value.user.uid);
      navigateTo(context, RegisterScreen());
    }).catchError((e) {
      showToast(text: 'Error...');
    });
  }
}
