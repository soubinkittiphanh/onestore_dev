import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/getxcontroller/user_info_controller.dart';
import 'package:onestore/screens/login_screen.dart';
import 'package:onestore/screens/update_user_info_screen.dart';
import 'package:onestore/service/user_info_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,###");
    // final userCreProvider = Provider.of<UserCredentialProvider>(context);
    // final userInfoService = UserInfService();
    final userInfoController = Get.put(UserInfoController());
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

    return LoaderOverlay(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              GestureDetector(
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                  ),
                  title: Text(userInfoController.userName),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                onTap: () {
                  _updateInfo("name", userInfoController.userName);
                },
              ),
              GestureDetector(
                onTap: () {
                  _updateInfo("tel", userInfoController.userPhone);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.phone_android,
                  ),
                  title: Text(userInfoController.userPhone),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _updateInfo("pass", '');
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.security,
                  ),
                  title: Text("********"),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _updateInfo("mail", userInfoController.userEmail);
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.email_outlined,
                  ),
                  title: Text(userInfoController.userEmail),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  context.loaderOverlay.show();
                  final balance = await UserInfService.userbalance(
                      userInfoController.userId);
                  log("Balance: " + balance.toString());
                  userInfoController.setUserBalance(balance);
                  context.loaderOverlay.hide();
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.account_balance_wallet_outlined,
                  ),
                  title: Text(
                    "ຍອດເງິນ: ${f.format(userInfoController.userCredit - userInfoController.userDebit)}",
                    style: const TextStyle(
                      fontFamily: 'noto san lao',
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      context.loaderOverlay.show();
                      final balance = await UserInfService.userbalance(
                          userInfoController.userId);
                      log("Balance: " + balance.toString());
                      userInfoController.setUserBalance(balance);
                      context.loaderOverlay.hide();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const LoginScreen(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: const Text(
                      "ອອກຈາກລະບົບ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "noto san lao",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
