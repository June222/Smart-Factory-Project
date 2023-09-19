// import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  static const String routeName = "/homepage/datetime";

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  late FocusNode _focusNode;

  final int settingRate = 3;
  String? selectedValue = "All";
  final bool _offstage = true;

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
                  // crossAxisAlignment: CrossAxisAlignment.end,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SfCartesianChart(
                                  //   primaryXAxis: CategoryAxis(),
                                  //   series: [
                                  //     // ColumnSeries(
                                  //     //   dataSource: <DataByClass>[
                                  //     //     DataByClass("1", 80),
                                  //     //     DataByClass("2", 50),
                                  //     //     DataByClass("3", 15),
                                  //     //     DataByClass("4", 5),
                                  //     //   ],
                                  //     //   xValueMapper: (datum, index) =>
                                  //     //       datum.class_name,
                                  //     //   yValueMapper: (datum, index) =>
                                  //     //       datum.numbers,
                                  //     // ),
                                  //     LineSeries(
                                  //       // markerSettings:
                                  //       //     const TrackballMarkerSettings(
                                  //       //   markerVisibility:
                                  //       //       TrackballVisibilityMode.visible,
                                  //       //   height: 100,
                                  //       //   width: 20,
                                  //       //   color: Colors.black,
                                  //       //   shape: DataMarkerType.circle,
                                  //       // ),
                                  //       dataSource: <DataByClass>[
                                  //         DataByClass("1", 80),
                                  //         DataByClass("2", 50),
                                  //         DataByClass("3", 15),
                                  //         DataByClass("4", 5),
                                  //       ],
                                  //       xValueMapper: (datum, index) =>
                                  //           datum.class_name,
                                  //       yValueMapper: (datum, index) =>
                                  //           datum.numbers,
                                  //     ),
                                  //   ],
                                  //   // series: <LineSeries<DateByClass, String>>[
                                  //   //   LineSeries<DateByClass, String>(
                                  //   //     dataSource: <DateByClass>[
                                  //   //       DateByClass("1", 80),
                                  //   //       DateByClass("2", 50),
                                  //   //       DateByClass("3", 15),
                                  //   //       DateByClass("4", 5),
                                  //   //     ],
                                  //   //     xValueMapper: (datum, index) =>
                                  //   //         datum.class_name,
                                  //   //     yValueMapper: (datum, index) =>
                                  //   //         datum.numbers,
                                  //   //   )
                                  //   // ],
                                  // ),
                                  // SfSparkLineChart(
                                  //   trackball: const SparkChartTrackball(
                                  //     activationMode:
                                  //         SparkChartActivationMode.tap,
                                  //   ),
                                  //   marker: const SparkChartMarker(
                                  //       displayMode:
                                  //           SparkChartMarkerDisplayMode.all),
                                  //   labelDisplayMode:
                                  //       SparkChartLabelDisplayMode.all,
                                  //   data: const [80, 50, 15, 5],
                                  // ),
                                  SfCartesianChart(
                                    // plotAreaBorderWidth: 0.8,

                                    zoomPanBehavior: ZoomPanBehavior(
                                      enablePanning: true,
                                      enableDoubleTapZooming: true,
                                      maximumZoomLevel: 3,
                                    ),

                                    primaryXAxis: CategoryAxis(),
                                    // selectionType: SelectionType.series,
                                    series: [
                                      ColumnSeries(
                                        dataSource: <DataByDate>[
                                          DataByDate(80, 50, 15, 5, "1"),
                                          DataByDate(80, 50, 15, 5, "2"),
                                          DataByDate(50, 30, 5, 15, "3"),
                                          DataByDate(50, 30, 5, 15, "4"),
                                          DataByDate(50, 30, 5, 15, "5"),
                                        ],
                                        xValueMapper: (datum, index) =>
                                            datum.date,
                                        yValueMapper: (datum, index) =>
                                            datum.class_one_num,
                                      ),
                                      ColumnSeries(
                                        dataSource: <DataByDate>[
                                          DataByDate(80, 50, 15, 5, "1"),
                                          DataByDate(80, 50, 15, 5, "2"),
                                          DataByDate(50, 30, 5, 15, "3"),
                                          DataByDate(50, 30, 5, 15, "4"),
                                          DataByDate(50, 30, 5, 15, "5"),
                                        ],
                                        xValueMapper: (datum, index) =>
                                            datum.date,
                                        yValueMapper: (datum, index) =>
                                            datum.class_two_num,
                                      ),
                                      ColumnSeries(
                                        dataSource: <DataByDate>[
                                          DataByDate(80, 50, 15, 5, "1"),
                                          DataByDate(80, 50, 15, 5, "2"),
                                          DataByDate(50, 30, 5, 15, "3"),
                                          DataByDate(50, 30, 5, 15, "4"),
                                          DataByDate(50, 30, 5, 15, "5"),
                                        ],
                                        xValueMapper: (datum, index) =>
                                            datum.date,
                                        yValueMapper: (datum, index) =>
                                            datum.class_three_num,
                                      ),
                                      ColumnSeries(
                                        dataSource: <DataByDate>[
                                          DataByDate(80, 50, 15, 5, "1"),
                                          DataByDate(80, 50, 15, 5, "2"),
                                          DataByDate(50, 30, 5, 15, "3"),
                                          DataByDate(50, 30, 5, 15, "4"),
                                          DataByDate(50, 30, 5, 15, "5"),
                                        ],
                                        xValueMapper: (datum, index) =>
                                            datum.date,
                                        yValueMapper: (datum, index) =>
                                            datum.class_four_num,
                                      ),
                                    ],
                                  ),
                                  // SfCartesianChart(
                                  //   primaryXAxis: CategoryAxis(),
                                  //   primaryYAxis: NumericAxis(),
                                  //   series: <ChartSeries>[
                                  //     // 첫 번째 시리즈
                                  //     ColumnSeries<ChartData, String>(
                                  //       dataSource: <ChartData>[
                                  //         ChartData('Category A', 30),
                                  //         ChartData('Category B', 50),
                                  //         ChartData('Category C', 20),
                                  //       ],
                                  //       xValueMapper: (ChartData sales, _) =>
                                  //           sales.category,
                                  //       yValueMapper: (ChartData sales, _) =>
                                  //           sales.value,
                                  //       name: 'Series 1',
                                  //     ),
                                  //     // 두 번째 시리즈
                                  //     ColumnSeries<ChartData, String>(
                                  //       dataSource: <ChartData>[
                                  //         ChartData('Category A', 40),
                                  //         ChartData('Category B', 20),
                                  //         ChartData('Category C', 60),
                                  //       ],
                                  //       xValueMapper: (ChartData sales, _) =>
                                  //           sales.category,
                                  //       yValueMapper: (ChartData sales, _) =>
                                  //           sales.value,
                                  //       name: 'Series 2',
                                  //     ),
                                  //   ],
                                  // ),
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
  final double class_one_num;
  final double class_two_num;
  final double class_three_num;
  final double class_four_num;

  DataByDate(this.class_one_num, this.class_two_num, this.class_three_num,
      this.class_four_num, this.date);
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
