import 'dart:io';
import 'dart:math';
import 'dart:io' as io;


import 'package:audio_recorder/audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/modules/chat_user/cubit/states.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';



class ChatUserCubit extends Cubit<ChatUserStates> {
  ChatUserCubit() : super(ChatUserInitialState());

  static ChatUserCubit get(context) => BlocProvider.of(context);
  Map data = {};
  Map myData = {};
  List messages = [];
  Widget myWidget = Icon(Icons.mic);
  Widget audioWidget = Icon(Icons.play_arrow , size: 24.0,);

  var messageController = TextEditingController();
  Recording _recording =  Recording();
  bool _isRecording = false;
  Random random =  Random();
  AudioPlayer audio = AudioPlayer();
  Duration duration = Duration();
  Duration totalDuration = Duration();
  void getPosition () {
    audio.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      totalDuration = d;
      emit(ChatUserDurationState());

    });
  }
  void changePosition() {
    audio.onAudioPositionChanged.listen((Duration p)  {
      duration = p ;
        emit(ChatUserDurationState());
  });
  }

  void getData(id) {
    emit(ChatUserGetDataState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .snapshots()
        .listen((event) {
      data = event.data();
      emit(ChatUserSuccessState());
      print(data);
    });
  }
  void getMyData() {
    emit(ChatUserGetDataState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .listen((event) {
      myData = event.data();
      emit(ChatUserSuccessState());
      print(data);
    });
  }

  void changeIcon(String s) {
    if (s.length == 0) {
      myWidget = Icon(Icons.mic);
      updateStatus('online');
      emit(ChatUserChangeIconState());
    } else {
      myWidget = Icon(Icons.send);
      updateStatus('typing...');
      emit(ChatUserChangeIconState());
    }
  }
  void changePauseAudioIcon() {
    audioWidget = Icon(Icons.pause , size: 24.0,);
    emit(ChatUserChangeIconState());
  }
  void changePlayAudioIcon() {
    audioWidget = Icon(Icons.play_arrow , size: 24.0,);
    emit(ChatUserChangeIconState());
  }
  void updateStatus (status)
  {
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
      'status' : status
    }
    ).then((value)
    {
    }).catchError((error) {
      print(error.toString());
    });
  }
  void sendMessage ({message , voiceNote = 'no_audio' , int duration} )
  {
    emit(ChatUserSendMessageState());
    DateTime now = DateTime.now();
    String dateFormat = DateFormat.jm().format(now) ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid).collection('chats').doc(data['id']).collection('messages').doc()
        .set({
      'image': '',
      'seen' : '',
      'message' : message,
      'voice_note':voiceNote,
      'voice_duration':duration,
      'sender_id' :FirebaseAuth.instance.currentUser.uid ,
      'sender_image':myData['image'],
      'receiver_image':data['image'],
      'timestamp' : dateFormat ,
      'full_time' : now ,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(data['id']).collection('chats').doc(FirebaseAuth.instance.currentUser.uid).collection('messages').doc()
          .set({
        'image': '',
        'seen' : '',
        'message' : message,
        'voice_note':voiceNote,
        'voice_duration':duration,
        'sender_id' :FirebaseAuth.instance.currentUser.uid ,
        'sender_image':myData['image'],
        'receiver_image':data['image'],
        'timestamp' : dateFormat ,
        'full_time' : now ,
      });

      print('success');
      messageController.clear();
      messageController.text = "";
      emit(ChatUserSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(ChatUserErrorState(error: error));
    });
  }
  void createChat()
  {
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('chats').doc(data['id']).set(data).then((value) {
      FirebaseFirestore.instance.collection('users').doc(data['id']).collection('chats').doc(FirebaseAuth.instance.currentUser.uid).set(myData);
    print('suc');
    emit(ChatUserSuccessState());
    }).catchError((e){
      emit(ChatUserErrorState(error: e));
    });

  }
  void getMessages()
  {
    emit(ChatUserGetMessagesState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid).collection('chats').doc(data['id']).collection('messages').orderBy('full_time' , descending: false).snapshots().listen((event) {
          messages = event.docs;
          emit(ChatUserSuccessState());

    });
  }


  start({@required context}) async {
    await Permission.storage.request();
    await Permission.microphone.request();

    try {
      if (await AudioRecorder.hasPermissions) {


            io.Directory appDocDirectory =
            await getApplicationDocumentsDirectory();
           String path = appDocDirectory.path + '/' + random.nextInt(100000).toString() ;

          print("Start recording: $path");
          await AudioRecorder.start(
              path: path, audioOutputFormat: AudioOutputFormat.AAC);

        bool isRecording = await AudioRecorder.isRecording;

          _recording = new Recording(duration: new Duration(), path: path);
          _isRecording = isRecording;
          emit(ChatUserStartRecordingState());

      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }

   // await AudioPlayer().play('https://firebasestorage.googleapis.com/v0/b/experts-hub.appspot.com/o/users%2F1613597034727.m4a?alt=media&token=ae4dd436-506d-4baa-8d52-b440d0433cf4');
  }

  stop() async {
    var recording = await AudioRecorder.stop();
    int duration = recording.duration.inMinutes;
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder.isRecording;
    File file = File(recording.path);

    uploadFile(file , duration);

    print("  File length: ${await file.length()}");
      _recording = recording;
      _isRecording = isRecording;
    emit(ChatUserStopRecordingState());

  }

  uploadFile(File audio , int duration)
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('audios/${Uri.file(audio.path).pathSegments.last}')
        .putFile(audio)
        .onComplete
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(voiceNote:value.toString() , message: 'no_text' , duration: duration);
        print('success');


      });
    });
  }


}
