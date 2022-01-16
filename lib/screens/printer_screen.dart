import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:onestore/helper/printer_helper.dart';

class PrinterSetting extends StatefulWidget {
  static const routeName = "/printer-setting";
  @override
  _PrinterSettingState createState() => _PrinterSettingState();
}

class _PrinterSettingState extends State<PrinterSetting> {
  @override
  void initState() {
    _initPrinterState();
    super.initState();
  }

  bool connected = false;
  List<dynamic> availableBluetoothDevices = []; // = new List();

  var deviceBattery = '';
  var deviceVersion = '';
  var deviceMac = '';
  var deviceName = '';

  Future<void> getBluetooth() async {
    final List<dynamic>? bluetooths =
        await BluetoothThermalPrinter.getBluetooths;
    print("Print $bluetooths");
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
    print("state connected $result");
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຕັ້ງຄ່າການເຊື່ອມຕໍ່ເຄື່ອງພິມ'),
      ),
      body: Container(
        // height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ຄົ້ນຫາເຄື່ອງພິມທີ່ເຄີຍເຊື່ອມຕໍ່ແລ້ວ"),
            OutlineButton(
              onPressed: () {
                this.getBluetooth();
              },
              child: Text("ຄົ້ນຫາ"),
            ),
            Container(
              // height: 400,
              child: Expanded(
                child: ListView.builder(
                  itemCount: availableBluetoothDevices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        String select = availableBluetoothDevices[index];
                        List list = select.split("#");
                        String name = list[0];
                        String mac = list[1];
                        this.setConnect(mac, name);
                      },
                      title: Text('${availableBluetoothDevices[index]}'),
                      subtitle: Text("Click to connect"),
                      trailing: IconButton(
                        icon: Icon(Icons.bluetooth_connected),
                        onPressed: null,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OutlineButton(
              onPressed: () async {
                if (connected) await PrintHelper.printGraphics();
              },
              child: Text("ທົດລອງພິມ"),
            ),
            OutlineButton(
              onPressed: () async {
                await _initPrinterState();
              },
              child: Text("ເຊັກສະຖານະການເຊື່ອມຕໍ່"),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.all(10),
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
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'ແບັດເຕີລີ່: $deviceBattery %',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'ເວີຊັ້ນ: $deviceVersion',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
