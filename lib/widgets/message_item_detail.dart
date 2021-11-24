import 'package:flutter/material.dart';
import 'package:onestore/models/inbox_message.dart';

class MessageItemDetail extends StatelessWidget {
  const MessageItemDetail({Key? key, required this.inboxmessage})
      : super(key: key);
  final InboxMessage inboxmessage;
  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();
    final pasController = TextEditingController();
    final balController = TextEditingController();
    idController.text = inboxmessage.messageBody.split("|").first;
    if (inboxmessage.messageBody.contains("|")) {
      pasController.text = inboxmessage.messageBody.split("|")[1];
      balController.text = inboxmessage.messageBody.split("|")[2];
    }
    return Scaffold(
      appBar: (AppBar(
        actions: [],
      )),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: idController,
                      decoration: InputDecoration(
                        labelText: "ໄອດິ",
                        labelStyle: TextStyle(fontFamily: "noto san lao"),
                        icon: Icon(
                          Icons.person,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 0.3,
                          ),
                        ),
                      ),
                      cursorColor: Colors.blue,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: pasController,
                      decoration: InputDecoration(
                        labelText: "ລະຫັດຜ່ານ",
                        labelStyle: TextStyle(fontFamily: "noto san lao"),
                        icon: Icon(Icons.security),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 0.3,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: balController,
                      decoration: InputDecoration(
                        labelText: "ຍອດເງິນ",
                        labelStyle: TextStyle(fontFamily: "noto san lao"),
                        icon: Icon(
                          Icons.account_balance_wallet_sharp,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
