import 'dart:developer';

import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    _initPrinterState();
    super.initState();
  }

  final printerConCheckContrx = Get.put(PrinterConnectionCheck());
  bool connected = false;
  List<dynamic> availableBluetoothDevices = []; // = new List();

  var deviceBattery = '';
  var deviceVersion = '';
  var deviceMac = '';
  var deviceName = '';

  Future<void> getBluetooth() async {
    final List<dynamic>? bluetooths =
        await BluetoothThermalPrinter.getBluetooths;
    log("Print $bluetooths");
    setState(() {
      availableBluetoothDevices = bluetooths!;
    });
  }

  Future<void> _initPrinterState() async {
    final connection = await BluetoothThermalPrinter.connectionStatus;
    final batteryLevel = await BluetoothThermalPrinter.getBatteryLevel;
    final platformVersion = await BluetoothThermalPrinter.platformVersion;
    if (connection == 'true') {
      setState(() {
        deviceBattery = batteryLevel.toString();
        deviceVersion = platformVersion!;
        connected = true;
      });
    }
  }

  Future<void> setConnect(String mac, String name) async {
    final String? result = await BluetoothThermalPrinter.connect(mac);
    log("state connected $result");
    if (result == "true") {
      setState(() {
        // connected = true;
        deviceName = name;
        deviceMac = mac;
      });
      _initPrinterState();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool printerConnectionCheck = printerConCheckContrx.disablePrinterCheck;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຕັ້ງຄ່າການເຊື່ອມຕໍ່ເຄື່ອງພິມ'),
      ),
      body: Container(
        // height: double.infinity,
        padding: const EdgeInsets.all(20),
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
            ElevatedButton(
              onPressed: () {
                getBluetooth();
              },
              child: const Text(
                "ຄົ້ນຫາ",
                style: TextStyle(fontFamily: 'noto san lao'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: availableBluetoothDevices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      String select = availableBluetoothDevices[index];
                      List list = select.split("#");
                      String name = list[0];
                      String mac = list[1];
                      setConnect(mac, name);
                    },
                    title: Text('${availableBluetoothDevices[index]}'),
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
                if (connected) await PrintHelper.printGraphics();
              },
              child: const Text(
                "ທົດລອງພິມ",
                style: TextStyle(fontFamily: 'noto san lao'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _initPrinterState();
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
                    'ສະຖານະ: ${connected ? 'ເຊື່ອມຕໍ່ແລ້ວ' : 'ບໍ່ມີການເຊື່ອມຕໍ່'}',
                    style: TextStyle(
                        fontSize: 20,
                        color: connected ? Colors.green : Colors.red),
                  ),
                  Text(
                    'ເຄື່ອງທີ່ກຳລັງເຊື່ອມຕໍ່: ${connected ? deviceName + ':' + deviceMac : ''}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'ແບັດເຕີລີ່: $deviceBattery %',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'ເວີຊັ້ນ: $deviceVersion',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
