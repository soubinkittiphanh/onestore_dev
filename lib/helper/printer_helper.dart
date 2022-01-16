import 'dart:typed_data';

import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as nativePdf;

class PrintHelper {
  static late Uint8List imageBytes;
  static Future<bool> checkPrinter() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == 'true') {
      return true;
    }
    return false;
  }

  static Future<void> printTicket(List<int> barcode) async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> ticket = await getTicket(barcode);
      final result = await BluetoothThermalPrinter.writeBytes(ticket);
      print("Print $result");
      // List<int> bytes = [];

    } else {
      //Hadnle Not Connected Senario
      // _showMyDialog('Connection fail', 'ບໍ່ພົບເຄື່ອງພິມທີ່ເຊື່ມຕໍ່',
      //     'ກະລຸນາກວດສອບການເຊື່ອມຕໍ່ເຄື່ອງພີມ');
    }
  }

  static Future<void> printTicket2(Uint8List imageData) async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      final image = decodeImage(imageData);
      List<int> bytes = [];
      bytes += generator.setGlobalCodeTable('CP1250');
      bytes += generator.image(image!);
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      print("Print $result");
      // List<int> bytes = [];

    } else {
      //Hadnle Not Connected Senario
      // _showMyDialog('Connection fail', 'ບໍ່ພົບເຄື່ອງພິມທີ່ເຊື່ມຕໍ່',
      //     'ກະລຸນາກວດສອບການເຊື່ອມຕໍ່ເຄື່ອງພີມ');
    }
  }

  static Future<List<int>> getTicket(List<int> barcode) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    await _genImage();
    final image = decodeImage(imageBytes);
    bytes += generator.setGlobalCodeTable('CP1250');
    bytes += generator.image(image!);
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    print('barData: ' + barData.toString());
    print('barcod: ' + barcode.toString());
    bytes += generator.barcode(Barcode.upcA(barcode));
    bytes += generator.feed(2);
    return bytes;
  }

  static Future<void> printGraphics() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == "true") {
      List<int> ticket = await testTicket();
      final result = await BluetoothThermalPrinter.writeBytes(ticket);
      print("Print $result");
    } else {
      //Hadnle Not Connected Senario
    }
  }

  //ESC POS UTILL 1.0.O
  static Future<List<int>> testTicket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    bytes += generator.setGlobalCodeTable('CP1250');
    bytes += generator.text('Print Test.');
    return bytes;
  }

  static Future<List<int>> directPrintTicket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    bytes += generator.setGlobalCodeTable('CP1250');
    bytes += generator.text('Print Test.');
    return bytes;
  }

  static _genImage() async {
    final dir = await getExternalStorageDirectory();
    final document =
        await nativePdf.PdfDocument.openFile('${dir!.path}/receipt.pdf');
    final page = await document.getPage(1);
    final pageImage = await page.render(
      width: page.width,
      height: page.height,
      format: nativePdf.PdfPageFormat.PNG,
    );
    final bytes = pageImage!.bytes;
    imageBytes = bytes;
    await page.close();
  }

  static _genImage2() async {
    final dir = await getExternalStorageDirectory();
    final document =
        await nativePdf.PdfDocument.openFile('${dir!.path}/receipt.pdf');
    final page = await document.getPage(1);
    final pageImage = await page.render(
      width: page.width,
      height: page.height,
      format: nativePdf.PdfPageFormat.PNG,
    );
    final bytes = pageImage!.bytes;
    imageBytes = bytes;
    await page.close();
  }
}
