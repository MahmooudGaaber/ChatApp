import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/modules/chat_user/cubit/cubit.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class ChatUserScreen extends StatelessWidget {
  String id;

  ChatUserScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ChatUserCubit()..getData(id);
      },
      child: BlocConsumer<ChatUserCubit, ChatUserStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          ChatUserCubit.get(context).getMyData();
          ChatUserCubit.get(context).getMessages();
          Map data = ChatUserCubit.get(context).data;
          List messages = ChatUserCubit.get(context).messages;
          var messageController = ChatUserCubit.get(context).messageController;
          AudioPlayer audio = ChatUserCubit.get(context).audio;


          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(data['image'] ??
                        'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data['first_name']} ${data['last_name']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          '${data['status']} ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.video_call),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('chats')
                          .doc(data['id'])
                          .collection('messages')
                          .orderBy('full_time', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemBuilder: (BuildContext context, int index)  {
                            if (messages[index]['sender_id'] ==
                                FirebaseAuth.instance.currentUser.uid && messages[index]['message'] == 'no_text' ){
                              ChatUserCubit.get(context).getPosition();
                              ChatUserCubit.get(context).changePosition();

                              return senderVoiceItem(messages[index] , ()async{
                                print('plaaaaay');
                                ChatUserCubit.get(context).changePauseAudioIcon();

                                await audio.play(messages[index]['voice_note']).then((value) {
                                  audio.onPlayerCompletion.listen((event) {
                                    ChatUserCubit.get(context).changePlayAudioIcon();
                                    ChatUserCubit.get(context).duration = Duration(seconds: 0);

                                  });
                                });


                              } , ChatUserCubit.get(context).audioWidget,audio , ChatUserCubit.get(context).duration,ChatUserCubit.get(context).totalDuration,);}
                            else if (messages[index]['sender_id'] ==
                                FirebaseAuth.instance.currentUser.uid && messages[index]['message'] != 'no_text') {
                              return senderBuildItem(messages[index]);
                            }
                            else if (messages[index]['sender_id'] !=
                                FirebaseAuth.instance.currentUser.uid && messages[index]['message'] == 'no_text' )
                            {
                              return receiverVoiceItem(messages[index]);
                            }
                            else
                              {
                                return receiverBuildItem(messages[index]);
                              }
                          },
                          itemCount: messages.length,
                          shrinkWrap: true,
                        );
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.emoji_emotions_outlined),
                                onPressed: () {},
                              ),
                              Expanded(
                                  child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    showToast(
                                        text: 'Please Enter a message ....');
                                  }
                                  return value;
                                },
                                controller: messageController,
                                style: TextStyle(height: 1.5),
                                onChanged: (s) {
                                  ChatUserCubit.get(context).changeIcon(s);
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type a message'),
                              )),
                              IconButton(
                                icon: Icon(Icons.camera_alt_outlined),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      // FloatingActionButton(
                      //   onPressed: () {
                      //     ChatUserCubit.get(context)
                      //         .sendMessage(messageController.text);
                      //     ChatUserCubit.get(context).createChat();
                      //   },
                      //   child: ChatUserCubit.get(context).myWidget,
                      // ),

                      GestureDetector(
                        onTap: ()
                        {
                          ChatUserCubit.get(context).sendMessage(message:messageController.text ,);
                          ChatUserCubit.get(context).createChat();
                        },
                        onLongPressStart: (value)
                        {
                          // if (ChatUserCubit.get(context).myWidget ==
                          //     Icon(Icons.mic) && ChatUserCubit.get(context).messageController.text == "") {
                          //   ChatUserCubit.get(context).start(context: context);
                          //   ChatUserCubit.get(context).createChat();
                          // }

                            ChatUserCubit.get(context).start(context: context);
                            ChatUserCubit.get(context).createChat();
                        },
                        onLongPressUp:()
                        {
                          ChatUserCubit.get(context).stop();
                        } ,
                        child: Container(
                          height: 55.0,
                          width: 55.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue,
                          ),
                          child:ChatUserCubit.get(context).myWidget,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
