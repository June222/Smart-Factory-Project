import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// 차트의 세부 내용 렌더링 설정
TrackballBehavior trackballBehavior = TrackballBehavior(
  enable: true,
  lineType: TrackballLineType.vertical,
  tooltipAlignment: ChartAlignment.near,
  tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
);

// 차트의 확대 및 축소 비율 설정
ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(
  enablePanning: true,
  maximumZoomLevel: 0.1,
  enablePinching: true,
  zoomMode: ZoomMode.x,
);

// 차트의 Legend 설정
Legend legend = const Legend(
  isVisible: true,
  iconHeight: 30,
  textStyle: TextStyle(color: Colors.black),
);

// 클릭 시 어떤 Label이 보이게 할 지 설정
DataLabelSettings customDataLabelSettings(bool visibleLabel) {
  return DataLabelSettings(
    isVisible: visibleLabel,
    textStyle: const TextStyle(color: Colors.white),
    useSeriesColor: true,
  );
}

// 막대를 클릭 시에 나타낼 설정
SelectionBehavior customSelectionBehavior() => SelectionBehavior(enable: true);
