import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';

class SteelPreviewWidget extends StatelessWidget {
  final int index;

  const SteelPreviewWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: semiGreyColor,
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
                  color: index % 2 == 0 ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 10),
                Text("$index.jpg"),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              steelImage1,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
