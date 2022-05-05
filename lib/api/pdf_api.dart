import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:onestore/api/thermal_api.dart';
import 'package:onestore/config/host_con.dart';
import 'package:onestore/models/inbox_message.dart';
import 'package:onestore/models/invoice_info.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static DateFormat formater = DateFormat('dd-MM-yyyy hh:mm');
  static bool isPhoneCard(InboxMessage message) {
    if (message.category.contains("1003") ||
        message.category.contains("1004") ||
        message.category.contains("1005") ||
        message.category.contains("1006")) {
      return true;
    } else {
      return false;
    }
  }

  static Future<File> generatePdf(InboxMessage message) async {
    final pdf = Document();
    final fontLao =
        // await rootBundle.load("asset/font/PhetsarathLao/saysettha_ot.ttf");
        await rootBundle.load("asset/font/SaysethaLao/Saysettha-Bold.ttf");
    final laoTtf = Font.ttf(fontLao);
    final logoImage = (await rootBundle.load(message.category.contains("1002")
            ? "asset/images/royal.jpeg"
            : message.category.contains('1001')
                ? "asset/images/header/header_garena.jpg"
                : InvoiceInfo.logoStr(message.category)))
        .buffer
        .asUint8List();
    final logoImageL = (await rootBundle.load(InvoiceInfo.logoStr("1006")))
        .buffer
        .asUint8List();
    final jewelryHeaderImage =
        (await rootBundle.load("asset/images/header/jewelry.jpg"))
            .buffer
            .asUint8List();
    pdf.addPage(
      Page(
        // pageTheme: pageTheme,
        pageFormat: PdfPageFormat.undefined,
        build: (conetext) => message.category.contains("1001")
            ? buildInvoiceGerena(message, laoTtf, logoImage, jewelryHeaderImage)
            : message.category.contains("1003")
                ? buildInvoiceLaotel(message, logoImageL, logoImage, laoTtf)
                : buildInvoiceOther(message, logoImage, laoTtf),
      ),
    );
    return await saveDocument("ticket.pdf", pdf);
  }

  static Widget buildInvoiceHeaderGarena(Uint8List headerLogo,
      Uint8List headerJewelry, Font font, String sellerName) {
    return Column(
      children: [
        laoText(
          lable: 'ຮ້ານ: $sellerName',
          font: font,
          // size: 11,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              MemoryImage(headerLogo),
              width: 20,
            ),
            Text(
              "GARENA FREE FIRE",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            Image(
              MemoryImage(headerLogo),
              width: 20,
            ),
          ],
        ),
        laoText(lable: "ລາຄາ  =  ຮັບເພັດ", font: font),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     laoText(lable: "10,000 = 68 ເພັດ", font: font),
        //     Image(
        //       MemoryImage(headerJewelry),
        //       width: 20,
        //     ),
        //   ],
        // ),
        builGarenaHeaderItem("12,000 = 68 ເພັດ", font, headerJewelry),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     laoText(lable: "22,000 = 172 ເພັດ", font: font),
        //     Image(
        //       MemoryImage(headerJewelry),
        //       width: 20,
        //     ),
        //   ],
        // ),
        builGarenaHeaderItem("25,000 = 172 ເພັດ", font, headerJewelry),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     laoText(lable: "40,000 = 344 ເພັດ", font: font),
        //     Image(
        //       MemoryImage(headerJewelry),
        //       width: 20,
        //     ),
        //   ],
        // ),
        builGarenaHeaderItem("47,000 = 344 ເພັດ", font, headerJewelry),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     laoText(lable: "60,000 = 517 ເພັດ", font: font),
        //     Image(
        //       MemoryImage(headerJewelry),
        //       width: 20,
        //     ),
        //   ],
        // ),
        builGarenaHeaderItem("75,000 = 517 ເພັດ", font, headerJewelry),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     laoText(lable: "120,000 = 1052 ເພັດ", font: font),
        //     Image(
        //       MemoryImage(headerJewelry),
        //       width: 20,
        //     ),
        //   ],
        // ),
        builGarenaHeaderItem("140,000 = 1052 ເພັດ", font, headerJewelry),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     laoText(lable: "200,000 = 1800 ເພັດ", font: font),
        //     Image(
        //       MemoryImage(headerJewelry),
        //       width: 20,
        //     ),
        //   ],
        // ),
        builGarenaHeaderItem("235,000 = 1800 ເພັດ", font, headerJewelry),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     laoText(lable: "400,000 = 3698 ເພັດ", font: font),
        //     Image(
        //       MemoryImage(headerJewelry),
        //       width: 20,
        //     ),
        //   ],
        // ),
        builGarenaHeaderItem("460,000 = 3698 ເພັດ", font, headerJewelry),
      ],
    );
  }

  static Widget builGarenaHeaderItem(
      String label, Font font, Uint8List headerJewelry) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        laoText(lable: label, font: font),
        Image(
          MemoryImage(headerJewelry),
          width: 20,
        ),
      ],
    );
  }

  static Widget buildInvoiceGerena(InboxMessage message, Font laoTtf,
      Uint8List garenaHeader, Uint8List jewelryHeader) {
    return Column(
      children: [
        buildInvoiceHeaderGarena(
            garenaHeader, jewelryHeader, laoTtf, message.sellerName),
        laoText(lable: "---------------------------", font: laoTtf),
        buildInvoiceItem(message, laoTtf),
        buildInvoiceFooter(
            message.messageBody, laoTtf, message.orderId, message.sellerName),
        laoText(lable: "----------END---------", font: laoTtf)
      ],
    );
  }

  static Widget buildInvoiceOther(
      InboxMessage message, Uint8List logoImage, Font laoTtf) {
    List<String> guidance = [
      "ວິທີຕື່ມເງິນRefill *121*PIN NO#",
      "ກວດຍອດເງິນ Check balance*122#"
    ];
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          laoText(
            lable: 'ຮ້ານ: ${message.sellerName}',
            font: laoTtf,
            // size: 11,
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              InvoiceInfo.header(message.category),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image(
              MemoryImage(logoImage),
              width: 40,
              height: 40,
            ),
          ],
        ),
        buildInvoiceItem(
          message,
          laoTtf,
        ),
        if (isPhoneCard(message))
          Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: guidance
                  .map((e) => laoText(lable: e, font: laoTtf, size: 10))
                  .toList(),
            ),
          ),
        buildInvoiceFooter(
          message.messageBody,
          laoTtf,
          message.orderId,
          message.sellerName,
        ),
        laoText(lable: "-----------END----------", font: laoTtf)
      ],
    );
  }

  static Widget buildInvoiceLaotel(InboxMessage message, Uint8List logoImageL,
      Uint8List logoImageR, Font laoTtf) {
    List<String> guidance = [
      "ວິທີຕື່ມເງິນRefill *121*PIN NO#",
      "ກວດຍອດເງິນ Check balance*122#"
    ];
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        laoText(
          lable: 'ຮ້ານ: ${message.sellerName}',
          font: laoTtf,
          // size: 11,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              MemoryImage(logoImageL),
              width: 30,
              height: 30,
            ),
            Text(
              InvoiceInfo.header(message.category),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image(
              MemoryImage(logoImageR),
              width: 30,
              height: 30,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            laoText(lable: "Lao Telecom & T PLUS", font: laoTtf, size: 12),
          ],
        ),
        buildInvoiceItem(
          message,
          laoTtf,
        ),
        if (isPhoneCard(message))
          Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: guidance
                  .map((e) => laoText(lable: e, font: laoTtf, size: 10))
                  .toList(),
            ),
          ),
        buildInvoiceFooter(
          message.messageBody,
          laoTtf,
          message.orderId,
          message.sellerName,
        ),
        laoText(lable: "-----------END----------", font: laoTtf)
      ],
    );
  }

  static Widget buildInvoiceItem(InboxMessage message, Font laoTtf) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: const BorderRadius.all(
                Radius.circular(10)), //(Radius.circular(10))
          ),
          child: Column(
            children: [
              laoText(
                lable: "ລາຄາ: ${numFormater.format(message.price)} ກີບ",
                font: laoTtf,
                isBold: true,
                size: 16,
              ),
              laoText(
                lable: message.messageBody.contains("|")
                    ? message.messageBody.split("|")[0] +
                        " | " +
                        message.messageBody.split("|")[1] +
                        " | " +
                        message.messageBody.split("|")[2]
                    : message.messageBody,
                font: laoTtf,
                isBold: true,
                size: 14,
              ),
            ],
          ),
        )
      ],
    );
  }

  static Widget buildInvoiceFooter(
      String qrCode, Font laoTtf, String orderId, String sellerName) {
    final today = DateTime.now();
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: 10),
        SizedBox(
          height: 60,
          width: 60,
          child: BarcodeWidget(
            data: qrCode,
            barcode: Barcode.qrCode(),
            textStyle: const TextStyle(fontSize: 7),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        laoText(
          lable: 'ເລກອໍເດີ້: $orderId',
          font: laoTtf,
          size: 11,
        ),
        laoText(
          lable: 'Service center: 020 9748 9646',
          font: laoTtf,
          size: 10,
        ),
        laoText(
          lable: 'ເວລາພິມ: ${formater.format(today)}',
          font: laoTtf,
          size: 10,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  static Future<File> saveDocument(String fileName, Document doc) async {
    final bytes = await doc.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$fileName");
    await file.writeAsBytes(bytes);
    //*****Print ticket*****/
    await ThermalApi.printTicketFromBlueThermal();
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Text laoText(
      {required String lable,
      required Font font,
      bool isBold = false,
      double size = 12.0}) {
    return Text(
      lable,
      style: TextStyle(
          font: font,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: size),
    );
  }
}
