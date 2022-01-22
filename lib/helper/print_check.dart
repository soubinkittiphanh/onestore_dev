import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onestore/getxcontroller/message_controller.dart';
import 'package:onestore/helper/printer_helper.dart';
import 'package:onestore/models/inbox_message.dart';
import 'package:onestore/widgets/invoice/invoice.dart';
import 'package:onestore/widgets/invoice/invoice_other_widget.dart';
import 'package:onestore/widgets/invoice_garena.dart';
import 'package:screenshot/screenshot.dart';

class PrintCheck {
  static late GlobalKey key1;
  static final messageController = Get.put(MessageController());
  static final controller = ScreenshotController();
  static Future garena(List<InboxMessage> message) async {
    await controller
        .captureFromWidget(Invoice().genGarena(message))
        .then((value) {
      log("Running then");
      PrintHelper.printTicket2(value);
    });
  }

  static Future other(List<InboxMessage> message) async {
    log("pinting other");
    final image = await controller
        .captureFromWidget(InvoiceOtherWidget(message: message));
    // prints(orderId, context)
    PrintHelper.printTicket2(image);
  }

  static Future prints(String orderId, BuildContext context) async {
    final messageData = messageController.messageByOrderID(orderId);
    log("Message sized: " + messageData.length.toString());
    final garenaItem =
        messageData.where((element) => element.category == "1001");
    final unitelItem =
        messageData.where((element) => element.category == "1004");
    final etlItem = messageData.where((element) => element.category == "1005");
    final beelineItem =
        messageData.where((element) => element.category == "1006");
    final ltcItem = messageData.where((element) => element.category == "1003");
    final trueItem = messageData.where((element) => element.category == "1002");
    final loyalItem =
        messageData.where((element) => element.category == "1000");

    log("Len garena: " + garenaItem.length.toString());
    log("Len unitelItem: " + unitelItem.length.toString());
    log("Len ltcItem: " + ltcItem.length.toString());
    log("Len trueItem: " + trueItem.length.toString());
    log("Len loyalItem: " + loyalItem.length.toString());
    final List<List<InboxMessage>> allGroupMessageData = [];
    for (var i = 0; i < 7; i++) {
      switch (i) {
        case 0:
          {
            log("printing garena");
            log("Size: " + garenaItem.length.toString());
            if (garenaItem.isNotEmpty) {
              allGroupMessageData.add([...garenaItem]);
              // await garena([...garenaItem]);
            }
          }
          break;
        case 1:
          {
            if (unitelItem.isNotEmpty) {
              allGroupMessageData.add([...unitelItem]);
              // await other([...unitelItem]);
            }
          }
          break;
        case 2:
          {
            if (ltcItem.isNotEmpty) {
              allGroupMessageData.add([...ltcItem]);
              // await other([...ltcItem]);
            }
          }
          break;
        case 3:
          {
            if (trueItem.isNotEmpty) {
              allGroupMessageData.add([...trueItem]);
              // await other([...trueItem]);
            }
          }
          break;
        case 4:
          {
            if (loyalItem.isNotEmpty) {
              allGroupMessageData.add([...loyalItem]);
              // await other([...loyalItem]);
            }
          }
          break;
        case 5:
          {
            if (etlItem.isNotEmpty) {
              allGroupMessageData.add([...etlItem]);
              // await other([...etlItem]);
            }
          }
          break;
        case 6:
          {
            if (beelineItem.isNotEmpty) {
              allGroupMessageData.add([...beelineItem]);
              // await other([...beelineItem]);
            }
          }
          break;
        default:
      }
    }
    Navigator.of(context).push(MaterialPageRoute(
        // builder: (ctx) => InvoiceGarena(groupMessage: allGroupMessageData)));
        builder: (ctx) => InvoiceGarena(orderId: messageData)));
  }
}
