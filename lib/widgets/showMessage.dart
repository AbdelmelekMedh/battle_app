import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMessage(
  BuildContext context,
  String title,
  String message,
  String buttonText,
  Function onPressed,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => onPressed(),
            child: Text(buttonText),
          )
        ],
      );
    },
  );
}
