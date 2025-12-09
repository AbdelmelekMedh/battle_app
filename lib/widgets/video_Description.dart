import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent.withOpacity(0.2),
      width: MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width / 4, //100
      height: MediaQuery.of(context).size.height / 6, //100
      padding: const EdgeInsets.only(left: 5, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '@PickleRick',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          const Text(
              'A live performance in the park withe Alix, if you werent there check out the video for a ...',
              style: TextStyle(fontSize: 13.0)),
          const Row(
            children: [
              Icon(Icons.music_note, size: 13.0, color: Colors.white),
              Text('Say So - Doja Cat', style: TextStyle(fontSize: 10.0))
            ],
          ),
        ],
      ),
    );
  }
}
