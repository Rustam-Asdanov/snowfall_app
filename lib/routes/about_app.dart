import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About the App"),
      ),
      body: Column(
        children: <Widget>[
          Text("data"),
          ElevatedButton(
            onPressed: null, 
            child: Text("Go Back"))
        ],
      ),
    );
  }
}