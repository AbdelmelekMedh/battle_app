import 'package:battle_app/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


Widget profileImage(String imageProfile) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    height: 100,
    width: 120,
    child: CircleAvatar(
          radius: 80,
          backgroundImage: NetworkImage(imageProfile), // Placeholder image
        ),
  );
}

Widget profileStats() {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    height: 100,
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 100,
          child: Align(
            alignment: Alignment.centerLeft,
            child: profileAvatar(
              height: 100,
              width: 100,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget follow({Size? screen}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    width: screen?.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        statsBox(count: '57', title: 'Posts'),
        statsBox(count: '185', title: 'Followers'),
        statsBox(count: '241', title: 'Following'),
      ],
    ),
  );
}

Widget bio(BuildContext context, String username, String bioContent) {
  return Container(
    width: MediaQuery.of(context).size.width -
        MediaQuery.of(context).size.width / 3,
    height: MediaQuery.of(context).size.height / 10,
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$username',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
        ),
        Text(
          '$bioContent',
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}

Widget editProfileButton(String text, VoidCallback onPressed) {
  return Container(
    child: Container(
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget followProfile() {
  return Container(
    color: Colors.black,
    child: Container(
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[500]!),
        borderRadius: BorderRadius.circular(5),
        color: Colors.cyanAccent,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: const Text(
          'Follow',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    ),
  );
}

Widget messageProfile() {
  return Container(
    color: Colors.black,
    child: Container(
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[500]!),
        borderRadius: BorderRadius.circular(5),
        color: Colors.cyanAccent,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: const Text(
          'Message',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    ),
  );
}

Widget statsBox({
  required String count,
  required String title,
}) {
  return SizedBox(
    height: 80,
    width: 80,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          count,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    ),
  );
}

Widget profileAvatar({
  required double height,
  required double width,
  bool isStorySeen = false,
}) {
  return SizedBox(
    height: height, //155,
    width: width, //155,
    child: Align(
      alignment: Alignment.center,
      child: Container(
        height: height - 10, //140,
        width: width - 10, //140,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundImage: NetworkImage(Utils.getRandomImageUrl()),
        ),
      ),
    ),
  );
}
