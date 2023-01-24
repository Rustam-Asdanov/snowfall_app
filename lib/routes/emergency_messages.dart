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

Future<SosMessage> sendData(String text) async {
  print("object" + text);
  final response = await http.post(
    Uri.parse("http://10.0.2.2:3000/api/v1/"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode(<String, String>{
      "message": text,
    }),
  );

  if (response.statusCode == 201) {
    return SosMessage.fromJson(jsonDecode(response.body));
  } else {
    return SosMessage(id: "Nan", text: "Fail", locationData: Location().getLocation());
  }
}

class _EmergencyMessagesState extends State<EmergencyMessages> {
  final messageController = TextEditingController();

  List<SosMessage> messageList = [
    SosMessage(id: "1", text: "Help", locationData: Location().getLocation()),
    SosMessage(id: "2", text: "Heey", locationData: Location().getLocation())
  ];

  void submitData() {
    final enteredMessage = messageController.text;

    if (enteredMessage.isEmpty) {
      return;
    }

    setState(() {
      messageList.add(SosMessage(
          id: "3",
          text: enteredMessage,
          locationData: Location().getLocation()));
      const String url ="http://localhost:3000/api/v1/";
      print(sendData(enteredMessage));
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
