import 'package:flutter/material.dart';
import 'package:onestore/screens/verification_screen.dart';

class RegistEmailScreen extends StatelessWidget {
  const RegistEmailScreen({Key? key}) : super(key: key);
  static const routerName = "register-email";

  @override
  Widget build(BuildContext context) {
    String phoneNumber = '';
    TextEditingController _textPhoneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        // actions: [IconButton(onPressed: null, icon: Icon(Icons.arrow_back))],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          color: Colors.cyan,
        ),
        // color: Colors.green,
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _textPhoneController,
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  onChanged: (str) {
                    phoneNumber = str.trim();
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    label: Text(
                      'ເບີໂທລະສັບ ຫລື ອີເມວ',
                      style: Theme.of(context).textTheme.bodyText2,
                      // style: TextStyle(
                      //   fontFamily: 'Noto San Lao',
                      // ),
                      textAlign: TextAlign.right,
                    ),
                    hintText: '20 99999999',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
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
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => VerificationScreen(
                          phoneNumber: phoneNumber.replaceAll(
                            ' ',
                            '',
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.navigate_next),
                  label: Text(
                    "next",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
