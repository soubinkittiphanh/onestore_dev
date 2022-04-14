import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/api/pdf_api.dart';
import 'package:onestore/getxcontroller/cart_controller.dart';
import 'package:onestore/getxcontroller/message_controller.dart';
import 'package:onestore/getxcontroller/order_controller.dart';
import 'package:onestore/getxcontroller/printer_check_constroller.dart';
import 'package:onestore/getxcontroller/product_controller.dart';
import 'package:onestore/getxcontroller/user_info_controller.dart';
import 'package:onestore/helper/order_helper.dart';
import 'package:onestore/helper/printer_helper.dart';
import 'package:onestore/models/inbox_message.dart';
import 'package:onestore/models/order.dart';
import 'package:onestore/screens/login_screen.dart';
import 'package:onestore/screens/printer_screen.dart';
import 'package:onestore/service/product_service.dart';
import 'package:onestore/service/user_inbox_service.dart';
import 'package:onestore/service/user_info_service.dart';
import 'package:onestore/service/wallet_txn_service.dart';
import 'package:onestore/widgets/cart_overview/cart_overview_action.dart';

class CartOviewComp extends StatefulWidget {
  const CartOviewComp({Key? key, required this.pageChange}) : super(key: key);
  final Function pageChange;
  @override
  State<CartOviewComp> createState() => _CartOviewCompState();
}

class _CartOviewCompState extends State<CartOviewComp> {
  final f = NumberFormat("#,###");
  final proController = Get.put(ProductController());
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    // final cartItem = cartController.cartItem;
    final orderController = Get.put(OrderController());

    final messageController = Get.put(MessageController());
    final productService = ProductService();
    final printerConnectionCheckController = Get.put(PrinterConnectionCheck());
    List<Order> loadOrder = orderController.orderItemNotDuplicate;
    final userInfoController = Get.put(UserInfoController());
    // Future _loadExternaleData() async {
    //   loadOrder = await OrderHelper.fetchOrder(
    //       userInfoController.userId, _selectedDateFrom, _selectedDateTo);
    //   orderController.setOrderItem(loadOrder);
    //   messageController.setloadMessage(await UserInboxService.getInbox(
    //       userInfoController.userId, userInfoController.userName));
    //   //*********UPDATE WALLET BALANCE**********//
    //   WalletTxnService.loadTxn(userInfoController.userId);
    //   //*********UPDATE PRODUCT STOCK UI**********//
    //   productService.loadProduct();
    // }

    Future _loadMessage() async {
      log("====> Load inbox message " + DateTime.now().toString());
      await messageController.setloadMessage(await UserInboxService.getInbox(
          userInfoController.userId, userInfoController.userName));
      log("====> Load inbox message done" + DateTime.now().toString());
      //*********UPDATE WALLET BALANCE**********//
      WalletTxnService.loadTxn(userInfoController.userId);
      //*********UPDATE PRODUCT STOCK UI**********//
      productService.loadProduct();
    }

    Future _loadMaxOrder() async {
      loadOrder = await OrderHelper.fetchMaxOrder(userInfoController.userId);
      orderController.setOrderItem(loadOrder);
    }

    Future<bool> _isPrintCon() async {
      final isconnect = await PrintHelper.checkPrinter();
      return isconnect;
    }

