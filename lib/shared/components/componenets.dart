

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';


Widget senderBuildItem (data) => Padding(
  padding: const EdgeInsetsDirectional.only(
      top: 15.0, bottom: 15.0, start: 100.0, end: 10.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        data['timestamp'],
        style: TextStyle(color: Colors.black),
      ),
      SizedBox(
        width: 15.0,
      ),
      Flexible(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data['message'],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(15.0),
            ),
          ),
        ),
      ),
    ],
  ),
);
Widget receiverBuildItem (data) => Padding(
  padding: const EdgeInsetsDirectional.only(top: 15.0 , bottom: 15.0 , start: 10.0 , end: 100.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Flexible(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data['message'],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(0.0),
            ),
          ),
        ),
      ),
      SizedBox(
        width: 15.0,
      ),
      Text(
        data['timestamp'],
        style: TextStyle(color: Colors.black),
      ),

    ],
  ),
);
Widget senderVoiceItem (data , function , icon , audio , duration , totalDuration)  => Padding(
    padding: const EdgeInsetsDirectional.only(
        top: 15.0, bottom: 15.0, start: 70.0, end: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          data['timestamp'],
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(
          width: 15.0,
        ),
        Container(
          width: 250.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Stack(
                  alignment: Alignment.bottomRight,
                  children: [

                    CircleAvatar(
                      backgroundImage: NetworkImage(data['sender_image']??'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                      radius: 25.0,
                    ),
                    Positioned(child: Icon(Icons.mic , color: Colors.lightBlue,) , left:33.0,),
                  ],
                ),

                InkWell(child: icon , onTap: function,),
                SizedBox(width: 8.0,),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Container(
                    width: 150.0,
                    child: ProgressBar(
                      progress: duration,

                      total: totalDuration,
                      timeLabelLocation: TimeLabelLocation.below,
                      thumbRadius: 6.0,
                      onSeek: (duration)
                      {
                        audio.seek(duration);
                      },


                    ),
                  ),
                ),

              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(15.0),
            ),
          ),
        ),
      ],
    ),
  );
Widget receiverVoiceItem (data) => Padding(
  padding: const EdgeInsetsDirectional.only(top: 15.0 , bottom: 15.0 , start: 10.0 , end: 100.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        width: 250.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(child: Icon(Icons.play_arrow , size: 24.0,) , onTap: ()async{
                await AudioPlayer().play(data['voice_note']);

              },),
              SizedBox(width: 8.0,),
              Padding(
                padding: const EdgeInsets.only(top: 14.0,),
                child: Container(
                  width: 150.0,

                  child: ProgressBar(
                    progress: Duration(minutes: 0),
                    total: Duration(minutes: 10),
                    timeLabelLocation: TimeLabelLocation.below,
                    thumbRadius: 6.0,


                  ),
                ),
              ),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [

                  CircleAvatar(
                    backgroundImage: NetworkImage(data['receiver_image']??'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                    radius: 25.0,
                  ),
                  Positioned(child: Icon(Icons.mic , color: Colors.lightBlue,) , right:32.0,),
                ],
              ),

            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(0.0),
          ),
        ),
      ),
      SizedBox(
        width: 15.0,
      ),
      Text(
        data['timestamp'],
        style: TextStyle(color: Colors.black),
      ),

    ],
  ),
);

Widget userBuildItem (data) =>  Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(data['image']??'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
          ),
         if (data['status'] == 'online') Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(radius: 6.0, backgroundColor: Colors.green,),
          ) ,

        ],
      ),


      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${data['first_name']} ${data['last_name']}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              data['phone'],
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),

            ),
          ],
        ),
      ),
    ],
  ),
);
void showToast({@required text, isError = false}) => Fluttertoast.showToast(
    msg: text.toString(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isError ? Colors.red : Colors.grey[400],
    textColor: Colors.black,
    fontSize: 16.0);
Widget defaultButton(text , function , padding ) => Padding(
  padding:  EdgeInsets.symmetric(horizontal: padding),
  child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.lightBlue ,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: FlatButton(onPressed: function ,
      child: Text(text.toUpperCase() , style: TextStyle(
        color: Colors.white ,
        fontSize: 16.0 ,

      ),),),
  ),
);
void navigateTo( context , route) =>   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
  return route;
}));
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);
Widget chatBuildItem(data) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  child:   Row(
    children: [
      Stack(
        alignment: Alignment.topRight,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(data['image']??'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
          ),
          Container(
            child: Center(
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
            ),
            height: 20.0,
            width: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue,
              border: Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  '${data['first_name']} ${data['last_name']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                Spacer(),
                Text(
                  '1h',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Message Body',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    ],
  ),
);
void printContacts () async
{
  PermissionStatus status = await Permission.contacts.request();
  if ( status.isGranted)
  {
    await ContactsService.getContacts(withThumbnails: false).then((value) {
      value.forEach((element) {
        print(element.displayName);
      });
    }).catchError((e) => print(e));
  }
}
