import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';

// 아래에 조그맣게 전달받은 Message를 띄움.
showSnackBar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: mainColor),
  );
}
