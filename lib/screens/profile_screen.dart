import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onestore/providers/user_credental_provider.dart';
import 'package:onestore/screens/update_user_info_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCreProvider = Provider.of<userCredentailProvider>(context);
    void _updateInfo(String selectMetho, defaultValue) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => UpdateUserScreen(
            fieldUpdate: selectMetho,
            defaultValue: defaultValue,
          ),
        ),
      );
    }

    return Container(
      // color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              GestureDetector(
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                  ),
                  title: Text("${userCreProvider.userName}"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
                onTap: () {
                  _updateInfo("name", userCreProvider.userName);
                },
              ),
              GestureDetector(
                onTap: () {
                  _updateInfo("tel", userCreProvider.userPhone);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.phone_android,
                  ),
                  title: Text("${userCreProvider.userPhone}"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _updateInfo("pass", '');
                },
                child: ListTile(
                  leading: Icon(
                    Icons.security,
                  ),
                  title: Text("********"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _updateInfo("mail", userCreProvider.userEmail);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                  ),
                  title: Text("${userCreProvider.userEmail}"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
