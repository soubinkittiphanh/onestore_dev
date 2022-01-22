import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:onestore/getxcontroller/message_controller.dart';
import 'package:onestore/helper/printer_helper.dart';
import 'package:onestore/helper/util_helper.dart';
import 'package:onestore/models/inbox_message.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Capture"),
        actions: [
          IconButton(
            onPressed: () async {
              final data = await UtilHelper.capture(key1);
              setState(() {
                bytes1 = data;
              });
            },
            icon: const Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: () async {
              // final data = await UtilHelper.capture(key1);
              // setState(() {
              //   bytes1 = data;
              // });
              await PrintHelper.printTicket2(bytes1);
            },
            icon: const Icon(Icons.print),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetToImage(
                builder: (key) {
                  key1 = key;
                  return Container(
                    width: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Colors.red,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    // child: FittedBox(
                    //   child: Column(
                    //     children: widget.groupMessage.map((e) {
                    //       return e[0].category.contains("1001")
                    //           ? Invoice().genGarena(e)
                    //           : Invoice().genOther(e);
                    //     }).toList(),
                    //   ),
                    // ),
                    child: FittedBox(
                      child: Column(
                        children: widget.orderId
                            .map((e) => e.category.contains("1001")
                                ? InvoiceSingle().genGarena(e)
                                : InvoiceSingle().genOther(e))
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
    );
  }

  Widget buildImage(bytes) =>
      bytes != null ? Image.memory(bytes) : const Text("No image");
}
