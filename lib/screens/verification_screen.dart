import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loader_overlay/loader_overlay.dart';
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

  void _firebaseOTPverification() async {
    log("=====> Runing ....");
    // context.loaderOverlay.show();
    await fireAuth.verifyPhoneNumber(
      phoneNumber: "+856${widget.phoneNumber}",
      verificationCompleted: (phoneAuthCredential) {
        log("====>Completed");
        print('${phoneAuthCredential}');
        // context.loaderOverlay.hide();
        _loginUser();
      },
      verificationFailed: (FirebaseAuthException e) {
        log("========> FAIIL");
        print("${e.message}");
        // context.loaderOverlay.hide();
      },
      codeSent: (String otpMessage, resentOtp) {
        log("====> OTP SEND");
        setState(() {
          _secretOTP = otpMessage;
        });
        log(otpMessage + " OTP Message");
        log(resentOtp.toString() + " => OTP Resent");
        // context.loaderOverlay.hide();
      },
      codeAutoRetrievalTimeout: (String timeOutOTP) {
        log("Timerout " + timeOutOTP);
        _secretOTP = timeOutOTP;
        // context.loaderOverlay.hide();
      },
      timeout: Duration(
        seconds: 60,
      ),
    );
    // context.loaderOverlay.hide();
  }

  void _loginUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MyHomePage(
          title: "OneStore",
        ),
      ),
    );
  }

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
      body: LoaderOverlay(
        overlayOpacity: 0.5,
        child: Container(
            color: Colors.cyan,
            child: Center(
              child: Column(
                children: [
                  Text("OTP Verification "),
                  if (_secretOTP.isNotEmpty)
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
                          context.loaderOverlay.show();
                          // _firebaseOTPverification();
                          fireAuth
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _secretOTP,
                                      smsCode: userOTP))
                              .then((value) async {
                            if (value.user != null) {
                              context.loaderOverlay.hide();
                              _loginUser();
                            } else {
                              context.loaderOverlay.hide();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('invalid OTP'),
                                ),
                              );
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
                        onPressed: _firebaseOTPverification,
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
      ),
    );
  }
}
