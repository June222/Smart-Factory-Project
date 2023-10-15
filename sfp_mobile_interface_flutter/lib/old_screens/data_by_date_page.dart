// import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/screens/data_by_date_detail_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  static const String routeName = "/homepage/databydate";

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  late FocusNode _focusNode;

  final int settingRate = 3;
  String? selectedValue = "All";

  bool visibleFirstLabel = false;
  bool visibleSecondLabel = false;
  bool visibleThirdLabel = false;
  bool visibleFourthLabel = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void showDateTimePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    selectedDate.then(
      (value) => log(value.toString()),
    );
    // selectedDate.then((value) => null)
  }

  void initLabel() {
    setState(() {
      visibleFirstLabel = false;
      visibleSecondLabel = false;
      visibleThirdLabel = false;
      visibleFourthLabel = false;
    });
  }

  void setLabel(SelectionArgs selectionArgs) {
    initLabel();
    setState(() {
      switch (selectionArgs.seriesIndex) {
        case 0:
          visibleFirstLabel = true;
          break;
        case 1:
          visibleSecondLabel = true;
          break;
        case 2:
          visibleThirdLabel = true;
          break;
        case 3:
          visibleFourthLabel = true;
          break;
        default:
          break;
      }
    });
  }

  void tapOnDate(String date) {
    Navigator.pushNamed(
      context,
      DataByDateDetailPage.routeName,
      arguments: DataByDateDetailArguments(date),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: settingRate,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("날짜:"),
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: "YYYY-MM-DD",
                                suffixIcon: IconButton(
                                  onPressed: showDateTimePickerPop,
                                  icon:
                                      const Icon(Icons.calendar_month_rounded),
                                ),
                              ),

                              // scrollPadding: const EdgeInsets.all(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: settingRate,
                      child: Row(
                        children: [
                          const Text("결함 클래스:"),
                          Expanded(
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedValue,
                              iconSize: 30,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              },
                              items: [
                                "All",
                                "1",
                                "2",
                                "3"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  alignment: Alignment.center,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: settingRate,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("검색하기"),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "날짜",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "개수",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(child: Text("")),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "2023-09-14",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Text(
                                        "150 / 150",
                                        textAlign: TextAlign.center,
                                      ),
                                      Positioned(
                                        left: 150,
                                        right: 0,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.arrow_downward_rounded),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "자세히 보기",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: width,
                              height: height / 2,
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                              ),
                              child: SfCartesianChart(
                                title: ChartTitle(text: "Columns Chart"),
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(),
                                selectionType: SelectionType.series,
                                selectionGesture: ActivationMode.singleTap,
                                onAxisLabelTapped: (args) {
                                  log(args.text);
                                  tapOnDate(args.text);
                                },
                                onSelectionChanged: setLabel,
                                legend: const Legend(
                                  isVisible: true,
                                  iconHeight: 30,
                                ),
                                zoomPanBehavior: ZoomPanBehavior(
                                  enablePanning: true,
                                  maximumZoomLevel: 0.1,
                                  enablePinching: true,
                                  zoomMode: ZoomMode.x,
                                ),
                                trackballBehavior: TrackballBehavior(
                                  enable: true,
                                  lineType: TrackballLineType.vertical,
                                  tooltipAlignment: ChartAlignment.near,
                                  tooltipDisplayMode:
                                      TrackballDisplayMode.floatAllPoints,
                                ),
                                series: [
                                  ColumnSeries(
                                    enableTooltip: true,
                                    name: "Class A",
                                    dataLabelMapper: (datum, index) =>
                                        datum.class_one_num.toString(),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: visibleFirstLabel,
                                    ),
                                    selectionBehavior: SelectionBehavior(
                                      enable: true,
                                    ),
                                    dataSource: <DataByDate>[
                                      DataByDate(80, 50, 15, 5, "2023-09-14"),
                                      DataByDate(80, 50, 15, 5, "2023-09-15"),
                                      DataByDate(50, 30, 5, 15, "2023-09-16"),
                                      DataByDate(50, 30, 5, 15, "2023-09-17"),
                                      DataByDate(50, 30, 5, 15, "2023-09-18"),
                                      DataByDate(50, 30, 5, 15, "2023-09-19"),
                                      DataByDate(50, 30, 5, 15, "2023-09-20"),
                                      DataByDate(50, 30, 5, 15, "2023-09-21"),
                                      DataByDate(50, 30, 5, 15, "2023-09-22"),
                                      DataByDate(50, 30, 5, 15, "2023-09-23"),
                                    ],
                                    xValueMapper: (datum, index) => datum.date,
                                    yValueMapper: (datum, index) =>
                                        datum.class_one_num,
                                  ),
                                  ColumnSeries(
                                    name: "Class B",
                                    selectionBehavior: SelectionBehavior(
                                      enable: true,
                                    ),
                                    dataLabelMapper: (datum, index) =>
                                        datum.class_two_num.toString(),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: visibleSecondLabel,
                                    ),
                                    dataSource: <DataByDate>[
                                      DataByDate(80, 50, 15, 5, "2023-09-14"),
                                      DataByDate(80, 50, 15, 5, "2023-09-15"),
                                      DataByDate(50, 30, 5, 15, "2023-09-16"),
                                      DataByDate(50, 30, 5, 15, "2023-09-17"),
                                      DataByDate(50, 30, 5, 15, "2023-09-18"),
                                      DataByDate(50, 30, 5, 15, "2023-09-19"),
                                      DataByDate(50, 30, 5, 15, "2023-09-20"),
                                      DataByDate(50, 30, 5, 15, "2023-09-21"),
                                      DataByDate(50, 30, 5, 15, "2023-09-22"),
                                      DataByDate(50, 30, 5, 15, "2023-09-23"),
                                    ],
                                    xValueMapper: (datum, index) => datum.date,
                                    yValueMapper: (datum, index) =>
                                        datum.class_two_num,
                                  ),
                                  ColumnSeries(
                                    name: "Class C",
                                    selectionBehavior: SelectionBehavior(
                                      enable: true,
                                    ),
                                    dataLabelMapper: (datum, index) =>
                                        datum.class_three_num.toString(),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: visibleThirdLabel,
                                    ),
                                    dataSource: <DataByDate>[
                                      DataByDate(80, 50, 15, 5, "2023-09-14"),
                                      DataByDate(80, 50, 15, 5, "2023-09-15"),
                                      DataByDate(50, 30, 5, 15, "2023-09-16"),
                                      DataByDate(50, 30, 5, 15, "2023-09-17"),
                                      DataByDate(50, 30, 5, 15, "2023-09-18"),
                                      DataByDate(50, 30, 5, 15, "2023-09-19"),
                                      DataByDate(50, 30, 5, 15, "2023-09-20"),
                                      DataByDate(50, 30, 5, 15, "2023-09-21"),
                                      DataByDate(50, 30, 5, 15, "2023-09-22"),
                                      DataByDate(50, 30, 5, 15, "2023-09-23"),
                                    ],
                                    xValueMapper: (datum, index) => datum.date,
                                    yValueMapper: (datum, index) =>
                                        datum.class_three_num,
                                  ),
                                  ColumnSeries(
                                    name: "Class D",
                                    selectionBehavior: SelectionBehavior(
                                      enable: true,
                                    ),
                                    dataLabelMapper: (datum, index) =>
                                        datum.class_four_num.toString(),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: visibleFourthLabel,
                                    ),
                                    dataSource: <DataByDate>[
                                      DataByDate(80, 50, 15, 5, "2023-09-14"),
                                      DataByDate(80, 50, 15, 5, "2023-09-15"),
                                      DataByDate(50, 30, 5, 15, "2023-09-16"),
                                      DataByDate(50, 30, 5, 15, "2023-09-17"),
                                      DataByDate(50, 30, 5, 15, "2023-09-18"),
                                      DataByDate(50, 30, 5, 15, "2023-09-19"),
                                      DataByDate(50, 30, 5, 15, "2023-09-20"),
                                      DataByDate(50, 30, 5, 15, "2023-09-21"),
                                      DataByDate(50, 30, 5, 15, "2023-09-22"),
                                      DataByDate(50, 30, 5, 15, "2023-09-23"),
                                    ],
                                    xValueMapper: (datum, index) => datum.date,
                                    yValueMapper: (datum, index) =>
                                        datum.class_four_num,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataByClass {
  final String class_name;
  final double numbers;

  DataByClass(this.class_name, this.numbers);
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

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
