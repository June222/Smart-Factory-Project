import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/models/steel_model.dart';

class SteelDataBigWidget extends StatelessWidget {
  final int index;
  final List<SteelModel> itemList;

  const SteelDataBigWidget({
    super.key,
    required this.index,
    required this.itemList,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: semiGreyColor,
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record_rounded,
                      color:
                          itemList[index].isNormal ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Text(itemList[index].fileName),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: InteractiveViewer(
                      maxScale: 5,
                      boundaryMargin: const EdgeInsets.all(20),
                      child: Image.asset(
                        itemList[index].detectionImageAsset,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "이미지 확대를 통해 자세히 보실 수 있습니다.",
                style: TextStyle(fontSize: 10),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: DataTable(
                  horizontalMargin: 1,
                  columns: const [
                    DataColumn(
                        label: Text(
                      "Capture Date",
                      style: TextStyle(color: Colors.white),
                    )),
                    DataColumn(
                        label: Text(
                      "Capture Time",
                      style: TextStyle(color: Colors.white),
                    )),
                    DataColumn(
                        label: Text(
                      "IsNormal",
                      style: TextStyle(color: Colors.white),
                    )),
                    DataColumn(
                        label: Text(
                      "Defect Label",
                      style: TextStyle(color: Colors.white),
                    )),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              itemList[index].captureDate.split(' ')[0],
                            ),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text(itemList[index].captureTime),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text(itemList[index].isNormal.toString()),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text(itemList[index].defectLabel),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
