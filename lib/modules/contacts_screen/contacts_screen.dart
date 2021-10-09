import 'package:chat_app/modules/chat_user/chat_user.dart';
import 'package:chat_app/modules/contacts_screen/cubit/cubit.dart';
import 'package:chat_app/modules/contacts_screen/cubit/states.dart';
import 'package:chat_app/shared/components/componenets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContactsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ContactsCubit()..getUsers(),
      child: BlocConsumer<ContactsCubit , ContactsStates>(listener: (BuildContext context, state) {

      }, builder: (BuildContext context, state) {
        List users = ContactsCubit.get(context).users;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Select contact',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'All Contacts',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListView.separated(itemBuilder: (BuildContext context, int index) => InkWell( onTap: (){
                  navigateTo(context, ChatUserScreen(id: users[index]['id'],));
                },child: userBuildItem(users[index])), itemCount: users.length, separatorBuilder: (BuildContext context, int index) => Container(
                  color: Colors.grey[300],
                  height: 1.0,

                ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),),
              ],
            ),
          ),
        );
      },

      ),
    );
  }

}
