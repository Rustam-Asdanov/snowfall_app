import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:location/location.dart';
import "dart:convert";
import 'package:snowfall_app/models/sos_message.dart';
import 'package:snowfall_app/routes/bluetooth_data.dart';
import 'package:snowfall_app/routes/messages.dart';
import "package:http/http.dart" as http;

class EmergencyMessages extends StatefulWidget {
  EmergencyMessages({super.key});

  @override
  State<EmergencyMessages> createState() => _EmergencyMessagesState();
}

class _EmergencyMessagesState extends State<EmergencyMessages> {
  final messageController = TextEditingController();

  List<SosMessage> messageList = [
    SosMessage(id: "1", text: "Help", locationData: Location().getLocation()),
    SosMessage(id: "2", text: "Heey", locationData: Location().getLocation())
  ];

  @override
  void initState() {
    var bluetoothServiceList = BluetoothDataState.bluetoothServiceList;
    bluetoothServiceList.forEach((service) async {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic bc in characteristics) {
        await bc.setNotifyValue(true);
        bc.value.listen((value) {
          print('-----------inside value --------${utf8.decode(value)}');
          String myData = utf8.decode(value);
          if (myData.isNotEmpty) {
            sendData(myData);
          }
        });
      }
    });
    super.initState();
  }

  Future<SosMessage> sendData(String text) async {
    var myLocation = await Location().getLocation();
    double? latitude = myLocation.latitude;
    double? longitude = myLocation.longitude;

    final response = await http.post(
      Uri.parse("http://10.0.2.2:3000/api/v1/"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, dynamic>{
        "message": text,
        "latitude": latitude,
        "longtitude": longitude
      }),
    );

    if (response.statusCode == 201) {
      return SosMessage.fromJson(jsonDecode(response.body));
    } else {
      return SosMessage(
          id: "Nan", text: "Fail", locationData: Location().getLocation());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Messages"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Messages(sosMessageList: messageList),
            Column(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("Start"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
