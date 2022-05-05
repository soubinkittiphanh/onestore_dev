import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart' as flutterblue;
import 'package:get/get.dart';
import 'package:onestore/api/alert_smart.dart';
import 'package:onestore/getxcontroller/printer_check_constroller.dart';
import 'package:onestore/helper/printer_helper.dart';

class PrinterSetting extends StatefulWidget {
  static const routeName = "/printer-setting";

  const PrinterSetting({Key? key}) : super(key: key);
  @override
  _PrinterSettingState createState() => _PrinterSettingState();
}

class _PrinterSettingState extends State<PrinterSetting> {
  @override
  void initState() {
    // _initPrinterState();
    super.initState();
    // initPlatformState();
    scanBluetoothDevice();
    log("Setting state=====>");
  }

  final printerConCheckContrx = Get.put(PrinterConnectionCheck());
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> availableBluetoothDevices = [];
  bool isBluetoothOn = false;
  BluetoothDevice? _selectDevice;
  bool isDeviceConnected = false;

  Future<void> scanBluetoothDevice() async {
    final List<BluetoothDevice> bluetooths = await bluetooth.getBondedDevices();
    setState(() {
      availableBluetoothDevices = bluetooths;
    });
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } catch (err) {
      // TODO - Error
      log("Platform error====>>" + err.toString());
    }
    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            isDeviceConnected = false;
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            isDeviceConnected = false;
            isBluetoothOn = true;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            isBluetoothOn = true;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        default:
          print(state);
          break;
      }
    });
    if (mounted) {
      setState(() {
        availableBluetoothDevices = devices;
        isDeviceConnected = isConnected ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    bool printerConnectionCheck = printerConCheckContrx.disablePrinterCheck;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ຕັ້ງຄ່າການເຊື່ອມຕໍ່ເຄື່ອງພິມ'),
      ),
      body: Container(
        // height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<PrinterConnectionCheck>(builder: (ctx) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: SwitchListTile(
                    value: printerConnectionCheck,
                    onChanged: (val) {
                      log("Disable: " + val.toString());
                      setState(() {
                        printerConnectionCheck = !printerConnectionCheck;
                        ctx.setPrinterCheckStatus(printerConnectionCheck);
                      });
                      String message = printerConnectionCheck
                          ? "ກ່ອນການສັ່ງຊື້ ແລະ ພິມ ຈະຕ້ອງເຊື່ອມຕໍ່ເຄື່ອງພິມກ່ອນ"
                          : "ສາມາດສັ່ງຊື້ໄດ້ ໂດຍບໍ່ຈຳເປັນຕໍ່ເຄື່ອງພິມ";
                      AlertSmart.inofDialog(context, message);
                      // printerConCheckContrx.setPrinterCheckStatus(val);
                    },
                    title: const Text(
                      "ປິດ-ເປີດ ການກວດປິນເຕີ ກ່ອນພິມ ແລະ ສັ່ງ",
                      style: TextStyle(fontFamily: 'noto san lao'),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text("ຄົ້ນຫາເຄື່ອງພິມທີ່ເຄີຍເຊື່ອມຕໍ່ແລ້ວ"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // flutterblue.FlutterBlue flBlue =
                      //     flutterblue.FlutterBlue.instance;
                      // bool isBlue = await flBlue.isOn;
                      // if (!isBlue) {
                      //   await AppSettings.openBluetoothSettings();
                      // }
                      scanBluetoothDevice();
                    },
                    child: const Text(
                      "ຄົ້ນຫາ",
                      style: TextStyle(fontFamily: 'noto san lao'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppSettings.openBluetoothSettings();
                    },
                    child: const Text("Bluetooth setting"),
                  )
                ],
              ),
              SizedBox(
                height: deviceSize.height * 0.3,
                child: ListView.builder(
                  itemCount: availableBluetoothDevices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        _selectDevice = availableBluetoothDevices[index];
                        _connect();
                      },
                      title: Text('${availableBluetoothDevices[index].name}'),
                      subtitle: const Text("Click to connect"),
                      trailing: const IconButton(
                        icon: Icon(Icons.bluetooth_connected),
                        onPressed: null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  await PrintHelper.printTest(context);
                },
                child: const Text(
                  "ທົດລອງພິມ",
                  style: TextStyle(fontFamily: 'noto san lao'),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // await _initPrinterState();
                },
                child: const Text(
                  "ເຊັກສະຖານະການເຊື່ອມຕໍ່",
                  style: TextStyle(fontFamily: 'noto san lao'),
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ສະຖານະ: ${isDeviceConnected ? 'ເຊື່ອມຕໍ່ແລ້ວ' : 'ບໍ່ມີການເຊື່ອມຕໍ່'}',
                      style: TextStyle(
                          fontSize: 20,
                          color: isDeviceConnected ? Colors.green : Colors.red),
                    ),
                    // Text(
                    //   'ເຄື່ອງທີ່ກຳລັງເຊື່ອມຕໍ່: ${isDeviceConnected ? _selectDevice!.name ?? '' ':' : ''}',
                    //   style: const TextStyle(fontSize: 20),
                    // ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  void _connect() {
    if (_selectDevice == null) {
      AlertSmart.errorDialog(context, 'No device selected');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (isConnected == null) {
          return;
        }
        _disconnect();
        if (!isConnected) {
          bluetooth.connect(_selectDevice!).catchError((error) {
            log("Catch error");
            setState(() => isDeviceConnected = false);
          });
          setState(() {
            isDeviceConnected = true;
            printerConCheckContrx.setSelectedDevice(_selectDevice!);
          });
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => isDeviceConnected = false);
  }
}
