import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget{
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About the App"),
      ),
      body: Column(
        children: const <Widget>[
          Text("data"),
          ElevatedButton(
            onPressed: null, 
            child: Text("Go Back"))
        ],
      ),
    );
  }
}