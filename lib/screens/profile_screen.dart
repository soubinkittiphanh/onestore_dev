import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onestore/widgets/textfield_comp.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'ໍຊື່ຜູ້ໃຊ້ງານ',
                    icon: CircleAvatar(
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                  )),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'ເບີໂທລະສັບ',
                  hintText: 'ໍຊື່ຜູ້ໃຊ້ງານ',
                  icon: CircleAvatar(
                    child: Icon(
                      Icons.phone,
                    ),
                  ),
                ),
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'ລະຫັດຜ່ານ',
                  hintText: 'ໍຊື່ຜູ້ໃຊ້ງານ',
                  icon: CircleAvatar(
                    child: Icon(
                      Icons.password,
                    ),
                  ),
                ),
              ),
              const TextFieldComp(
                lable: 'ອີເມວ',
                hintlable: 'email',
                icon: Icon(Icons.email),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
