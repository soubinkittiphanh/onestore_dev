import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/providers/user_credental_provider.dart';
import 'package:onestore/service/user_info_service.dart';
import 'package:provider/provider.dart';

enum SelectMeth {
  username,
  userpass,
  usertel,
  usermail,
}

class UpdateUserScreen extends StatelessWidget {
  const UpdateUserScreen(
      {Key? key, required this.fieldUpdate, this.defaultValue = ''})
      : super(key: key);
  final fieldUpdate;
  final defaultValue;

  @override
  Widget build(BuildContext context) {
    var txtUserInputControlloer = TextEditingController();
    txtUserInputControlloer.text = defaultValue;
    final userCreProvider = Provider.of<userCredentailProvider>(context);
    Future<void> _showInfoDialog(String info) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ຂໍ້ມູນ",
                    style: TextStyle(
                        color: Colors.grey, fontFamily: "noto san lao"),
                  ),
                  info.contains("completed")
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                ],
              ),
              content: FittedBox(
                fit: BoxFit.contain,
                child: Text(info),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Okay",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(),
      body: LoaderOverlay(
        overlayOpacity: 1,
        child: Container(
          // color: Colors.yellow,
          margin: EdgeInsets.all(20),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: txtUserInputControlloer,
                  decoration: InputDecoration(
                    hintText: fieldUpdate,
                    labelText: fieldUpdate,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  margin: const EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () async {
                      context.loaderOverlay.show();
                      String respones = '';
                      var selectMeth;
                      switch (fieldUpdate) {
                        case "name":
                          {
                            log("method: => name");
                            selectMeth = SelectMeth.username;
                            respones = await UserInfService.username(
                                userCreProvider.userId,
                                txtUserInputControlloer.text);
                          }

                          break;
                        case "pass":
                          {
                            log("method: => pass");
                            selectMeth = SelectMeth.userpass;
                            respones = await UserInfService.userpass(
                                userCreProvider.userId,
                                txtUserInputControlloer.text);
                          }

                          break;
                        case "tel":
                          {
                            log("method: => tel");
                            selectMeth = SelectMeth.usertel;
                            respones = await UserInfService.usertel(
                                userCreProvider.userId,
                                txtUserInputControlloer.text);
                          }

                          break;
                        case "mail":
                          {
                            log("method: => mail");
                            selectMeth = SelectMeth.usermail;
                            respones = await UserInfService.useremail(
                                userCreProvider.userId,
                                txtUserInputControlloer.text);
                          }

                          break;
                        default:
                          {
                            log("Invalid function");
                          }
                      }
                      context.loaderOverlay.hide();
                      await _showInfoDialog(respones);
                      if (respones.contains("completed")) {
                        switch (selectMeth) {
                          case SelectMeth.username:
                            {
                              userCreProvider.userinfo(
                                txtUserInputControlloer.text,
                                userCreProvider.userToken,
                                userCreProvider.userId,
                                userCreProvider.userPhone,
                                userCreProvider.userEmail,
                              );
                            }
                            break;
                          case SelectMeth.usertel:
                            {
                              userCreProvider.userinfo(
                                userCreProvider.userName,
                                userCreProvider.userToken,
                                userCreProvider.userId,
                                txtUserInputControlloer.text,
                                userCreProvider.userEmail,
                              );
                            }
                            break;
                          case SelectMeth.usermail:
                            {
                              userCreProvider.userinfo(
                                userCreProvider.userName,
                                userCreProvider.userToken,
                                userCreProvider.userId,
                                userCreProvider.userPhone,
                                txtUserInputControlloer.text,
                              );
                            }
                            break;
                          default:
                        }

                        Navigator.of(context).pop();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints: const BoxConstraints(
                            maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: const Text(
                          "ບັນທຶກ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "noto san lao"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
