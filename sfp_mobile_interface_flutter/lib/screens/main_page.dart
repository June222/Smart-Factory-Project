import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/widget/custom_dropdown_button.dart';
import 'package:sfp_mobile_interface_flutter/widget/steel_detail_widget.dart';
import 'package:sfp_mobile_interface_flutter/widget/steel_preview_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static String routeName = '/mainpage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Period periodStart = Period("2023", "10", "1");
  Period periodEnd = Period("2023", "10", "3");

  int imageNum = 50;
  int normalRatio = 32;
  int defectRatio = 68;

  int itemCount = 30;

  String? selectedStatus;
  String? selectedLabel;

  void onStatusChange(String? value) {
    setState(() {
      log("status change");
      selectedStatus = value;
    });
  }

  void onLabelChange(String? value) {
    setState(() {
      log("label change");
      selectedLabel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // log("1. $selectedStatus");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Steel See Preview"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      "Period: ${periodStart.toString()} ~ ${periodEnd.toString()}"),
                  Text("Images: $imageNum"),
                  Container(
                    width: 1,
                    height: 20,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.fiber_manual_record_rounded,
                        color: Colors.green,
                      ),
                      Text("Normal: $normalRatio%"),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.fiber_manual_record_rounded,
                        color: Colors.red,
                      ),
                      Text("Defect: $defectRatio%"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(child: Text("0 item selected")),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.calendar_month)),
                  CustomDropDownButton(
                    hint: const Text(
                      "IsNormal",
                      style: TextStyle(color: Colors.white),
                    ),
                    items: const ["Normal", "Defect"],
                    onChanged: onStatusChange,
                    value: selectedStatus,
                  ),
                  const SizedBox(width: 20),
                  CustomDropDownButton(
                    hint: const Text(
                      "Defect Label",
                      style: TextStyle(color: Colors.white),
                    ),
                    items: const ["A", "B", "C", "D"],
                    onChanged: onLabelChange,
                    value: selectedLabel,
                  ),
                  const SizedBox(width: 20),

                  // GET 요청할 Button
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Jump"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 60,
                          horizontal: 50,
                        ),
                        itemCount: itemCount,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          return SteelPreviewWidget(index: index);
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: SteelDataBigWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Period {
  final String year;
  final String month;
  final String date;
  Period(this.year, this.month, this.date);
  @override
  String toString() {
    return "$year/$month/$date";
  }
}

class SteelData {
  final String fileName;
  final String captureData;
  final String captureTime;
  final bool isNormal;
  final String defectLabel;

  SteelData(
    this.fileName,
    this.captureData,
    this.captureTime,
    this.isNormal,
    this.defectLabel,
  );
}
