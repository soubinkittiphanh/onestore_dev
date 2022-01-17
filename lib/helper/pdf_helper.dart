import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:onestore/getxcontroller/message_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
// import 'package:native_pdf_renderer/native_pdf_renderer.dart' as nativePdf;

class PDFHelper {
  static DateFormat formater = DateFormat('dd-MM-yyyy hh:mm');
  static final today = DateTime.now();
  static final nextSevenDay = today.add(const Duration(days: 7));
  static final formatNum = NumberFormat("#,###");
  static final inboxController = Get.put(MessageController());
  static Future<void> generatePdf(
    String orderId,
    String date,
  ) async {
    final txn = inboxController.messageByOrderID(orderId);
    final font = await rootBundle.load("asset/font/Phetsarath_OT.ttf");
    final fontNumber = await rootBundle.load("asset/font/GillSansNova.ttf");
    // final ByteData bytes = await rootBundle.load('assets/logo.jpg');
    // final Uint8List listAbcd = bytes.buffer.asUint8List();

    final ttf = pw.Font.ttf(font);
    var customDate = date.substring(0, 10);
    var year = customDate.substring(0, 4);
    var month = customDate.substring(
      customDate.length - 5,
      customDate.length - 3,
    );
    var day = customDate.substring(
      customDate.length - 2,
    );

    log('date: ' + day + ' month: ' + month + ' year: ' + year);
    final newDate = day + '-' + month + '-' + year;
    log('newDate: ' + newDate);
    final ttfNumber = pw.Font.ttf(fontNumber);
    // var total = 0;
    final pdf = pw.Document();
    log("Done");
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (context) {
          return pw.Column(children: [
            //HEADER START
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Row(children: [
                    txtLaosValue(ttf, 'GARENA FREE FIRE', 26.0, false),
                  ]),
                  txtLaosValue(ttf, '__________________________', 26.0, false),
                ],
              ),
            ),
            //HEADER END
            //FIX ITEM START
            pw.Center(
              child: pw.Column(
                // crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "ລາຄາ", 26.0, false),
                      txtLaosValue(ttf, " -------- ", 26.0, false),
                      txtLaosValue(ttf, "ຮັບເພັດ", 26.0, false),
                    ],
                  ),
                  txtLaosValue(ttf, '____________________', 26.0, false),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "10,000", 26.0, false),
                      txtLaosValue(ttf, " = ", 26.0, false),
                      txtLaosValue(ttf, "68 ເພັດ", 26.0, false),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "22,000", 26.0, false),
                      txtLaosValue(ttf, " = ", 26.0, false),
                      txtLaosValue(ttf, "172 ເພັດ", 26.0, false),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "37,000", 26.0, false),
                      txtLaosValue(ttf, " = ", 26.0, false),
                      txtLaosValue(ttf, "309 ເພັດ", 26.0, false),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "40,000", 26.0, false),
                      txtLaosValue(ttf, " = ", 26.0, false),
                      txtLaosValue(ttf, "344 ເພັດ", 26.0, false),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "60,000", 26.0, false),
                      txtLaosValue(ttf, " = ", 26.0, false),
                      txtLaosValue(ttf, "517 ເພັດ", 26.0, false),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "120,000", 26.0, false),
                      txtLaosValue(ttf, " = ", 26.0, false),
                      txtLaosValue(ttf, "2,052 ເພັດ", 26.0, false),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "200,000", 26.0, false),
                      txtLaosValue(ttf, " = ", 26.0, false),
                      txtLaosValue(ttf, "1,800 ເພັດ", 26.0, false),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      txtLaosValue(ttf, "400,000", 26.0, false),
                      txtLaosValue(ttf, " = ", 26.0, false),
                      txtLaosValue(ttf, "3,698 ເພັດ", 26.0, false),
                    ],
                  ),
                  txtLaosValue(ttf, '____________________', 26.0, false),
                ],
                // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              ),
            ),
            //FIX ITEM END
            pw.Container(
              width: 350,
              alignment: pw.Alignment.topLeft,
              child: pw.Column(
                // mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: List.generate(txn.length, (i) {
                  //Calculate total amount
                  // total += 10; //txn[i].orderId;
                  return pw.Center(
                    child: pw.Column(
                      children: [
                        //Column1
                        txtEnglish('[ ${formatNum.format(txn[i].price)} ]',
                            PdfColors.black, ttfNumber),
                        txtEnglish(
                            txn[i].messageBody, PdfColors.black, ttfNumber),
                        //Column2
                      ],
                    ),
                  );
                }),
              ),
            ),
            pw.Center(
              child: pw.Column(children: [
                txtLaosValue(ttf, '__________________________', 26.0, false),
                txtLaosValue(ttf, 'ADMIN: 020 9748 9646', 26.0, false),
                txtLaosValue(
                  ttf,
                  'ເວລາພິມ: ${formater.format(today)}',
                  23.0,
                  false,
                ),
                txtLaosValue(
                  ttf,
                  'ຊຶ້ອອນລາຍ: 020 9998 7077',
                  26.0,
                  false,
                ),
                txtLaosValue(
                  ttf,
                  'ຂໍຂອບໃຈ',
                  26.0,
                  false,
                ),
              ]),
            ),
          ]);
        },
      ),
    );
    await savePDF(pdf);
  }

  static savePDF(pdf) async {
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/receipt.pdf');
      await file.writeAsBytes(await pdf.save());
      log('file save');
    } catch (e) {
      log('error: ' + e.toString());
    }
  }

  static pw.Text txtLaosValue(pw.Font ttf, text, size, bool blod) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        font: ttf,
        fontSize: size,
        fontWeight: blod ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    );
  }

  static pw.Text txtEnglish(data, color, pw.Font ttf) {
    return pw.Text(
      data.toString(),
      style: pw.TextStyle(
        fontSize: 28,
        color: color,
        font: ttf,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }
}
