import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/chart_setting.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/models/graph_bar_model.dart';
import 'package:sfp_mobile_interface_flutter/models/graph_request_model.dart';
import 'package:sfp_mobile_interface_flutter/resources/http_method.dart';
import 'package:sfp_mobile_interface_flutter/setting/show_custom_date_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphModeScreen extends StatefulWidget {
  const GraphModeScreen({super.key});

  @override
  State<GraphModeScreen> createState() => _GraphModeScreenState();
}

class _GraphModeScreenState extends State<GraphModeScreen> {
  Period periodStart = Period.fromDateTime(DateTime.now());
  Period periodEnd = Period.fromDateTime(DateTime.now());

  DateTime? _dateTimeStart = DateTime.now();
  DateTime? _dateTimeEnd = DateTime.now();

  List<GraphBarModel> dataList = [];

  bool visibleFirstLabel = false;
  bool visibleSecondLabel = false;
  bool visibleThirdLabel = false;
  bool visibleFourthLabel = false;

  int? selectedSeriesIndex;

  // 클릭한 label 초기화
  void initLabel() {
    setState(() {
      visibleFirstLabel = false;
      visibleSecondLabel = false;
      visibleThirdLabel = false;
      visibleFourthLabel = false;
      selectedSeriesIndex = null;
    });
  }

  // 클릭한 label selectedLabel로 변환해주는 함수
  void setLabel(SelectionArgs selectionArgs) {
    initLabel();

    if (selectionArgs.seriesIndex == selectedSeriesIndex) {
      selectedSeriesIndex = null;
      return;
    }

    setState(() {
      switch (selectionArgs.seriesIndex) {
        case 0:
          selectedSeriesIndex = 0;
          visibleFirstLabel = true;
          break;
        case 1:
          selectedSeriesIndex = 1;
          visibleSecondLabel = true;
          break;
        case 2:
          selectedSeriesIndex = 2;
          visibleThirdLabel = true;
          break;
        case 3:
          selectedSeriesIndex = 3;
          visibleFourthLabel = true;
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: mainColor.withOpacity(0.5),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("START: "),
              Text(
                periodStart.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              // 지정한 조회 시작 날짜 렌더링
              IconButton(
                  onPressed: () async {
                    _dateTimeStart = await showCustomDatePicker(context);
                    setState(() {
                      if (_dateTimeStart != null) {
                        setState(() {
                          periodStart = Period.fromDateTime(_dateTimeStart!);
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
              // 지정한 조회 종료 날짜 렌더링
              IconButton(
                  onPressed: () async {
                    _dateTimeEnd = await showCustomDatePicker(context);
                    if (_dateTimeEnd != null) {
                      setState(() {
                        periodEnd = Period.fromDateTime(_dateTimeEnd!);
                      });
                    }
                    setState(() {});
                  },
                  icon: const Icon(Icons.calendar_month)),

              // GET 요청할 Button
              ElevatedButton(
                onPressed: () async {
                  // null 일 경우 현재로 설정
                  _dateTimeStart ??= DateTime.now();
                  _dateTimeEnd ??= DateTime.now();

                  // mysql 서버로 전송할 Model 생성
                  GraphRequestModel graphRequestModel =
                      GraphRequestModel.fromDateTime(
                          _dateTimeStart!, _dateTimeEnd!);

                  // 서버에서 Data 받아오기
                  dataList = await HttpMethod.getGraphDataList(
                      graphRequestModel, context);
                  setState(() {});
                },
                child: const Text("조회하기"),
              ),
            ],
          ),
        ),
        // Column 차트 렌더링
        Expanded(
          child: SfCartesianChart(
            title: ChartTitle(text: "Columns Chart"),
            primaryXAxis: CategoryAxis(title: AxisTitle(text: "날짜")),
            primaryYAxis: NumericAxis(title: AxisTitle(text: "개수")),
            selectionType: SelectionType.series,
            selectionGesture: ActivationMode.singleTap,
            backgroundColor: Colors.white,
            onSelectionChanged: setLabel,
            legend: legend,
            zoomPanBehavior: zoomPanBehavior,
            trackballBehavior: trackballBehavior,
            series: [
              ColumnSeries(
                enableTooltip: true,
                name: "Class A",
                selectionBehavior: customSelectionBehavior(),
                dataLabelMapper: (datum, index) =>
                    datum.class_one_num.toString(),
                dataLabelSettings: customDataLabelSettings(visibleFirstLabel),
                dataSource: dataList,
                xValueMapper: (datum, index) => datum.date,
                yValueMapper: (datum, index) => datum.class_one_num,
              ),
              ColumnSeries(
                name: "Class B",
                selectionBehavior: customSelectionBehavior(),
                dataLabelMapper: (datum, index) =>
                    datum.class_two_num.toString(),
                dataLabelSettings: customDataLabelSettings(visibleSecondLabel),
                dataSource: dataList,
                xValueMapper: (datum, index) => datum.date,
                yValueMapper: (datum, index) => datum.class_two_num,
              ),
              ColumnSeries(
                name: "Class C",
                selectionBehavior: customSelectionBehavior(),
                dataLabelMapper: (datum, index) =>
                    datum.class_three_num.toString(),
                dataLabelSettings: customDataLabelSettings(visibleThirdLabel),
                dataSource: dataList,
                xValueMapper: (datum, index) => datum.date,
                yValueMapper: (datum, index) => datum.class_three_num,
              ),
              ColumnSeries(
                name: "Class D",
                selectionBehavior: customSelectionBehavior(),
                dataLabelMapper: (datum, index) =>
                    datum.class_four_num.toString(),
                dataLabelSettings: customDataLabelSettings(visibleFourthLabel),
                dataSource: dataList,
                xValueMapper: (datum, index) => datum.date,
                yValueMapper: (datum, index) => datum.class_four_num,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
