import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExitApp extends StatelessWidget {
  const ExitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exit"),
      ),
      body: Column(
          children: <Widget>[
            const Text("Are you sure?"),
            Row(
              children: [
                ElevatedButton(
                  onPressed: null, 
                  child: const Text("Yes")),
                ElevatedButton(
                  onPressed: null, 
                  child: const Text("No"))
              ],
            )
          ]
        ),
    );
  }
}
