import 'package:flutter/material.dart';

AppBar introductionAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
