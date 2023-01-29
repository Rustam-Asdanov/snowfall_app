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

  List<SosMessage> messageList = [];

  int messageCounter = 0;

  @override
  void initState() {
    getData();
    var bluetoothServiceList = BluetoothDataState.bluetoothServiceList;
    bluetoothServiceList.forEach((service) async {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic bc in characteristics) {
        await bc.setNotifyValue(true);
        bc.value.listen((value) {
          String myData = utf8.decode(value);
          if (myData.isNotEmpty && messageCounter == 0) {
            sendData(myData);
            messageCounter++;
            print('-----------inside value --------${utf8.decode(value)}');
          }
        });
      }
    });
    super.initState();
  }

  void getData() async {
    final response = await http
        .get(Uri.parse("https://enigmatic-forest-64947.herokuapp.com/api/v1"));

    if (response.statusCode == 200) {
      var parsed = json.decode(response.body);

      setState(() {
        messageList =
            (parsed as List).map((data) => SosMessage.fromJson(data)).toList();
      });
    } else {
      messageList = [
        SosMessage(id: "0", message: "Empty", latitude: 0, longitude: 0),
      ];
    }
  }

  Future<SosMessage> sendData(String text) async {
    var myLocation = await Location().getLocation();
    double? latitude = myLocation.latitude;
    double? longitude = myLocation.longitude;

    final response = await http.post(
      Uri.parse("https://enigmatic-forest-64947.herokuapp.com/api/v1"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, dynamic>{
        "message": text.trim(),
        "latitude": latitude,
        "longitude": longitude
      }),
    );

    if (response.statusCode == 201) {
      return SosMessage.fromJson(jsonDecode(response.body));
    } else {
      return SosMessage(id: "0", message: "Empty", latitude: 0, longitude: 0);
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
                ElevatedButton(onPressed: getData, child: const Text("Refresh"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
