import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/screens/home.dart';
import 'package:email_auth/email_auth.dart';
import 'package:onestore/service/firbase_service.dart';

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
  String errorMessage = '';
  String _secretOTP = '';
  final TextEditingController userOTP = TextEditingController();
  final firebaseService = FirebaseService();

  @override
  void initState() {
    // TODO: implement initState
    _firebaseOTPverification();

    super.initState();
  }

  void _firebaseOTPverification() async {
    log("=====> Runing ....");
    context.loaderOverlay.show();
    await fireAuth.verifyPhoneNumber(
      phoneNumber: "+856${widget.phoneNumber}",
      verificationCompleted: (phoneAuthCredential) {
        log("====>Completed");
        print('${phoneAuthCredential}');
        context.loaderOverlay.hide();
        // _loginUser();
      },
      verificationFailed: (FirebaseAuthException e) {
        context.loaderOverlay.hide();
        log("========> FAIIL");
        print("${e.message}");
        if (e.message
            .toString()
            .contains("Please enter the phone number in a format")) {
          setState(() {
            errorMessage =
                "ກະລຸນາກວດສອບ ຮູບແບບເບີໂທໃຫ້ຖືກຕ້ອງ ເຊັ່ນ: 20 9999 9999";
          });
        } else {
          setState(() {
            errorMessage = e.message.toString();
          });
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 20,
            content: Text(
              "${errorMessage}",
              style: TextStyle(fontFamily: "Noto San Lao"),
            ),
            duration: Duration(
              seconds: 20,
            ),
          ),
        );
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

  @override
  Widget build(BuildContext context) {
    Future<void> _loginUser(userOTP) async {
      try {
        // _firebaseOTPverification();
        await fireAuth
            .signInWithCredential(PhoneAuthProvider.credential(
                verificationId: _secretOTP, smsCode: userOTP))
            .then((value) async {
          if (value.user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const MyHomePage(
                  title: "OneStore",
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('invalid OTP'),
              ),
            );
          }
        });
      } catch (e) {
        FocusScope.of(context).unfocus();
        log("=> error e ");
        // if(e)
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 20,
            content: Text(
              "${e}",
              style: TextStyle(fontFamily: "Noto San Lao"),
            ),
            duration: Duration(
              seconds: 20,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: LoaderOverlay(
        overlayOpacity: 0.5,
        child: Container(
            color: Colors.cyan,
            child: Center(
              child: Column(
                children: [
                  const Text("OTP Verification "),
                  _secretOTP.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Enter OTP sent to: ${widget.phoneNumber}"),
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ],
                        )
                      : errorMessage.isEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ກຳລັງສົ່ງ OTP ....",
                                  style: TextStyle(fontFamily: "Noto san lao"),
                                ),
                                Icon(
                                  Icons.access_time_rounded,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ເກີດຂໍ້ຜິດພາດ",
                                  style: TextStyle(fontFamily: "Noto san lao"),
                                ),
                                Icon(
                                  Icons.close_outlined,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                  CupertinoTextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    style: const TextStyle(
                      // wordSpacing: 30,
                      letterSpacing: 30,
                      fontSize: 30,
                    ),
                    onChanged: (userOTP) async {
                      if (userOTP.length == 6) {
                        context.loaderOverlay.show();
                        await _loginUser(userOTP);
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
                        child: const Text(
                          "ປ່ຽນເບີໃຫມ່",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "Noto San Lao"),
                        ),
                      ),
                      TextButton(
                        onPressed: _firebaseOTPverification,
                        child: const Text(
                          "ບໍ່ໄດ້ຮັບ OTP ສົ່ງລະຫັດໃຫມ່",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "Noto San Lao"),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await firebaseService.registerWithEmailAndPassword(
                              "billboyslm@gmail.com", "admin1000333");
                        },
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "Noto San Lao"),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await firebaseService.loginWithEmail(
                              "billboyslm@gmail.com", "admin1000333");
                        },
                        child: const Text(
                          "Login",
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
