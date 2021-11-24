import 'package:flutter/material.dart';
import 'package:onestore/models/register_data.dart';
import 'package:onestore/screens/home.dart';
import 'package:onestore/service/register_service.dart';

class RegisterFormScreen extends StatelessWidget {
  const RegisterFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final txtControllerName = TextEditingController();
    final txtControllerPhone = TextEditingController();
    final txtControllerGameId = TextEditingController();
    final txtControllerPassword = TextEditingController();
    final txtControllerPasswordConfirm = TextEditingController();
    final getisterFormKey = GlobalKey<FormState>();
    final registerService = RegisterService();
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: getisterFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 80,
                  color: Colors.purple,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: txtControllerName,
                  cursorColor: Colors.white,
                  style: TextStyle(fontFamily: "noto san lao"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "ກະລຸນາໃສ່ຊື່ ໃຫ້ຖືກຕ້ອງ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ຊຶ້ ແລະ ນານສະກຸນ',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtControllerPhone,
                  cursorColor: Colors.white,
                  style: TextStyle(fontFamily: "noto san lao"),
                  decoration: InputDecoration(
                    hintText: 'ເບີໂທ',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtControllerGameId,
                  cursorColor: Colors.white,
                  style: TextStyle(fontFamily: "noto san lao"),
                  decoration: InputDecoration(
                    hintText: 'ໄອດີ ເກມ',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: txtControllerPassword,
                  cursorColor: Colors.white,
                  style: TextStyle(fontFamily: "noto san lao"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "ກະລຸນາຕັ້ງລະຫັດຜ່ານ";
                    } else if (val.length < 4) {
                      return "ກະລຸນາຕັ້ງລະຫັດຜ່ານ ໃຫ້ສູງກ່ວາ 4 ໂຕ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ລະຫັດຜ່ານ',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: txtControllerPasswordConfirm,
                  cursorColor: Colors.white,
                  style: TextStyle(fontFamily: "noto san lao"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "ກະລຸນາຢືນຢັນລະຫັດຜ່ານ";
                    } else if (val != txtControllerPassword.text) {
                      return "ລະຫັດຜ່ານບໍ່ຕົງກັນ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ຢືນຢັນ ລະຫັດຜ່ານ',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (getisterFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      final custData = RegisterData(
                        custName: txtControllerName.text,
                        custPassword: txtControllerPassword.text,
                        custEmail: "mail@mail.com",
                        custGameId: txtControllerGameId.text,
                        custTel: txtControllerPhone.text,
                      );
                      dynamic response =
                          await registerService.registerCustomer(custData);
                      if (response == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ລົງທະບຽນສຳເລັດ')),
                        );
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => MyHomePage(title: "title")));
                      } else if (response == 503) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Server error')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'ບໍ່ສາມາດລົງທະບຽນໄດ້ ກະລຸນາລອງໃຫມ່ ພາຍຫລັງ')),
                        );
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
