abstract class RegisterStates {}
class RegisterInitialState extends RegisterStates{}
class RegisterSetImageState extends RegisterStates{}
class RegisterUploadImageState extends RegisterStates{}
class RegisterUploadDataState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  String error ;

  RegisterErrorState({this.error});
}
