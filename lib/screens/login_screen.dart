import 'dart:convert';
import 'dart:developer';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/config/host_con.dart';
import 'package:onestore/providers/user_credental_provider.dart';
import 'package:onestore/screens/home.dart';
import 'package:onestore/screens/register_email.dart';
import 'package:onestore/screens/register_form_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _txtUserController = TextEditingController();
    final _txtPassController = TextEditingController();
    final userCreProvider = Provider.of<userCredentailProvider>(context);
    Future<void> _showInfoDialog(String info) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Material"),
              content: Text(
                info,
                style: TextStyle(fontFamily: "Noto san lao"),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"),
                ),
              ],
            );
          });
    }

    void _login() async {
      context.loaderOverlay.show();
      var uri = Uri.parse(Hostname + "cus_auth");
      final response = await http.post(
        uri,
        body: jsonEncode({
          "cus_id": _txtUserController.text,
          "cus_pwd": _txtPassController.text
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        log("response: => " + response.body);
        var responseJson = convert.jsonDecode(response.body);
        String token = responseJson["accessToken"];
        if (token.isEmpty) {
          await _showInfoDialog("ລະຫັດຜ່ານ ຫລື ໄອດີບໍ່ຖືກຕ້ອງ");
        } else {
          String name = responseJson["userName"];
          String id = responseJson["userId"].toString();
          String phone = responseJson["userPhone"].toString();
          String email = responseJson["userEmail"].toString();
          log(responseJson["accessToken"]);
          log(responseJson["userName"]);
          userCreProvider.userinfo(name, token, id, phone, email);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => MyHomePage(title: "OneStore")));
        }
      } else {
        log("error: " + response.body);
        await _showInfoDialog("ເກີດຂໍ້ຜິດພາດທາງເຊີເວີ: " + response.body);
      }
      context.loaderOverlay.hide();
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),
      resizeToAvoidBottomInset: false,
      body: LoaderOverlay(
        child: Center(
          child: Stack(children: [
            Container(
              // height: deviceSize.height * 0.2,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.yellow,
                //   width: 2,
                // ),
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
                          controller: _txtUserController,
                          cursorColor: Colors.white,
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
                          controller: _txtPassController,
                          cursorColor: Colors.white,
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
                    onPressed: _login,
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
                          // Navigator.of(context)
                          //     .pushNamed(RegistEmailScreen.routerName)
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterFormScreen(),
                            ),
                          )
                        },
                        child: Text("ລົງທະບຽນ?"),
                      ),
                      TextButton(
                        onPressed: () {
                          print("Hello");
                          FirebaseFirestore.instance.collection("Testing").add({
                            'CurrentTime': DateTime.now().toIso8601String()
                          });
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
                height: deviceSize.height * 0.35,
                width: double.infinity,
                //color: Colors.white,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(180)),
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.red),
                ),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN5IdkZGOBECwRAqpYx6HH_Pr4Wy164El1Cg&usqp=CAU",
                  // height: deviceSize.height * 0.15,
                  fit: BoxFit.scaleDown,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
