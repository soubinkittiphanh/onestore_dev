import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onestore/screens/home.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final fireAuth = FirebaseAuth.instance;
  String _secretOTP = '';
  final TextEditingController userOTP = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _firebaseOTPverification();
    super.initState();
  }

  void _firebaseOTPverification() {
    log("=====> Runing ....");
    fireAuth.verifyPhoneNumber(
        phoneNumber: "+85620${widget.phoneNumber}",
        verificationCompleted: (phoneAuthCredential) {
          log("====>Completed");
          print('${phoneAuthCredential}');
        },
        verificationFailed: (FirebaseAuthException e) {
          log("========> FAIIL");
          print("${e.message}");
        },
        codeSent: (String otpMessage, resentOtp) {
          log("====> OTP SEND");
          _secretOTP = otpMessage;
          log(otpMessage + " OTP Message");
          log(resentOtp.toString() + " => OTP Resent");
        },
        codeAutoRetrievalTimeout: (String timeOutOTP) {
          log("Timerout " + timeOutOTP);
          _secretOTP = timeOutOTP;
        },
        timeout: Duration(
          seconds: 60,
        ));
  }

  void loginUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        // actions: [
        //   IconButton(onPressed: null, icon: Icon(Icons.arrow_back_ios))
        // ],
      ),
      body: Container(
          color: Colors.cyan,
          child: Center(
            child: Column(
              children: [
                Text("OTP Verification "),
                Text("Enter OTP sent to: ${widget.phoneNumber}"),
                CupertinoTextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: TextStyle(
                    // wordSpacing: 30,
                    letterSpacing: 30,
                    fontSize: 30,
                  ),
                  onChanged: (userOTP) {
                    try {
                      if (userOTP.length == 6) {
                        // _firebaseOTPverification();
                        fireAuth
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _secretOTP, smsCode: userOTP))
                            .then((value) async {
                          if (value.user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => MyHomePage(
                                  title: "OneStore",
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('invalid OTP')));
                          }
                        });
                      }
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      log("=> error e ");
                      // _scaffoldkey.currentState.ScaffoldMessenger
                      //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                      // .showSnackBar(SnackBar(content: Text('invalid OTP')));
                      log("Login fail: " + e.toString());
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "ປ່ຽນເບີໃຫມ່",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "Noto San Lao"),
                      ),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        "ບໍ່ໄດ້ຮັບ OTP ສົ່ງລະຫັດໃຫມ່",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "Noto San Lao"),
                      ),
                    ),
                  ],
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )),
    );
  }
}
