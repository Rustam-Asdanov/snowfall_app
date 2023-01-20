import 'package:flutter/material.dart';
import 'package:snowfall_app/widgets/title_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback myFunc;

  const MyButton(
      {super.key,
      required this.text,
      required this.color,
      required this.myFunc});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: myFunc,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: TitleText(text),
    );
  }
}
