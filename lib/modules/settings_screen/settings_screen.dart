import 'package:chat_app/modules/chat_screen/cubit/cubit.dart';
import 'package:chat_app/modules/chat_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatScreenCubit , ChatScreenStates>(listener: (BuildContext context, state) {

    }, builder: (BuildContext context, state) {
      var data = ChatScreenCubit.get(context).data;
      return  Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [

                    CircleAvatar(
                      backgroundImage:   NetworkImage(data['image']) ,
                      radius: 30.0,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data['first_name']} ${data['last_name']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(data['phone']),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.message_outlined , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SMS and MMS' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),
                        SizedBox(height: 5.0,),
                        Text('Off'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.notifications_none_outlined , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Notifications' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),
                        SizedBox(height: 5.0,),
                        Text('On'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.lock_outline , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Privacy' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),
                        SizedBox(height: 5.0,),
                        Text('Screen lock off , Registration lock off'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.brightness_4 , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Appearance' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),
                        SizedBox(height: 5.0,),
                        Text('Theme System default , Language System default'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.image_outlined , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chats and Media' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.sd_storage_outlined , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Storage' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.link_outlined , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Linked Devices' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.help_outline , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Help' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.desktop_windows_outlined , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Advanced' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
                Row(
                  children: [
                    SizedBox(width: 5.0,),
                    Icon(Icons.favorite_outline , color: Colors.grey,size: 28.0,) ,
                    SizedBox(width: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Donate' , style: TextStyle(
                          fontWeight: FontWeight.w400 ,
                          fontSize: 17.0,
                        ),),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0,),
              ],
            ),
          ),
        ),
      );
    },

    );
  }
}
