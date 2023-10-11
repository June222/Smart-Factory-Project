import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphModeScreen extends StatefulWidget {
  const GraphModeScreen({super.key});

  @override
  State<GraphModeScreen> createState() => _GraphModeScreenState();
}

class _GraphModeScreenState extends State<GraphModeScreen> {
  Period periodStart = Period("2023", "10", "1");
  Period periodEnd = Period("2023", "10", "3");

  bool visibleFirstLabel = false;
  bool visibleSecondLabel = false;
  bool visibleThirdLabel = false;
  bool visibleFourthLabel = false;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
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

              // GET 요청할 Button
              ElevatedButton(
                onPressed: () {},
                child: const Text("Jump"),
              ),
            ],
          ),
        ),
        Expanded(
          child: SfCartesianChart(
            title: ChartTitle(text: "Columns Chart"),
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            selectionType: SelectionType.series,
            selectionGesture: ActivationMode.singleTap,
            onAxisLabelTapped: (args) {},
            onSelectionChanged: setLabel,
            backgroundColor: Colors.white,
            legend: const Legend(
                isVisible: true,
                iconHeight: 30,
                textStyle: TextStyle(color: Colors.white)),
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
              tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
            ),
            series: [
              ColumnSeries(
                enableTooltip: true,
                name: "Class A",
                dataLabelMapper: (datum, index) =>
                    datum.class_one_num.toString(),
                dataLabelSettings: DataLabelSettings(
                  isVisible: visibleFirstLabel,
                  textStyle: const TextStyle(color: Colors.white),
                  useSeriesColor: true,
                ),
                selectionBehavior: SelectionBehavior(enable: true),
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
                yValueMapper: (datum, index) => datum.class_one_num,
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
                  textStyle: const TextStyle(color: Colors.white),
                  useSeriesColor: true,
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
                yValueMapper: (datum, index) => datum.class_two_num,
              ),
              ColumnSeries(
                name: "Class C",
                selectionBehavior: SelectionBehavior(enable: true),
                dataLabelMapper: (datum, index) =>
                    datum.class_three_num.toString(),
                dataLabelSettings: DataLabelSettings(
                  isVisible: visibleThirdLabel,
                  textStyle: const TextStyle(color: Colors.white),
                  useSeriesColor: true,
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
                yValueMapper: (datum, index) => datum.class_three_num,
              ),
              ColumnSeries(
                name: "Class D",
                selectionBehavior: SelectionBehavior(enable: true),
                dataLabelMapper: (datum, index) =>
                    datum.class_four_num.toString(),
                dataLabelSettings: DataLabelSettings(
                  isVisible: visibleFourthLabel,
                  textStyle: const TextStyle(color: Colors.white),
                  useSeriesColor: true,
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
                yValueMapper: (datum, index) => datum.class_four_num,
              ),
            ],
          ),
        )
      ],
    );
  }
}
