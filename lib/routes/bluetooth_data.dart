import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothData extends StatefulWidget {
  @override
  State<BluetoothData> createState() => _BluetoothDataState();
}

class _BluetoothDataState extends State<BluetoothData> {
  late List<BluetoothService> bluetoothServiceList;
  late BluetoothService bluetoothService;
  int scanDuration = 10;
  bool isConnected = false;

  @override
  void initState() {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: scanDuration));
    super.initState();
  }

  void getDataFromBangle() {
    bluetoothServiceList.forEach((service) async {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic bc in characteristics) {
        await bc.setNotifyValue(true);
        bc.value.listen((value) {
          print('-----------inside value --------${utf8.decode(value)}');
        });
      }
    });
  }

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
                            // result.device
                            //     .connect(
                            //         timeout: const Duration(seconds: 5),
                            //         autoConnect: false)
                            //     .then((value) => {
                            //           result.device
                            //               .discoverServices()
                            //               .then((value) => {
                            //                     value.forEach((service) {
                            //                       service.characteristics
                            //                           .forEach((text) {
                            //                         print("---------------");
                            //                         print(text);
                            //                       });
                            //                     })
                            //                   })
                            //         });

                            isConnected = await result.device
                                .connect()
                                .then((value) async {
                              print("yes");
                              bluetoothServiceList =
                                  await result.device.discoverServices();
                              return true;
                            }).catchError((e) => false);

                            print('------------${isConnected}');
                            getDataFromBangle();
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
            child: Text("Your data: "),
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
