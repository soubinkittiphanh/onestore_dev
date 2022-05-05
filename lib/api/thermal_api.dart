import 'dart:developer';
import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as native_pdf;

class ThermalApi {
  static late Uint8List imageBytes;
  static BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  static Future<void> printTicket() async {
    String? isConnected = await BluetoothThermalPrinter.connectionStatus;
    if (isConnected == null) return;
    if (isConnected == "true") {
      List<int> ticket = await generateTicket();
      await BluetoothThermalPrinter.writeBytes(ticket);
    } else {
      //Hadnle Not Connected Senario
      // _showMyDialog('Connection fail', 'ບໍ່ພົບເຄື່ອງພິມທີ່ເຊື່ມຕໍ່',
      //     'ກະລຸນາກວດສອບການເຊື່ອມຕໍ່ເຄື່ອງພີມ');
    }
  }

  static Future<void> printTicketFromBlueThermal() async {
    bool? isConnected = await bluetooth.isConnected;
    if (isConnected == null) return;
    if (isConnected) {
      List<int> ticket = await generateTicket();
      Uint8List uint8list = Uint8List.fromList(ticket);
      await bluetooth.writeBytes(uint8list);
      // await BluetoothThermalPrinter.writeBytes(ticket);
    } else {
      //Hadnle Not Connected Senario
      // _showMyDialog('Connection fail', 'ບໍ່ພົບເຄື່ອງພິມທີ່ເຊື່ມຕໍ່',
      //     'ກະລຸນາກວດສອບການເຊື່ອມຕໍ່ເຄື່ອງພີມ');
    }
  }

  static Future<List<int>> generateTicket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];
    await _genImage();
    final image = decodeImage(imageBytes);
    bytes += generator.setGlobalCodeTable('CP1250');
    bytes += generator.image(image!);
    bytes += generator.feed(1);
    return bytes;
  }

  static _genImage() async {
    final dir = await getApplicationDocumentsDirectory();
    final document =
        await native_pdf.PdfDocument.openFile('${dir.path}/ticket.pdf');
    final page = await document.getPage(1);
    log("WIDTH: " + page.width.toString());
    log("HIGHT: " + page.height.toString());
    final pageImage = await page.render(
      width: (page.width * 2) + 90,
      height: (page.height * 2) + 90,
      format: native_pdf.PdfPageFormat.PNG,
      // cropRect: const Rect.fromLTRB(0, 0, 0, 0),
    );
    final bytes = pageImage!.bytes;
    imageBytes = bytes;
    await page.close();
  }
}
