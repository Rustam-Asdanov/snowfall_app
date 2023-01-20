import 'package:flutter/material.dart';
import '../widgets/my_button.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About the App"),
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(textAlign: TextAlign.center, "data"),
              MyButton(
                  text: "Back",
                  color: Colors.blueAccent,
                  myFunc: () {
                    Navigator.pushNamed(context, "/");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
