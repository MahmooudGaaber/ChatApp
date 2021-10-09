import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: 10.0,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 40.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/4.png'),
                  radius: 40.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text('Mohammed Ebrahim' , style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),) ,
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  FlatButton(
                    height: 40.0,
                    minWidth: 35.0,
                    shape: CircleBorder(),
                    onPressed: () {},
                    child: Icon(
                      Icons.group,
                      size: 14.0,
                    ),
                    color: Colors.grey[300],
                  ),
                    SizedBox(width: 5.0,),
                    Text('5'),
                    SizedBox(width: 30.0,),
                    FlatButton(
                      height: 40.0,
                      minWidth: 35.0,
                      shape: CircleBorder(),
                      onPressed: () {},
                      child: Icon(
                        Icons.question_answer_outlined,
                        size: 14.0,
                      ),
                      color: Colors.grey[300],
                    ),
                    SizedBox(width: 5.0,),
                    Text('5'),
                    SizedBox(width: 30.0,),
                    FlatButton(
                      height: 40.0,
                      minWidth: 35.0,
                      shape: CircleBorder(),
                      onPressed: () {},
                      child: Icon(
                        Icons.notification_important,
                        size: 14.0,
                      ),
                      color: Colors.grey[300],
                    ),
                    SizedBox(width: 5.0,),
                    Text('5'),
                ],),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('Edit Profile'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined , color: Colors.black, size: 13.0,),
                  onTap: (){},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('About Us'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined , color: Colors.black, size: 13.0,),
                  onTap: (){},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('Text Size'),
                  trailing:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Aa', style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),),
                      Container(
                        width: 200.0,
                        child: Slider(
                          max: 50 ,
                          min: 0,
                          value: 25 ,
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                          onChanged: (double value) {  },




                        ),
                      ),
                      Text('Aa', style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),),
                    ],
                  ),
                  onTap: (){},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('Rate This App'),

                  onTap: (){},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('Share The App'),

                  onTap: (){},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('Privacy Policy'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined , color: Colors.black, size: 13.0,),
                  onTap: (){},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('FAQ'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined , color: Colors.black, size: 13.0,),
                  onTap: (){},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('Terms and Conditions'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined , color: Colors.black, size: 13.0,),
                  onTap: (){},
                ),
                Container(
                  height: 10.0,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListTile(
                  title: Text('Contact Us'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined , color: Colors.black, size: 13.0,),
                  onTap: (){},
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 20.0,),
                      Icon(Icons.logout , color: Colors.blue, size: 20.0,),
                      SizedBox(width: 10.0,),
                      Text('Logout' , style: TextStyle(color: Colors.blue , fontSize: 16.0), ),

                    ],
                  ),
                ),
                // ListTile(
                //   title: Text('Logout' , style: TextStyle(color: Colors.blue),),
                //   leading: Icon(Icons.logout , color: Colors.blue, size: 20.0,),
                //   onTap: (){},
                // ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
