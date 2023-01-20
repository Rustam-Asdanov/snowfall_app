import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmergencyMessages extends StatelessWidget{
  const EmergencyMessages({super.key});

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
            
          ],
        ),
      ),
    );
  }

}