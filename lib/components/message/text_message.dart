import 'package:battle_app/models/ChatMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 20*0.75, vertical: 20/2),
      decoration: BoxDecoration(
        color: message.isSender ? Colors.yellow.withOpacity(0.6) : Colors.greenAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(message.text, style: TextStyle(color: Colors.black),),
    );
  }
}