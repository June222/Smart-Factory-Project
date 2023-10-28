import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/data/sliver_gride_setting_data.dart';
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
  // 조회 시작 날짜 전송할 변수
  DateTime _dateTimeStart = DateTime.now();
  DateTime _dateTimeEnd = DateTime.now();

  // 조회 시작 날짜 출력할 변수
  Period periodStart = Period.fromDateTime(DateTime.now());
  Period periodEnd = Period.fromDateTime(DateTime.now());

  // 이미지 비율 받을 변수
  double normalRatio = 0;
  double defectRatio = 0;
  int numOfNormal = 0;
  int numOfDefect = 0;

  // 받은 이미지를 보관할 변수
  List<DashBoardImageModel> modelList = [];
  int itemCount = 0;

  // 선택한 이미지를 저장할 변수
  int? selectedIndex;

  // 조회 설정을 저장할 변수
  String? selectedStatus;
  String? selectedLabel;

  // 조회 버튼 클릭 유무
  bool isDateSelected = false;

  // 조회하고싶은 이미지의 defect 상태 확인
  void onStatusChange(String? value) {
    setState(() {
      log("status change");
      selectedStatus = value;
    });
  }

  // 조회하고싶은 이미지의 label 확인
  void onLabelChange(String? value) {
    setState(() {
      log("label change");
      selectedLabel = value;
    });
  }

  // 미리보기 이미지 삭제.
  void removeItemAt(int index) {
    log("remove At $index");
    setState(() {
      if (index == modelList.length - 1) {
        selectedIndex = null;
      }
      modelList.removeAt(index);
    });
  }

  // 불러온 이미지의 개수 및 비율 계산
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

  // 이미지 조회
  Future<void> searchImage() async {
    selectedStatus ??= "ALL";
    selectedLabel ??= "ALL";

    // 서버에 전송할 데이터를 위한 모델 클래스
    final DashBoardRequestModel dashBoardRequestModel =
        DashBoardRequestModel.makeReqModel(
      dateTimeStart: _dateTimeStart,
      dateTimeEnd: _dateTimeEnd,
      status: selectedStatus!,
      defectLabel: selectedLabel!,
    );

    log(dashBoardRequestModel.toString());

    // 데이터 전송
    modelList =
        await HttpMethod.getDashBoardDataList(dashBoardRequestModel, context);
    itemCount = modelList.length;

    // 비율 계산
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
              // 조회 시작 날짜 렌더링
              PeriodText(periodStart: periodStart),
              // 조회 시작 날짜 고르기
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
              // 조회 끝나는 날짜 렌더링
              PeriodText(periodStart: periodEnd),
              // 조회 끝나는 날짜 고르기
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
                icon: const Icon(Icons.calendar_month),
              ),
              // 조회할 이미지 status 설정
              CustomDropDownButton(
                hint: "Status",
                items: const ["ALL", "NORMAL", "DEFECT"],
                onChanged: onStatusChange,
                value: selectedStatus,
              ),
              // 조회할 이미지 label 설정
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
                child: const Text("조회하기"),
              ),
            ],
          ),
        ),
        // 이미지 미리보기 칸
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
                          // 이미지 개수
                          Text("Images: ${modelList.length}"),
                          // divider
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
                              // 정상 이미지 비율
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
                              // 결함 이미지 비율
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
                          gridDelegate: sliverGridSetting,
                          itemBuilder: (_, index) {
                            // 선택하면 선택한 이미지 출력
                            return GestureDetector(
                              onTap: () => setState(() {
                                selectedIndex = index;
                              }),
                              // 미리보기 이미지 위젯
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
              // 이미지 확대보기 칸
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  // 선택한 이미지 확대 출력하기
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
