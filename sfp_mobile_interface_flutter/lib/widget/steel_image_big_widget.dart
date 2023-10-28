import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/models/dash_board_image_model.dart';

class SteelImageBigWidget extends StatelessWidget {
  final int index;
  final List<DashBoardImageModel> itemList;

  const SteelImageBigWidget({
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
                      color: itemList[index].labelList.isEmpty
                          ? Colors.green
                          : Colors.red,
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
                        child: Image.network(
                          itemList[index].detectedImgURL,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                              child:
                                  CircularProgressIndicator(color: mainColor),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Text("이미지를 로드할 수 없습니다."));
                          },
                        )),
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
                              itemList[index].date,
                            ),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text(itemList[index].second),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                                (itemList[index].labelList.isEmpty).toString()),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text(itemList[index].labelList.toString()),
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