    Future<void> _showInfoDialogIos(String info) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoaderOverlay(
            child: CupertinoAlertDialog(
              title: const Text(
                "ລາຍງານ",
                style: TextStyle(fontFamily: 'noto san lao'),
              ),
              content: FittedBox(
                child: Column(
                  children: [
                    Text(
                      info,
                      style: const TextStyle(fontFamily: 'noto san lao'),
                    ),
                    info.contains("complete")
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 50,
                          )
                        : const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 50,
                          )
                  ],
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                if (info.contains("complete"))
                  CupertinoDialogAction(
                    child: const Text(
                      "ພິມບິນ",
                      style: TextStyle(
                        fontFamily: "noto san lao",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      context.loaderOverlay.show();
                      log("=====> Loading max order id " +
                          DateTime.now().toString());
                      await _loadMaxOrder();
                      log("=====> Loading max order id completed " +
                          DateTime.now().toString());
                      if (!await _isPrintCon() &&
                          printerConnectionCheckController
                              .isPrinterCheckEnable()) {
                        context.loaderOverlay.hide();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const PrinterSetting()));
                        return;
                      }

                      log("=====> Finding max order id " +
                          DateTime.now().toString());
                      int maxOrderId = 0;
                      for (var i = 0; i < loadOrder.length; i++) {
                        if (int.parse(loadOrder[i].orderId) > maxOrderId) {
                          maxOrderId = int.parse(loadOrder[i].orderId);
                        }
                      }
                      log("=====> Finding max order id completed " +
                          DateTime.now().toString());
                      late File file;
                      log("=====> Loading message " +
                          DateTime.now().toString());
                      await _loadMessage();
                      log("=====> Loading message completed " +
                          DateTime.now().toString());
                      List<InboxMessage> messageList = messageController
                          .messageByOrderID(maxOrderId.toString());
                      log("=====> Generate bill pdf " +
                          DateTime.now().toString());
                      for (var item in messageList) {
                        file = await PdfApi.generatePdf(item);
                      }
                      log("=====> Generate bill pdf completed " +
                          DateTime.now().toString());
                      context.loaderOverlay.hide();
                      PdfApi.openFile(file);
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
          );
        },
      );
    }

    Future<void> _showInfoDialogAndroid(String info) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoaderOverlay(
              child: AlertDialog(
                title: const Text(
                  "ລາຍງານ",
                  style: TextStyle(fontFamily: 'noto san lao'),
                ),
                content: FittedBox(
                  child: Column(
                    children: [
                      Text(
                        info,
                        style: const TextStyle(fontFamily: 'noto san lao'),
                      ),
                      info.contains("complete")
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 50,
                            )
                          : const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 50,
                            )
                    ],
                  ),
                ),
                actions: [
                  if (info.contains("complete"))
                    TextButton(
                      onPressed: () async {
                        context.loaderOverlay.show();
                        if (!await _isPrintCon() &&
                            printerConnectionCheckController
                                .isPrinterCheckEnable()) {
                          context.loaderOverlay.hide();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const PrinterSetting()));
                          return;
                        }

                        await _loadMaxOrder();
                        int maxOrderId = 0;
                        for (var i = 0; i < loadOrder.length; i++) {
                          if (int.parse(loadOrder[i].orderId) > maxOrderId) {
                            maxOrderId = int.parse(loadOrder[i].orderId);
                          }
                        }
                        late File file;
                        await _loadMessage();
                        List<InboxMessage> messageList = messageController
                            .messageByOrderID(maxOrderId.toString());
                        for (var item in messageList) {
                          file = await PdfApi.generatePdf(item);
                        }
                        context.loaderOverlay.hide();
                        Navigator.pop(context);
                        PdfApi.openFile(file);
                      },
                      child: const Text(
                        "ພິມບິນ",
                        style: TextStyle(
                          fontFamily: "noto san lao",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          });
    }

    String _customResMessage(String res) {
      List<String> subList;
      String reMessage;
      if (res.contains("ສິນຄ້າ")) {
        subList = res.split("|").toList();
        reMessage = proController.productId(int.parse(subList[1])).proName;
        return subList[0] + " " + reMessage + " " + subList[2];
      }
      if (res.contains("TokenExpired")) {
        res = 'Token ຫມົດອາຍຸ ກະລຸນາ ເຂົ້າສູ່ລະບົບໃຫມ່';
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const LoginScreen(),
          ),
        );
      }
      return res;
    }

    void placeOrder() async {
      log("object");
      // sendOrder(cartItem);
      context.loaderOverlay.show();
      final cartItem = cartController.cartItem;
      log("ORDER LEN: " + cartItem.length.toString());
      //IF ORDER LEN < 1 MEANING NO ORDER TAKEN
      if (cartItem.isEmpty) {
        String res = "No order taken";
        context.loaderOverlay.hide();
        return Platform.isIOS
            ? await _showInfoDialogIos(_customResMessage(res))
            : await _showInfoDialogAndroid(_customResMessage(res));
      }
      // chack user balance and order price
      final balance =
          await UserInfService.userbalance(userInfoController.userId);
      double currentBalance = balance[2];
      double orderTotalPrice = cartItem.fold(
          0, (previousValue, element) => element.priceTotal + previousValue);
      log("Bal: " + currentBalance.toString());
      log("Sum: " + orderTotalPrice.toString());
      String res = '';
      if (orderTotalPrice > currentBalance) {
        res = 'ຂໍອາໄພ ຍອດເງິນບໍ່ພຽງພໍ';
      } else {
        log("======> Sending order" + DateTime.now().toString());
        res = await OrderHelper.sendOrder(
            cartItem, userInfoController.userId, userInfoController.userToken);
        log("RESPONSE: " + res);
        if (res.endsWith("completed")) {
          log("======> Sending inbox req completed " +
              DateTime.now().toString());
          cartItem.length = 0;
          cartController.clearCartItem();
        }
      }

      Platform.isIOS
          ? await _showInfoDialogIos(_customResMessage(res))
          : await _showInfoDialogAndroid(_customResMessage(res));
      context.loaderOverlay.hide();
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "ລາຄາລວມທັງໝົດ: ",
              style: Theme.of(context).textTheme.headline6,
            ),
            GetBuilder<CartController>(builder: (ctr) {
              return Text(
                "${f.format(cartController.cartCost)} ກີບ",
                style: Theme.of(context).textTheme.headline6,
              );
            }),
          ],
        ),
        const Divider(
          color: Colors.white,
        ),
        // SizedBox(
        //   height: 60,
        //   child: GetBuilder<CartController>(builder: (ctr) {
        //     return ListView.builder(
        //       itemCount: ctr.cartItem.length,
        //       itemBuilder: (ctx, id) => CartItemComp(
        //         key: UniqueKey(),
        //         product: proController.productId(ctr.cartItem[id].proId),
        //       ),
        //     );
        //   }),
        // ),
        CartOverviewAction(
          pageChange: widget.pageChange,
          placeOrder: placeOrder,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
