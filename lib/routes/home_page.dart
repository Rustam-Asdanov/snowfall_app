import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snowfall Home"),
      ),
      // there we have column with Title and also 4 button
      // for choosing which route use want to open
      body: Column(children: <Widget>[
        Text("Snowfall"),
        ElevatedButton(onPressed: null, child: Text("Sign In")),
        ElevatedButton(onPressed: null, child: Text("Sign Up")),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/about");
            },
            child: Text("About")),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/exit");
            },
            child: Text("Exit")),
      ]),
    );
  }
}
