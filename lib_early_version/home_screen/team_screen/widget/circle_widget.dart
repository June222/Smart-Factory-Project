import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({
    super.key,
    required this.asset,
    required this.selected,
    this.onTap,
    required this.name,
  });

  final String asset;
  final bool selected;
  final Function()? onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? Colors.purple : Colors.white,
                width: 3,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              asset,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
                color: selected ? Colors.purple : Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
