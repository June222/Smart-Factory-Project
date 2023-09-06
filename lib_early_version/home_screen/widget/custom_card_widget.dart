import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomCardWidget extends StatefulWidget {
  const CustomCardWidget({
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
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  double horizontal_padding_pixel = 10;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal_padding_pixel),
          child: Card(
            shape: RoundedRectangleBorder(
                side: widget.selected
                    ? BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1)
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
          left: horizontal_padding_pixel + 15,
          bottom: 15,
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedOpacity(
              opacity: widget.selected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                width: 120,
                child: Text(widget.buttonText),
              ),
            ),
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .shakeX(
              delay: const Duration(seconds: 3),
              duration: const Duration(milliseconds: 300),
              amount: 1.5,
            )
      ],
    );
  }
}
