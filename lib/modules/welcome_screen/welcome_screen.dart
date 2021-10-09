import 'package:chat_app/modules/login/login.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),

      backgroundColor: Colors.white,
      body: Column(
        children: [

          Expanded(
            child: Image(image: AssetImage('assets/8.png',),
              fit: BoxFit.contain,

            ),
          ),
        Expanded(
          child: Column(
            children: [
              Text('''Take privacy with you
 Be your self in every 
             message. ''' , style: TextStyle(
                fontWeight: FontWeight.w400 ,
                fontSize: 30.0 ,

              ),),
              SizedBox(height: 25.0,),
              Text('Terms & Privacy Policy ' , style: TextStyle(
                color: Colors.grey[700] ,
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
                wordSpacing: 1.0,
              ),),
              SizedBox(height: 20.0,),
              defaultButton('Continue', (){
                navigateTo(context, LoginScreen());
              }  , 30.0 ,),
              SizedBox(height: 10.0,),
              MaterialButton(
                onPressed: () {

                },
                child: Text('Restore Backup ' , style: TextStyle(
                  color: Colors.lightBlue ,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,

                ),),
              ),
              SizedBox(height: 10.0,),

            ],
          ),
        ),

        ],
        ),
    );
    }
}
