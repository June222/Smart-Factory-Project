import 'package:flutter/material.dart';
import 'package:graduation_assignment/data/widget_data/widget_data.dart';

class TestCustomCard extends StatefulWidget {
  const TestCustomCard({
    super.key,
    required this.name,
    required this.selected,
    required this.buttonText,
    required this.onTap,
  });

  final String name;
  final bool selected;
  final String buttonText;
  final Function()? onTap;

  @override
  State<TestCustomCard> createState() => _TestCustomCardState();
}

class _TestCustomCardState extends State<TestCustomCard> {
  double horizontal_padding_pixel = 10;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontal_padding_pixel),
            child: Card(
              shape: RoundedRectangleBorder(
                  side: widget.selected
                      ? BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        )
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                widget.name,
                width: width * 0.7,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: width / 4,
            right: width / 4,
            child: AnimatedOpacity(
              opacity: widget.selected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Text(
                widget.buttonText,
                textAlign: TextAlign.center,
                style: boldStyle.copyWith(
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
