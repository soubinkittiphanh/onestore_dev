import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onestore/getxcontroller/wallet_txn_controller.dart';
import 'package:onestore/widgets/wallet/topup_comp.dart';
import 'package:onestore/widgets/wallet/withdraw_comp.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final f = NumberFormat("#,###.##");
  final walletTxnController = Get.put(WalletTxnController());
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(
      initialPage: _selectedPage,
    );
    void _pageChange(int v) {
      log("INPUT " + v.toString());
      setState(() {
        _selectedPage = v;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: Center(
        // padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Icon(Icons.account_balance_wallet_rounded),
                  Text("ຍອດເຫລືອ"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Balance: "),
                      Text(
                          f.format(walletTxnController.totalCR -
                              walletTxnController.totalDR),
                          style: TextStyle(color: Colors.green))
                    ],
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedPage = 0;
                              });
                            },
                            icon:
                                Icon(Icons.arrow_forward, color: Colors.green)),
                        Icon(Icons.account_balance_wallet_outlined),
                      ],
                    ),
                    const Text("ເຕີມ"),
                    Text(
                      f.format(
                        walletTxnController.totalCR,
                      ),
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                  height: 40,
                  child: const VerticalDivider(
                    // width: 10,
                    thickness: 1,
                    // color: Colors.red,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedPage = 1;
                              });
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.red)),
                        Icon(Icons.account_balance_wallet_outlined),
                      ],
                    ),
                    Text("ຖອນ / ຊື້"),
                    Text(f.format(walletTxnController.totalDR),
                        style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _pageChange,
                children: [
                  TopupComp(),
                  WithdrawComp(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
