import 'package:flutter/material.dart';
import 'package:graduation_assignment/data/function_data/function_data.dart';
import 'package:graduation_assignment/data/string_data/string_data.dart';
import 'package:graduation_assignment/data/widget_data/widget_data.dart';

class ServiceIntroductionPage extends StatelessWidget {
  const ServiceIntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: introductionAppBar("서비스 소개"),
      body: SafeArea(
          child: Padding(
        padding: introductionPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(service_image),
            Text(
              "Steel See는",
              style: headLineStyle,
            ),
            Text(
              service_intro_text_1,
              style: boldStyle,
            ),
            Text(
              service_intro_text_2,
              style: boldStyle,
            ),
          ],
        ),
      )),
    );
  }
}
