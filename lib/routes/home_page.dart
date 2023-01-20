import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snowfall Home"),
      ),
      body: Column(children: const <Widget>[
        Text("Snowfall"),
        ElevatedButton(onPressed: null, child: Text("Sign in")),
        ElevatedButton(onPressed: null, child: Text("Sign up")),
        ElevatedButton(onPressed: null, child: Text("About")),
        ElevatedButton(onPressed: null, child: Text("Exit")),
      ]),
    );
  }
}
