import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/getxcontroller/cart_controller.dart';
import 'package:onestore/getxcontroller/message_controller.dart';
import 'package:onestore/getxcontroller/order_controller.dart';
import 'package:onestore/getxcontroller/product_controller.dart';
import 'package:onestore/getxcontroller/user_info_controller.dart';
import 'package:onestore/helper/order_helper.dart';
import 'package:onestore/helper/print_check.dart';
import 'package:onestore/models/order.dart';
import 'package:onestore/service/user_inbox_service.dart';
import 'package:onestore/service/user_info_service.dart';
import 'package:onestore/widgets/cart_comp/cart_item_comp.dart';
import 'package:onestore/widgets/cart_overview/cart_overview_action.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

class CartOverview extends StatefulWidget {
  const CartOverview({Key? key, required this.pageChange}) : super(key: key);
  final Function pageChange;
  @override
  _CartOverviewState createState() => _CartOverviewState();
}

class _CartOverviewState extends State<CartOverview> {
  final f = NumberFormat("#,###");
  final productContr = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final proController = Get.put(ProductController());
    final cartProvider = Get.put(CartController());
    final orderController = Get.put(OrderController());
    final messageController = Get.put(MessageController());
    List<Order> loadOrder = orderController.orderItemNotDuplicate;
    final userInfoController = Get.put(UserInfoController());
    final cartItem = cartProvider.cartItem;
    Future _loadExternaleData() async {
      loadOrder = await OrderHelper.fetchOrder(userInfoController.userId);
      orderController.setOrderItem(loadOrder);
      messageController.setloadMessage(
          await UserInboxService.getInbox(userInfoController.userId));
    }

    Future<void> _showInfoDialogIos(String info) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
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
                    child: RaisedButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
                if (info.contains("complete"))
                  CupertinoDialogAction(
                      child: RaisedButton(
                    child: const Text("ພິມບິນ"),
                    onPressed: () async {
                      // Load order list
                      await _loadExternaleData();
                      int maxOrderId = 0;
                      for (var i = 0; i < loadOrder.length; i++) {
                        if (int.parse(loadOrder[i].orderId) > maxOrderId) {
                          maxOrderId = int.parse(loadOrder[i].orderId);
                        }
                      }
                      Navigator.of(context).pop();
                      await PrintCheck.prints(maxOrderId.toString(), context);
                    },
                  )),
              ],
            );
          });
    }

    Future<void> _showInfoDialogAndroid(String info) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
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
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
                ),
                if (info.contains("complete"))
                  RaisedButton(
                    onPressed: () async {
                      context.loaderOverlay.show();
                      await _loadExternaleData();
                      int maxOrderId = 0;
                      for (var i = 0; i < loadOrder.length; i++) {
                        if (int.parse(loadOrder[i].orderId) > maxOrderId) {
                          maxOrderId = int.parse(loadOrder[i].orderId);
                        }
                      }
                      context.loaderOverlay.hide();
                      log("Max: " + maxOrderId.toString());
                      await PrintCheck.prints(maxOrderId.toString(), context);
                      // Navigator.of(context).pop();
                    },
                    child: const Text("ພິມບິນ"),
                  ),
              ],
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
      return res;
    }

    void placeOrder() async {
      log("object");
      // sendOrder(cartItem);
      context.loaderOverlay.show();
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
        res = await OrderHelper.sendOrder(cartItem, userInfoController.userId);
        log("RESPONSE: " + res);
        if (res.endsWith("completed")) {
          log("completed case");
          final loadOrder = await OrderHelper.fetchOrder(
              userInfoController.userId); // update order list in order screen
          orderController.setOrderItem(loadOrder);
          await UserInboxService.getInbox(
            userInfoController.userId,
          );
          //update inbox screen
          cartProvider.clearCartItem();
        }
      }

      Platform.isIOS
          ? await _showInfoDialogIos(_customResMessage(res))
          : await _showInfoDialogAndroid(_customResMessage(res));
      context.loaderOverlay.hide();
    }

    return LoaderOverlay(
      overlayOpacity: 0.5,
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80),
              bottomRight: Radius.circular(90),
            ),
            color: Colors.white),
        // color: Colors.red,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "ລາຄາລວມທັງໝົດ: ",
                  style: Theme.of(context).textTheme.headline6,
                ),
                GetBuilder<CartController>(builder: (ctr) {
                  return Text(
                    "${f.format(cartProvider.cartCost)} ກີບ",
                    style: Theme.of(context).textTheme.headline6,
                  );
                }),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Flexible(
              // height: 500,
              child: GetBuilder<CartController>(builder: (ctr) {
                // return Text("aa");
                return ListView.builder(
                  itemCount: ctr.cartItem.length,
                  itemBuilder: (ctx, id) => CartItemComp(
                    // product: productProvider.productId(cartItem[id].proId),
                    product: productContr.productId(cartItem[id].proId),
                  ),
                );
              }),
            ),
            CartOverviewAction(
              pageChange: widget.pageChange,
              placeOrder: placeOrder,
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
