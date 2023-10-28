import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(
      color: mainColor,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
  ),
  scrollbarTheme: const ScrollbarThemeData(
    thickness: MaterialStatePropertyAll(10),
    thumbColor: MaterialStatePropertyAll(mainColor),
    radius: Radius.circular(20),
    mainAxisMargin: 20,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
);
