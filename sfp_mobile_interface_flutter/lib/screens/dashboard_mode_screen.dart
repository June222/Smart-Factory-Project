import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/models/steel_model.dart';
import 'package:sfp_mobile_interface_flutter/widget/custom_dropdown_button.dart';
import 'package:sfp_mobile_interface_flutter/widget/steel_detail_widget.dart';
import 'package:sfp_mobile_interface_flutter/widget/steel_preview_widget.dart';

class DashBoardModeScreen extends StatefulWidget {
  const DashBoardModeScreen({super.key});

  @override
  State<DashBoardModeScreen> createState() => _DashBoardModeScreenState();
}

class _DashBoardModeScreenState extends State<DashBoardModeScreen> {
  Period periodStart = Period("2023", "10", "1");
  Period periodEnd = Period("2023", "10", "3");

  double normalRatio = 0;
  double defectRatio = 0;

  List<SteelModel> currList = testSteelList;

  int itemCount = 0;
  int? selectedIndex;

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

  void removeItemAt(int index) {
    log("remove At $index");
    setState(() {
      if (index == currList.length - 1) {
        selectedIndex = null;
      }
      currList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    itemCount = currList.length;
    int numOfNormal = 0;
    int numOfDefect = 0;
    for (SteelModel data in currList) {
      if (data.isNormal) {
        numOfNormal++;
      } else {
        numOfDefect++;
      }
    }
    normalRatio = numOfNormal / (numOfNormal + numOfDefect) * 100;
    defectRatio = numOfDefect / (numOfNormal + numOfDefect) * 100;

    return Column(
      children: [
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("START: "),
              Text(
                periodStart.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2024),
                    );
                    setState(() {
                      if (dateTime != null) {
                        setState(() {
                          periodStart = Period.fromDateTime(dateTime);
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.calendar_month)),
              const Text("END: "),
              Text(
                periodEnd.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2024),
                    );
                    setState(() {
                      if (dateTime != null) {
                        setState(() {
                          periodEnd = Period.fromDateTime(dateTime);
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.calendar_month)),
              CustomDropDownButton(
                hint: const Text(
                  "IsNormal",
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                items: const ["Normal", "Defect"],
                onChanged: onStatusChange,
                value: selectedStatus,
              ),
              CustomDropDownButton(
                hint: const Text(
                  "Defect Label",
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                items: const ["A", "B", "C", "D"],
                onChanged: onLabelChange,
                value: selectedLabel,
              ),

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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Images: ${testSteelList.length}"),
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
                              Text(
                                  "Normal: ${normalRatio.toStringAsFixed(2)}%"),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.fiber_manual_record_rounded,
                                color: Colors.red,
                              ),
                              Text(
                                  "Defect: ${defectRatio.toStringAsFixed(2)}%"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
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
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                selectedIndex = index;
                              }),
                              child: SteelPreviewWidget(
                                index: index,
                                selectedIndex: selectedIndex,
                                itemList: currList,
                                onTap: removeItemAt,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: selectedIndex != null
                      ? SteelDataBigWidget(
                          selectedIndex: selectedIndex!,
                          itemList: currList,
                        )
                      : const Text(
                          "Select Image",
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
