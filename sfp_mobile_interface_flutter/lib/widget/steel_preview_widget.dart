import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/models/steel_model.dart';

class SteelPreviewWidget extends StatelessWidget {
  final int index;
  final int? selectedIndex;
  final List<SteelModel> itemList;
  final Function(int index)? onTap;

  const SteelPreviewWidget({
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
                  color: itemList[index].isNormal ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 10),
                Text(itemList[index].fileName),
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
            child: Image.asset(
              itemList[index].imageAsset,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
