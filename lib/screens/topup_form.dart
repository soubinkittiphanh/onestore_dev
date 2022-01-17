import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/config/const_design.dart';
import 'package:onestore/models/chat_type_model.dart';
import 'package:onestore/service/inquiry_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class TopupForm extends StatefulWidget {
  const TopupForm({Key? key, required this.chatType, required this.userId})
      : super(key: key);
  final ChatTypeModel chatType;

  final String userId;
  @override
  _TopupFormState createState() => _TopupFormState();
}

class _TopupFormState extends State<TopupForm> {
  final txtControllerBankName = TextEditingController();
  final txtControllerBankAccountID = TextEditingController();
  final txtControllerBankAccountName = TextEditingController();
  final txtControllerAmount = TextEditingController();
  final txtControllerRef = TextEditingController();
  final inquiryFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Form(
        key: inquiryFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                // obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: txtControllerBankName,
                cursorColor: Colors.purple,
                // style: const TextStyle(fontFamily: "noto san lao"),
                style: const TextTheme().bodyText1,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "ກະລຸນາ ໃສ່ຊື່ທະນາຄານ";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontFamily: "noto san lao"),
                  hintText: 'ຊື່ທະນາຄານ',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: txtControllerBankAccountID,
                cursorColor: Colors.purple,
                keyboardType: TextInputType.number,

                // style: const TextStyle(fontFamily: "noto san lao"),
                style: const TextTheme().bodyText1,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "ກະລຸນາ ໃສ່ເລກບັນຊີ";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontFamily: "noto san lao"),
                  hintText: 'ເລກບັນຊີ',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: txtControllerBankAccountName,
                cursorColor: Colors.purple,
                // style: const TextStyle(fontFamily: "noto san lao"),
                style: const TextTheme().bodyText1,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "ກະລຸນາ ໃສ່ຊື່ບັນຊີ";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontFamily: "noto san lao"),
                  hintText: 'ຊື່ບັນຊີ',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // obscureText: true,
                keyboardType: TextInputType.number,
                enableSuggestions: false,
                autocorrect: false,
                controller: txtControllerAmount,
                cursorColor: Colors.purple,
                // style: const TextStyle(fontFamily: "noto san lao"),
                style: const TextTheme().bodyText1,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "ກະລຸນາ ໃສ່ຈຳນວນເງິນ";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontFamily: "noto san lao"),
                  hintText: 'ຈຳນວນເງິນ',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: txtControllerRef,
                cursorColor: Colors.purple,
                // style: const TextStyle(fontFamily: "noto san lao"),
                style: const TextTheme().bodyText1,
                validator: (val) {
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontFamily: "noto san lao"),
                  hintText: 'ເລກອ້າງອີງ',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ConstDesign.myButton(context, postData, "ສົ່ງຂໍ້ຄວາມ")
            ],
          ),
        ),
      ),
    );
  }

  String genMessage() {
    return "ສະບາຍດີ ຕ້ອງການ \n " +
        widget.chatType.name +
        "\n ຊື່ທະນາຄານ: " +
        txtControllerBankName.text +
        " \n ເລກບັນຊີ: " +
        txtControllerBankAccountID.text +
        " \n ຊື່ບັນຊີ: " +
        txtControllerBankAccountName.text +
        " \n ຈຳນວນເງິນ: " +
        txtControllerAmount.text +
        " \n ເລກອ້າງອີງ: " +
        txtControllerRef.text +
        " \n" +
        "ລົບກວນແອັດມິນ ກວດສອບ ແລະ ດຳເນີນການໃຫ້ແດ່ ຂອບໃຈ";
  }

  launchWhatsApp() async {
    final link =
        WhatsAppUnilink(phoneNumber: '+8562097489646', text: genMessage());
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }

  Future<void> postData() async {
    if (inquiryFormKey.currentState!.validate()) {
      context.loaderOverlay.show();
      await InquiryService().submitChat(widget.chatType.code, genMessage(),
          widget.userId, notifyMessage, launchWhatsApp);
      context.loaderOverlay.hide();
      // launchWhatsApp();
    }
  }

  void notifyMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'noto san lao',
                color: Colors.white,
              ),
            ),
            Icon(
              message.contains("completed") ? Icons.done : Icons.error,
              color:
                  message.contains("completed") ? Colors.green : Colors.white,
            )
          ],
        ),
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }
}
