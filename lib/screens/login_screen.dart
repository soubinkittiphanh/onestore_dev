import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onestore/screens/register_email.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      body: Center(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.yellow,
                width: 2,
              ),
              color: Colors.cyan,
            ),
            // child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Login"),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email or Phone number',
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Hello");
                    FirebaseFirestore.instance
                        .collection("Testing")
                        .add({'CurrentTime': DateTime.now().toIso8601String()});
                    log("done firestore");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.login), Text('login')],
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => {
                        Navigator.of(context)
                            .pushNamed(RegistEmailScreen.routerName)
                      },
                      child: Text("ລົງທະບຽນ?"),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Hello");
                        FirebaseFirestore.instance.collection("Testing").add(
                            {'CurrentTime': DateTime.now().toIso8601String()});
                        log("done firestore");
                      },
                      child: Text("login"),
                    )
                  ],
                )
              ],
            ),
            // ),
          ),
          Positioned(
            // bottom: 0.0,
            child: Container(
              height: 350,
              width: double.infinity,
              //color: Colors.white,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(180)),
                color: Colors.white,
              ),
              child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN5IdkZGOBECwRAqpYx6HH_Pr4Wy164El1Cg&usqp=CAU"),
            ),
          )
        ]),
      ),
    );
  }
}
