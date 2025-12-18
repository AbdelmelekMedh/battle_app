import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  final String authorName;
  final String? description;
  const VideoDescription({Key? key, required this.authorName, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent.withOpacity(0.2),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 7,
      padding: const EdgeInsets.only(left: 10, top: 40,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Text(
            '@$authorName',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
           Text(
              description ?? '',
              style: TextStyle(fontSize: 13.0)),
        ],
      ),
    );
  }
}
