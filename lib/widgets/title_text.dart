import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class TitleText extends StatelessWidget{
  String text = "";

  TitleText(String text) {
    this.text = text;
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: "Arial",
        fontSize: 20,
      ),
      text
      );
  }


}
