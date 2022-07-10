import 'dart:developer';
import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:onestore/api/alert_smart.dart';

class PrintHelper {
  static late Uint8List imageBytes;
  static BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  static Future<bool> checkPrinter() async {
    log("Helper check connection");
    bool? isConnected =
        await bluetooth.isConnected; //BluetoothThermalPrinter.connectionStatus;
    if (isConnected == null) return false;
    log("Printer connection check: " + isConnected.toString());
    return isConnected;
  }

  // static Future<void> printTicket(List<int> barcode) async {
  //   if (await checkPrinter()) {
  //     List<int> ticket = await getTicket(barcode);
  //     final result = await BluetoothThermalPrinter.writeBytes(ticket);
  //     log("Print $result");
  //     // List<int> bytes = [];

  //   } else {
  //     //Hadnle Not Connected Senario
  //     // _showMyDialog('Connection fail', 'ບໍ່ພົບເຄື່ອງພິມທີ່ເຊື່ມຕໍ່',
  //     //     'ກະລຸນາກວດສອບການເຊື່ອມຕໍ່ເຄື່ອງພີມ');
  //   }
  // }

  static Future<void> printTicket2(Uint8List imageData) async {
    if (await checkPrinter()) {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      final image = decodeImage(imageData);
      List<int> bytes = [];
      bytes += generator.setGlobalCodeTable('CP1250');
      bytes += generator.image(image!);
      final result = await BluetoothThermalPrinter.writeBytes(bytes);
      log("Print $result");
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
    // await _genImage();
    final image = decodeImage(imageBytes);
    bytes += generator.setGlobalCodeTable('CP1250');
    bytes += generator.image(image!);
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    log('barData: ' + barData.toString());
    log('barcod: ' + barcode.toString());
    bytes += generator.barcode(Barcode.upcA(barcode));
    bytes += generator.feed(2);
    return bytes;
  }

  static Future<void> printTest(BuildContext context) async {
    List<int> ticket = await testTicket();
    bool? isCon = await bluetooth.isConnected;
    if (isCon == null) {
      AlertSmart.inofDialog(context, "Pinter connection is not establish");
      return;
    }
    if (isCon) {
      bluetooth.writeBytes(Uint8List.fromList(ticket));
    } else {
      AlertSmart.errorDialog(context, "Printer is not connected");
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
}
