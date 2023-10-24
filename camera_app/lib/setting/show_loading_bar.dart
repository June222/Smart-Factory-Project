import 'package:camera_app/constants/color_constant.dart';
import 'package:flutter/material.dart';

Future<void> showLoadingBar(BuildContext context) async {
  // 로딩 화면을 띄움.
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(
        color: mainColor,
      ),
    ),
  );
}
