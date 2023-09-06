import 'package:flutter/material.dart';
import 'package:graduation_assignment/data/widget_data/widget_data.dart';

class ClassBarGraphWidget extends StatelessWidget {
  const ClassBarGraphWidget({
    super.key,
    required this.unSortedClassMap,
    required this.classNumber,
    required this.color,
  });

  final Map<String, int> unSortedClassMap;
  final int classNumber;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    const verticalPadding = EdgeInsets.symmetric(vertical: 7);
    const textHorizonPadding = EdgeInsets.symmetric(horizontal: 20.0);

    const boxGraphHeight = 25.0;
    final barGraphRadius = BorderRadius.circular(7);

    var classIndex = classNumber - 1;
    final value = unSortedClassMap.values.elementAt(classIndex);

    double getWidthFactor(int value) {
      // 비율에 맞는 박스 width 제공
      double widthFactor;
      if (value <= 10) {
        // 비율이 너무 작으면 text 잘려서 여유 공간 제공
        widthFactor = value / 100 + 0.1;
      } else {
        // 충분히 클 경우 정상 제공
        widthFactor = value / 100;
      }
      return widthFactor;
    }

    return Padding(
      padding: verticalPadding,
      child: Row(
        children: [
          Padding(
            padding: textHorizonPadding,
            child: Text(
              unSortedClassMap.keys.elementAt(classIndex),
              style: boldStyle,
            ),
          ),
          // const Spacer(),
          Expanded(
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Container(
                  height: boxGraphHeight,
                  decoration: BoxDecoration(
                    color: color.shade50,
                    borderRadius: barGraphRadius,
                  ),
                  child: const Text(""),
                ),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: getWidthFactor(value),
                  child: Container(
                    alignment: Alignment.center,
                    height: boxGraphHeight,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: barGraphRadius,
                    ),
                    child: Text(
                      "$value%",
                      style: boldStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
