import 'package:camera_app/constants/color_constant.dart';
import 'package:flutter/material.dart';

// 아래에 조그맣게 전달받은 Message를 띄움.
showSnackBar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: mainColor),
  );
}
