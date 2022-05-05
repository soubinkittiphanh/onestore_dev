import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestore/api/pdf_api.dart';
import 'package:onestore/getxcontroller/message_controller.dart';
import 'package:onestore/getxcontroller/order_controller.dart';
import 'package:onestore/getxcontroller/printer_check_constroller.dart';
import 'package:onestore/helper/printer_helper.dart';
import 'package:onestore/models/inbox_message.dart';
import 'package:onestore/models/order.dart';
import 'package:get/get.dart';
import 'package:onestore/screens/printer_screen.dart';

import 'order_item_detail.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    required this.loadOrder,
  }) : super(key: key);

  final Order loadOrder;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final printerConnectionCtx = Get.put(PrinterConnectionCheck());
  bool isexpand = false;
  final f = NumberFormat("#,###");
  Future<bool> _isPrintCon() async {
    final isconnect = await PrintHelper.checkPrinter();
    return isconnect;
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Get.put(OrderController());
    final inboxController = Get.put(MessageController());
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(8),
          elevation: 0,
          // color: Colors.purple,
          child: Column(
            children: [
              Row(
                children: [
                  const Text("ລາຄາເຕັມ: "),
                  Text(orderProvider
                      .orderTotalPriceByIdOringinal(widget.loadOrder.orderId)),
                ],
              ),
              Row(
                children: [
                  const Text("ກຳໄລ: "),
                  Text(orderProvider.orderProfit(widget.loadOrder.orderId)),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ລະຫັດອໍເດີ: ${widget.loadOrder.orderId} ", //| ວັນທີ: ${widget.loadOrder.orderDate.substring(0, 10)} ${widget.loadOrder.orderDate.substring(11, 19)}",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "ວັນທີ: ${widget.loadOrder.orderDate.substring(0, 10)} ${widget.loadOrder.orderDate.substring(11, 19)}",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        if (!await _isPrintCon() &&
                            printerConnectionCtx.disablePrinterCheck) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const PrinterSetting(),
                            ),
                          );
                          return;
                        }
                        late File file;
                        List<InboxMessage> messageList = inboxController
                            .messageByOrderID(widget.loadOrder.orderId);
                        for (var item in messageList) {
                          file = await PdfApi.generatePdf(item);
                        }
                        if (!printerConnectionCtx.isPrinterCheckEnable()) {
                          PdfApi.openFile(file);
                        }
                      },
                      icon: const Icon(Icons.print)),
                  Text(
                    "ລາຄາລວມ: ${orderProvider.orderTotalPriceById(widget.loadOrder.orderId)}",
                  ),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                isexpand = !isexpand;
              });
            },
            icon: Icon(
              isexpand
                  ? Icons.expand_less_outlined
                  : Icons.expand_more_outlined,
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: SizedBox(
            child: OrderItemDetail(orderId: widget.loadOrder.orderId),
            height: 160,
            width: double.infinity,
            // color: Colors.white,
          ), // When you don't want to show menu..
          secondChild: Container(),
          crossFadeState:
              isexpand ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        )
      ],
    );
  }
}
