import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/models/dash_board_image_model.dart';
import 'package:sfp_mobile_interface_flutter/models/dash_board_request_model.dart';
import 'package:sfp_mobile_interface_flutter/resources/http_method.dart';
import 'package:sfp_mobile_interface_flutter/setting/show_custom_date_picker.dart';
import 'package:sfp_mobile_interface_flutter/widget/custom_dropdown_button.dart';
import 'package:sfp_mobile_interface_flutter/widget/steel_image_big_widget.dart';
import 'package:sfp_mobile_interface_flutter/widget/steel_image_preview_widget.dart';

class DashBoardModeScreen extends StatefulWidget {
  const DashBoardModeScreen({super.key});

  @override
  State<DashBoardModeScreen> createState() => _DashBoardModeScreenState();
}

class _DashBoardModeScreenState extends State<DashBoardModeScreen> {
  Period periodStart = Period.fromDateTime(DateTime.now());
  Period periodEnd = Period.fromDateTime(DateTime.now());

  DateTime _dateTimeStart = DateTime.now();
  DateTime _dateTimeEnd = DateTime.now();

  double normalRatio = 0;
  double defectRatio = 0;
  int numOfNormal = 0;
  int numOfDefect = 0;

  List<DashBoardImageModel> modelList = [];

  int itemCount = 0;
  int? selectedIndex;

  String? selectedStatus;
  String? selectedLabel;

  bool isDateSelected = false;

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
      if (index == modelList.length - 1) {
        selectedIndex = null;
      }
      modelList.removeAt(index);
    });
  }

  void setRatio() {
    for (DashBoardImageModel data in modelList) {
      if (data.labelList.isEmpty) {
        numOfNormal++;
      } else {
        numOfDefect++;
      }
    }

    normalRatio = numOfNormal / itemCount * 100;
    defectRatio = numOfDefect / itemCount * 100;
    setState(() {});
  }

  Future<void> searchImage() async {
    selectedStatus ??= "ALL";
    selectedLabel ??= "ALL";

    final DashBoardRequestModel dashBoardRequestModel =
        DashBoardRequestModel.makeReqModel(
      dateTimeStart: _dateTimeStart,
      dateTimeEnd: _dateTimeEnd,
      status: selectedStatus!,
      defectLabel: selectedLabel!,
    );

    log(dashBoardRequestModel.toString());

    modelList = await HttpMethod.getDataList(dashBoardRequestModel);
    itemCount = modelList.length;

    setRatio();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: mainColor.withOpacity(.5),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("START: "),
              PeriodText(periodStart: periodStart),
              IconButton(
                  onPressed: () async {
                    DateTime? dateTime = await showCustomDatePicker(context);
                    if (dateTime != null) {
                      setState(() {
                        _dateTimeStart = dateTime;
                        periodStart = Period.fromDateTime(dateTime);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month)),
              const Text("END: "),
              PeriodText(periodStart: periodEnd),
              IconButton(
                  onPressed: () async {
                    DateTime? dateTime = await showCustomDatePicker(context);
                    if (dateTime != null) {
                      setState(() {
                        _dateTimeEnd = dateTime;
                        periodEnd = Period.fromDateTime(dateTime);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month)),
              CustomDropDownButton(
                hint: "Status",
                items: const ["ALL", "NORMAL", "DEFECT"],
                onChanged: onStatusChange,
                value: selectedStatus,
              ),
              CustomDropDownButton(
                hint: "Lable",
                items: const ["ALL", "A", "B", "C", "D"],
                onChanged: onLabelChange,
                value: selectedLabel,
              ),

              // GET 요청할 Button
              ElevatedButton(
                onPressed: () async {
                  await searchImage();
                  setState(() {});
                },
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
                          Text("Images: ${modelList.length}"),
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
                              child: SteelImagePreviewWidget(
                                index: index,
                                selectedIndex: selectedIndex,
                                itemList: modelList,
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
                      ? SteelImageBigWidget(
                          index: selectedIndex!,
                          itemList: modelList,
                        )
                      : const Center(
                          child: Text(
                            "Select Image",
                            textAlign: TextAlign.center,
                          ),
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

class PeriodText extends StatelessWidget {
  const PeriodText({
    super.key,
    required this.periodStart,
  });

  final Period periodStart;

  @override
  Widget build(BuildContext context) {
    return Text(
      periodStart.toString(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    );
  }
}
