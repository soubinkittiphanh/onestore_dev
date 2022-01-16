import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:onestore/models/user_info.dart';

class UserCredentialProvidersssss extends ChangeNotifier {
  var userCredentail = UserInfo(
    userName: "",
    token: "",
    userId: "",
    phone: "",
    email: "",
    debit: 0.00,
    credit: 0.00,
  );
  void userinfo(String user, String token, String id, String phone,
      String email, double debit, double credit) {
    userCredentail = UserInfo(
        userName: user,
        token: token,
        userId: id,
        phone: phone,
        email: email,
        debit: debit,
        credit: credit);
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

  double get userCredit {
    return userCredentail.credit;
  }

  double get userDebit {
    return userCredentail.debit;
  }

  void setUserBalance(dynamic bal) {
    log("updateing");
    log("bal credit" + bal[0].toString());
    log("bal debit" + bal[1].toString());
    userCredentail = UserInfo(
      userName: userCredentail.userName,
      token: userCredentail.token,
      userId: userCredentail.userId,
      phone: userCredentail.phone,
      email: userCredentail.email,
      credit: double.parse(bal[0].toString()),
      debit: double.parse(bal[1].toString()),
    );
    log("update completed");
    notifyListeners();
  }
}
