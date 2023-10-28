import 'package:flutter/material.dart';

Future<DateTime?> showCustomDatePicker(BuildContext context) async {
  // 날짜 고르기
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2022),
    lastDate: DateTime(2024),
  );
}
