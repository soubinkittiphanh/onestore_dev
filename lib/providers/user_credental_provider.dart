import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:onestore/models/user_info.dart';

class userCredentailProvider extends ChangeNotifier {
  var userCredentail =
      UserInfo(userName: "", token: "", userId: "", phone: "", email: "");
  void userinfo(
    String user,
    String token,
    String id,
    String phone,
    String email,
  ) {
    userCredentail = UserInfo(
        userName: user, token: token, userId: id, phone: phone, email: email);
    log("Done user info");
    notifyListeners();
  }

  String get userName {
    return userCredentail.userName;
  }

  String get userId {
    return userCredentail.userId;
  }

  String get userToken {
    return userCredentail.token;
  }

  String get userPhone {
    return userCredentail.phone;
  }

  String get userEmail {
    return userCredentail.email;
  }
}
