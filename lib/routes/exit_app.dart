import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snowfall_app/widgets/my_button.dart';

import '../widgets/title_text.dart';

class ExitApp extends StatelessWidget {
  const ExitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exit"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TitleText("Are you sure?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyButton(
                    text: "Yes",
                    color: Colors.red,
                    myFunc: () {
                      SystemNavigator.pop();
                    }),
                const SizedBox(width: 16),
                MyButton(
                    text: "No",
                    color: Colors.blueAccent,
                    myFunc: () {
                      Navigator.pushNamed(context, "/");
                    })
              ],
            )
          ]),
    );
  }
}
