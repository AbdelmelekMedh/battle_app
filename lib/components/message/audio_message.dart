import 'package:battle_app/models/ChatMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessage message;

  const AudioMessage({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(horizontal: 20 * 0.75, vertical: 20/2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: message.isSender ?Colors.yellow.withOpacity(0.6) : Colors.greenAccent.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Icon( Icons.play_arrow, color: message.isSender ? Colors.black : Colors.greenAccent),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message.isSender ? Colors.black : Colors.greenAccent.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message.isSender ? Colors.black : Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text("0.37", style: TextStyle(fontSize: 12, color: message.isSender ? Colors.white : Colors.green)),
        ],
      ),
    );
  }
}