import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:onestore/getxcontroller/message_controller.dart';
import 'package:onestore/helper/printer_helper.dart';
import 'package:onestore/helper/util_helper.dart';
import 'package:onestore/models/inbox_message.dart';
import 'package:onestore/screens/printer_screen.dart';
import 'package:onestore/widgets/invoice/invoice_single.dart';
import 'package:onestore/widgets/widget_to_image.dart';

class InvoiceGarena extends StatefulWidget {
  const InvoiceGarena({Key? key, required this.orderId}) : super(key: key);
  // final List<List<InboxMessage>> groupMessage;
  final List<InboxMessage> orderId;

  @override
  _InvoiceGarenaState createState() => _InvoiceGarenaState();
}

class _InvoiceGarenaState extends State<InvoiceGarena> {
  late GlobalKey key1;
  dynamic bytes1;
  final messageController = Get.put(MessageController());
  @override
  Widget build(BuildContext context) {
    Future<bool> _isPrintCon() async {
      final isconnect = await PrintHelper.checkPrinter();
      return isconnect;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ພິມບິນ"),
      ),
      body: LoaderOverlay(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WidgetToImage(
                  builder: (key) {
                    key1 = key;
                    return SizedBox(
                      width: 130,
                      child: FittedBox(
                        child: Column(
                          children: widget.orderId
                              .map(
                                (e) => e.category.contains("1001")
                                    ? InvoiceSingle().genGarena(e)
                                    : InvoiceSingle().genOther(e),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
                buildImage(bytes1),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () async {
            context.loaderOverlay.show();

            if (!await _isPrintCon()) {
              context.loaderOverlay.hide();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const PrinterSetting()));
              return;
              // return _alert('ກະລຸນາເຊື່ອມຕໍ່ເຄື່ອງພິມ');
            }
            final data = await UtilHelper.capture(key1);
            context.loaderOverlay.hide();
            setState(() {
              bytes1 = data;
            });
            log("bbbb" + bytes1);

            await PrintHelper.printTicket2(bytes1);
          },
          child: const Icon(
            Icons.print,
            size: 50,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildImage(bytes) =>
      bytes != null ? Image.memory(bytes) : const Text("No image");
}
