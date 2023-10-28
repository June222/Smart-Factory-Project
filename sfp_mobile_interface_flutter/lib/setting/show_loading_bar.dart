import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';

Future<void> showLoadingBar(BuildContext context) async {
  // 로딩 화면을 띄움.
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(
        color: mainColor,
      ),
    ),
  );
}
