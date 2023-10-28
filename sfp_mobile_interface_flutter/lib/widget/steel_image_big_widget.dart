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
    // 현재 위젯이 차지할 수 있는 공간 체크
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 색상 부여
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
                    // 결함 유무에 따른 색상 출력
                    Icon(
                      Icons.fiber_manual_record_rounded,
                      color: itemList[index].labelList.isEmpty
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    // 파일 이름(촬영자 이름)
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
                    // 확대 가능한 이미지 렌더링
                    child: InteractiveViewer(
                      maxScale: 5,
                      boundaryMargin: const EdgeInsets.all(20),
                      // network를 통한 이미지 받아오기
                      child: Image.network(
                        itemList[index].detectedImgURL,
                        loadingBuilder: (context, child, loadingProgress) {
                          // 로딩이 끝날 경우 원하는 이미지 출력
                          if (loadingProgress == null) {
                            return child;
                          }
                          // 로딩 중일 경우 로딩 아이콘 렌더링
                          return const Center(
                            child: CircularProgressIndicator(color: mainColor),
                          );
                        },
                        // 로딩에 문제가 생길 경우 렌더링
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text("이미지를 로드할 수 없습니다."));
                        },
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
              // 데이터의 자세한 명세
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
