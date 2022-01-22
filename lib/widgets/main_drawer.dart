import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onestore/getxcontroller/user_info_controller.dart';
import 'package:onestore/screens/printer_screen.dart';
import 'package:onestore/screens/wallet_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key, required this.fuctionOntap}) : super(key: key);
  final List<Function> fuctionOntap;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    final userInfoController = Get.put(UserInfoController());
    return Drawer(
      child: ListView(
        children: [
          AppBar(
            title: Text(userInfoController.userName),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: const Text(
              "ສິນຄ້າ",
              style: TextStyle(fontFamily: 'noto san lao'),
            ),
            onTap: () {
              widget.fuctionOntap[0](0);
            },
          ),
          SizedBox(
            width: double.infinity,
            height: 0.1,
            child: Container(
              color: Colors.red,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag_sharp,
              color: Colors.red,
            ),
            onTap: () {
              widget.fuctionOntap[1](1);
            },
            title: const Text("ກະຕ່າສິນຄ້າ",
                style: TextStyle(fontFamily: 'noto san lao')),
          ),
          SizedBox(
            width: double.infinity,
            height: 0.1,
            child: Container(
              color: Colors.red,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_today,
              color: Colors.red,
            ),
            onTap: () {
              widget.fuctionOntap[2](2);
            },
            title: const Text("ລາຍການສັ່ງຊື້",
                style: TextStyle(fontFamily: 'noto san lao')),
          ),
          SizedBox(
            width: double.infinity,
            height: 0.1,
            child: Container(
              color: Colors.red,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              widget.fuctionOntap[3](3);
            },
            title: const Text("ລາຍການທີ່ມັກ",
                style: TextStyle(fontFamily: 'noto san lao')),
          ),
          SizedBox(
            width: double.infinity,
            height: 0.1,
            child: Container(
              color: Colors.red,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.mail,
              color: Colors.red,
            ),
            onTap: () {
              widget.fuctionOntap[3](4);
            },
            title: const Text("ກ່ອງຂໍ້ຄວາມ",
                style: TextStyle(fontFamily: 'noto san lao')),
          ),
          SizedBox(
            width: double.infinity,
            height: 0.1,
            child: Container(
              color: Colors.red,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.red,
            ),
            onTap: () {
              log("RUNNING");
              widget.fuctionOntap[4](5);
            },
            title: const Text("ຂໍ້ມູນສ່ວນຕົວ",
                style: TextStyle(fontFamily: 'noto san lao')),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_balance_wallet,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const WalletScreen()));
            },
            title: const Text("Wallet",
                style: TextStyle(fontFamily: 'noto san lao')),
          ),
          ListTile(
            leading: const Icon(
              Icons.print,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const PrinterSetting()));
            },
            title: const Text("Printer",
                style: TextStyle(fontFamily: 'noto san lao')),
          ),
        ],
      ),
    );
  }
}
