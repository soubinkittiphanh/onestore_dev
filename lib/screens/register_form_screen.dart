import 'package:flutter/material.dart';
import 'package:onestore/models/register_data.dart';
import 'package:onestore/screens/login_screen.dart';
import 'package:onestore/service/register_service.dart';

class RegisterFormScreen extends StatelessWidget {
  const RegisterFormScreen({Key? key, this.email = '', this.phone = ''})
      : super(key: key);
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final txtControllerName = TextEditingController();
    final txtControllerPhone = TextEditingController();
    final txtControllerEmail = TextEditingController();
    final txtControllerGameId = TextEditingController();
    final txtControllerPassword = TextEditingController();
    final txtControllerPasswordConfirm = TextEditingController();
    final getisterFormKey = GlobalKey<FormState>();
    final registerService = RegisterService();
    txtControllerPhone.text = phone;
    txtControllerEmail.text = email;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: getisterFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 80,
                  color: Colors.purple,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: txtControllerName,
                  cursorColor: Colors.purple,
                  style: const TextStyle(fontFamily: "noto san lao"),
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
                if (phone.isNotEmpty)
                  TextFormField(
                    controller: txtControllerPhone,
                    cursorColor: Colors.purple,
                    style: const TextStyle(fontFamily: "noto san lao"),
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'ເບີໂທ',
                      label: const Text('Login ID'),
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
                if (phone.isEmpty)
                  const Text(
                    "ເບີໂທຈຳເປັນຕ້ອງໃສ່ເມື່ອທ່ານ ຕ້ອງການ ກູ້ລະຫັດຜ່ານ",
                  ),
                if (phone.isEmpty)
                  TextFormField(
                    controller: txtControllerPhone,
                    cursorColor: Colors.purple,
                    style: const TextStyle(fontFamily: "noto san lao"),
                    // enabled: false,
                    validator: (phone) {
                      if (phone!.isEmpty || phone.length < 8) {
                        return "ກະລຸນາໃສ່ ເບີໂທໃຫ້ຖືກຕ້ອງ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'ເບີໂທ',
                      label: const Text('Phone number'),
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
                if (email.isNotEmpty)
                  TextFormField(
                    controller: txtControllerEmail,
                    cursorColor: Colors.purple,
                    style: const TextStyle(fontFamily: "noto san lao"),
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      label: const Text('login id'),
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
                  controller: txtControllerGameId,
                  cursorColor: Colors.purple,
                  style: const TextStyle(fontFamily: "noto san lao"),
                  decoration: InputDecoration(
                    hintText: 'ໄອດີ ເກມ',
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: txtControllerPassword,
                  cursorColor: Colors.purple,
                  style: const TextStyle(fontFamily: "noto san lao"),
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: txtControllerPasswordConfirm,
                  cursorColor: Colors.purple,
                  // style: const TextStyle(fontFamily: "noto san lao"),
                  style: const TextTheme().bodyText1,
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
                RaisedButton(
                  onPressed: () async {
                    if (getisterFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      final custData = RegisterData(
                        custName: txtControllerName.text,
                        custPassword: txtControllerPassword.text,
                        custEmail: email,
                        custGameId: txtControllerGameId.text,
                        custTel: txtControllerPhone.text,
                      );
                      dynamic response =
                          await registerService.registerCustomer(custData);
                      if (response == 200) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('ລົງທະບຽນສຳເລັດ ກະລຸນາ ເຂົ້າສູ້ລະບົບ'),
                          ),
                        );

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => const LoginScreen(),
                          ),
                        );
                      } else if (response == 503) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Server error: ຜູ້ໃຊ້ ຊ້ຳກັນ'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'ບໍ່ສາມາດລົງທະບຽນໄດ້ ກະລຸນາລອງໃຫມ່ ພາຍຫລັງ'),
                          ),
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
                          fontFamily: "noto san lao",
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
