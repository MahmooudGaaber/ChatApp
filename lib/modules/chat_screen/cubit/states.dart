abstract class ChatScreenStates {}
class ChatScreenInitialState extends ChatScreenStates{}
class ChatScreenGetDataState extends ChatScreenStates{}
class ChatScreenGetChatsState extends ChatScreenStates{}
class ChatScreenSuccessState extends ChatScreenStates{}
class ChatScreenErrorState extends ChatScreenStates{
  String error ;

  ChatScreenErrorState({this.error});
}