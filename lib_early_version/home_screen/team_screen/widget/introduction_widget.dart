import 'package:flutter/material.dart';

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({
    super.key,
    required this.offstage,
    required this.text,
  });

  final bool offstage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !offstage,
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      )),
    );
  }
}
