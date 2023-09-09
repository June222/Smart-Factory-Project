import 'package:flutter/material.dart';

class ImageSourceButton extends StatelessWidget {
  const ImageSourceButton({
    super.key,
    this.onPressed,
    required this.iconData,
    required this.text,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData),
            const SizedBox(height: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
