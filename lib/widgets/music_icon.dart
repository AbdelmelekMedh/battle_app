import 'package:flutter/material.dart';

class MusicIcon extends StatelessWidget {
  const MusicIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent.withOpacity(0.2),
      width: MediaQuery.of(context).size.width / 4, //100
      height: MediaQuery.of(context).size.height / 6, //100
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          getMusicPlayerAction(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 60,
          )
        ],
      ),
    );
  }

  LinearGradient get musicGradient => LinearGradient(
      colors: [
        Colors.grey[800]!,
        Colors.grey[900]!,
        Colors.grey[900]!,
        Colors.grey[800]!
      ],
      stops: const [0.0, 0.4, 0.6, 1.0],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight);

  Widget getMusicPlayerAction() {
    return Container(
      width: 60.0,
      height: 60.0,
      child: Image.asset('assets/images/playingsmall.png'),
    );
  }
}
