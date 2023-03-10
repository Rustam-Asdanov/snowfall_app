import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothData extends StatefulWidget {
  @override
  State<BluetoothData> createState() => BluetoothDataState();
}

class BluetoothDataState extends State<BluetoothData> {
  static late List<BluetoothService> bluetoothServiceList;
  late BluetoothService bluetoothService;
  int scanDuration = 10;
  static var myData = "";
  static bool isConnected = false;

  @override
  void initState() {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: scanDuration));
    super.initState();
  }

  // String getDataFromBangle() {
  //   String message = "empty";
  //   bluetoothServiceList.forEach((service) async {
  //     var characteristics = service.characteristics;
  //     for (BluetoothCharacteristic bc in characteristics) {
  //       await bc.setNotifyValue(true);
  //       bc.value.listen((value) {
  //         print('-----------inside value --------${utf8.decode(value)}');
  //         myData = utf8.decode(value);
  //         message = utf8.decode(value);
  //       });
  //     }
  //   });
  //   return message;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blue")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: const Text("Search again if not detected"),
          ),
          const SizedBox(height: 10),
          StreamBuilder<List<ScanResult>>(
            stream: FlutterBlue.instance.scanResults,
            initialData: [],
            builder: (c, snapshot) => Column(
              children: snapshot.data!
                  .where((element) =>
                      element.device.name.toLowerCase().contains("bangle"))
                  .map(
                    (result) => Column(
                      children: [
                        Text(result.device.name),
                        ElevatedButton(
                          child: const Text("Connect"),
                          onPressed: () async {
                            isConnected = await result.device
                                .connect()
                                .then((value) async {
                              bluetoothServiceList =
                                  await result.device.discoverServices();
                              return true;
                            }).catchError((e) => false);

                            print('------------${isConnected}');
                          },
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const Spacer(),
          Container(
            child: Text('Status: ${isConnected ? 'Success' : ''}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<bool>(
                stream: FlutterBlue.instance.isScanning,
                initialData: false,
                builder: (c, snapshot) {
                  if (snapshot.data!) {
                    return Container();
                  } else {
                    return FloatingActionButton.extended(
                      icon: const Icon(Icons.search),
                      label: const Text("Search again"),
                      onPressed: () {
                        FlutterBlue.instance.startScan(
                            timeout: Duration(seconds: scanDuration));
                      },
                    );
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
