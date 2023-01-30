import 'package:flutter/material.dart';
import '../widgets/my_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  final String text = "This App can help you survive on snowfall. "
      "In FIRST step you should connect your device(Bangle Watch). "
      "Then you will see Messages section, there your data will be send "
      "and you can also can see another messages.";

  void launchURLMethod() async {
    const url = "https://quiet-ridge-91568.herokuapp.com/";
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

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
              Text(textAlign: TextAlign.center, text),
              // ignore: prefer_const_constructors
              MyButton(
                  text: "Our Web Site",
                  color: Colors.blueAccent,
                  myFunc: (){
                    launchURLMethod();
                  }),
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
