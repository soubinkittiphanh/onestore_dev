import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onestore/getxcontroller/wallet_txn_controller.dart';

class WithdrawComp extends StatelessWidget {
  const WithdrawComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,###");
    final walletTxnController = Get.put(WalletTxnController());
    return Center(
      child: GetBuilder<WalletTxnController>(builder: (ctr) {
        return ListView.builder(
          itemBuilder: (ctx, id) => ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ctr.loadWalletTxnDR[id].date.split("T").first +
                    " " +
                    ctr.loadWalletTxnDR[id].date
                        .split("T")
                        .last
                        .substring(0, 8)),
                Text(
                  ctr.loadWalletTxnDR[id].txn,
                  style: TextStyle(fontFamily: "noto san lao"),
                ),
              ],
            ),
            subtitle: Text(
              f.format(ctr.loadWalletTxnDR[id].amount),
              style: TextStyle(color: Colors.red),
            ),
          ),
          itemCount: walletTxnController.loadWalletTxnDR.length,
        );
      }),
    );
  }
}
