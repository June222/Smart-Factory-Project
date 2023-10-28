import 'package:flutter/material.dart';

// 맨 위 스크린에 전달받은 msg를 띄움.
Future<void> showTextDialog(String msg, BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
