
import 'package:flutter/material.dart';

class Dilogbox {
  static Widget dialog(
      {required BuildContext context,
      required content,
      required Function() onYes}) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onYes,
          child: Text("Yes"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("No"),
        ),
      ],
    );
  }
}
