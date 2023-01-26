import 'package:flutter/material.dart';
import 'package:location/location.dart';
import "dart:convert";
import 'package:snowfall_app/models/sos_message.dart';
import 'package:snowfall_app/routes/messages.dart';
import "package:http/http.dart" as http;

class EmergencyMessages extends StatefulWidget {
  EmergencyMessages({super.key});

  @override
  State<EmergencyMessages> createState() => _EmergencyMessagesState();
}

Future<SosMessage> sendData(
    String text, Future<LocationData> locationData) async {
  final response = await http.post(
    Uri.parse("http://10.0.2.2:3000/api/v1/"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode(
        <String, String>{"message": text, "location": locationData.toString()}),
  );

  if (response.statusCode == 201) {
    return SosMessage.fromJson(jsonDecode(response.body));
  } else {
    return SosMessage(
        id: "Nan", text: "Fail", locationData: Location().getLocation());
  }
}

Future<SosMessage> getData() async {
  final response = await http.get(Uri.parse("http://10.0.2.2:3000/api/v1/"));

  if (response.statusCode == 201) {
    return SosMessage.fromJson(jsonDecode(response.body));
  } else {
    return SosMessage(
        id: "Nan", text: "Fail", locationData: Location().getLocation());
  }
}

Future<LocationData> locationReceiving() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      // you should write something
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      // you should write something
    }
  }

  _locationData = await location.getLocation();
  return _locationData;
}

class _EmergencyMessagesState extends State<EmergencyMessages> {
  final messageController = TextEditingController();

  List<SosMessage> messageList = [
    SosMessage(id: "1", text: "Help", locationData: Location().getLocation()),
    SosMessage(id: "2", text: "Heey", locationData: Location().getLocation())
  ];

  // List<SosMessage> messageList = getData();

  void submitData() {
    final enteredMessage = messageController.text;

    if (enteredMessage.isEmpty) {
      return;
    }

    setState(() {
      // messageList.add(SosMessage(
      //     id: "3",
      //     text: enteredMessage,
      //     locationData: Location().getLocation()));
      print(sendData(enteredMessage, locationReceiving()));
    });
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
                TextField(
                  autocorrect: true,
                  autofocus: true,
                  controller: messageController,
                  decoration: InputDecoration(labelText: "Message"),
                ),
                ElevatedButton(onPressed: submitData, child: Text("Add"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
