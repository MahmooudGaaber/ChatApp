abstract class ContactsStates {}
class ContactsInitialState extends ContactsStates{}
class ContactsGetUsersState extends ContactsStates{}
class ContactsSuccessState extends ContactsStates{}
class ContactsErrorState extends ContactsStates {
  String error;

  ContactsErrorState({this.error});
}
