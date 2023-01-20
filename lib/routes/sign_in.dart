import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snowfall_app/widgets/title_text.dart';

class SignIn extends StatelessWidget{
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Column(children: [
        TitleText("Sign In"),
        
      ]),
    );
  }

}