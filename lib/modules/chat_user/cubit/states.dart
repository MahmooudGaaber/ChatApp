abstract class ChatUserStates {}
class ChatUserInitialState extends ChatUserStates{}
class ChatUserChangeIconState extends ChatUserStates{}
class ChatUserSendMessageState extends ChatUserStates{}
class ChatUserStartRecordingState extends ChatUserStates{}
class ChatUserStopRecordingState extends ChatUserStates{}
class ChatUserDurationState extends ChatUserStates{}
class ChatUserGetDataState extends ChatUserStates{}
class ChatUserGetMessagesState extends ChatUserStates{}
class ChatUserSuccessState extends ChatUserStates{}
class ChatUserErrorState extends ChatUserStates{
  String error ;

  ChatUserErrorState({this.error});
}