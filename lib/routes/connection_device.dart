import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:snowfall_app/widgets/title_text.dart';

class ConnectionDevice extends StatefulWidget {
  // create list for bluetooth devices
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];

  // instance for working with bluetooth methods
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  
  final String title = "";

  @override
  State<ConnectionDevice> createState() => _ConnectionDeviceState();
}

class _ConnectionDeviceState extends State<ConnectionDevice> {
  //
  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });

    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = <Container>[];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(children: [
            Expanded(
                child: Column(
              children: [
                Text(device.name == "" ? '(unknown device)' : device.name),
                Text(device.id.toString()),
              ],
            )),
            TextButton(
              child: const Text(
                "Connect",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},

            ),
          ]),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        ...containers,
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.title)),
    body: _buildListViewOfDevices(),
  );
}
