import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/models/steel_model.dart';

const Duration threeHundredMilliSec = Duration(milliseconds: 300);
const Duration oneSec = Duration(seconds: 1);

const Color mainColor = Color.fromRGBO(153, 231, 222, 1);

const EdgeInsets padding20All = EdgeInsets.all(20);

const String steelImage1 = "assets/steel_image.jpg";
const String steelDetectionImage1 = "assets/steel_detection.png";

Color semiGreyColor = Colors.white.withOpacity(0.2);

List<SteelModel> testSteelList = [
  SteelModel(
    "1.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    true,
    "C",
    steelImage1,
    steelDetectionImage1,
  ),
  SteelModel(
    "12.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    true,
    "D",
    steelImage1,
    steelDetectionImage1,
  ),
  SteelModel(
    "123.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    false,
    "A",
    steelImage1,
    steelDetectionImage1,
  ),
  SteelModel(
    "1234.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    false,
    "B",
    steelImage1,
    steelDetectionImage1,
  ),
  SteelModel(
    "12345.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    true,
    "C",
    steelImage1,
    steelDetectionImage1,
  ),
  SteelModel(
    "123456.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    false,
    "D",
    steelImage1,
    steelDetectionImage1,
  ),
  SteelModel(
    "1234567.jpg",
    DateTime.now().toString(),
    DateTime.now().toString().split(' ')[1].split('.')[0],
    true,
    "A",
    steelImage1,
    steelDetectionImage1,
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

class DataByDate {
  final String date;
  final int class_one_num;
  final int class_two_num;
  final int class_three_num;
  final int class_four_num;

  DataByDate(this.class_one_num, this.class_two_num, this.class_three_num,
      this.class_four_num, this.date);
}
