import 'package:flutter/material.dart';
import 'package:graduation_assignment/data/function_data/function_data.dart';
import 'package:graduation_assignment/data/string_data/string_data.dart';
import 'package:graduation_assignment/data/widget_data/widget_data.dart';

class DevelopIntroductionPage extends StatelessWidget {
  const DevelopIntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: introductionAppBar("개발 목적"),
      body: SafeArea(
          child: Padding(
        padding: introductionPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(coding_image),
            Text(
              "배경",
              style: headLineStyle,
            ),
            Text(
              bg_text,
              style: boldStyle,
            ),
            Text(
              "목적",
              style: headLineStyle,
            ),
            Text(
              pp_text,
              style: boldStyle,
            ),
          ],
        ),
      )),
    );
  }
}
