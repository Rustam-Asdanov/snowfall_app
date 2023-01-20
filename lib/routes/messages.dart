import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snowfall_app/models/sos_message.dart';
import 'package:snowfall_app/widgets/title_text.dart';

class Messages extends StatelessWidget {
  final List<SosMessage> sosMessageList;

  const Messages({super.key, required this.sosMessageList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Text(sosMessageList[index].text),
              ],
            ),
          );
        },
        itemCount: sosMessageList.length,
      ),
    );
  }
}
