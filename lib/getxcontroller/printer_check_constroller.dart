import 'package:get/get_state_manager/get_state_manager.dart';

class PrinterConnectionCheck extends GetxController {
  bool disablePrinterCheck = true;
  void setPrinterCheckStatus(bool status) {
    disablePrinterCheck = status;
    update();
  }

  bool isPrinterCheckEnable() {
    return disablePrinterCheck;
  }
}
