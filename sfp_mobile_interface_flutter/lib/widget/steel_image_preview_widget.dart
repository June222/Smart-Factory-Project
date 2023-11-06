import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/models/dash_board_image_model.dart';

class SteelImagePreviewWidget extends StatelessWidget {
  final int index;
  final int? selectedIndex;
  final List<DashBoardImageModel> itemList;
  final Function(int index)? onTap;

  const SteelImagePreviewWidget({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.itemList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selectedIndex == index ? mainColor : semiGreyColor,
          width: 2.5,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        color: Colors.black,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.fiber_manual_record_rounded,
                  color: itemList[index].labelList.isEmpty
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(width: 10),
                Text(
                  itemList[index].fileName,
                  style: const TextStyle(fontSize: 10),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (onTap != null) {
                          onTap!(index);
                        }
                      },
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.network(
              itemList[index].originImgURL,
              fit: BoxFit.fitHeight,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Text("이미지를 불러올 수 없습니다.");
              },
            ),
          ),
        ],
      ),
    );
  }
}
