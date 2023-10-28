import 'package:flutter/material.dart';

Future<DateTime?> showCustomDatePicker(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2022),
    lastDate: DateTime(2024),
  );
}
