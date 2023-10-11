import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/models/steel_model.dart';

const Duration threeHundredMilliSec = Duration(milliseconds: 300);
const Duration oneSec = Duration(seconds: 1);

const EdgeInsets padding20All = EdgeInsets.all(20);

const String steelImage1 = "assets/steel_image.jpg";

Color semiGreyColor = Colors.white.withOpacity(0.2);

List<SteelModel> testSteelList = [
  SteelModel(
    "1.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    true,
    "C",
    steelImage1,
  ),
  SteelModel(
    "12.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    true,
    "D",
    steelImage1,
  ),
  SteelModel(
    "123.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    false,
    "A",
    steelImage1,
  ),
  SteelModel(
    "1234.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    false,
    "B",
    steelImage1,
  ),
  SteelModel(
    "12345.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    true,
    "C",
    steelImage1,
  ),
  SteelModel(
    "123456.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    false,
    "D",
    steelImage1,
  ),
  SteelModel(
    "1234567.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    true,
    "A",
    steelImage1,
  ),
];

class Period {
  final String year;
  final String month;
  final String date;
  Period(this.year, this.month, this.date);

  static Period fromDateTime(DateTime dateTime) {
    return Period(
      dateTime.year.toString(),
      dateTime.month.toString(),
      dateTime.day.toString(),
    );
  }

  @override
  String toString() {
    return "$year / $month / $date";
  }
}
