import 'package:flutter/material.dart';

class DateTimePage extends StatelessWidget {
  const DateTimePage({super.key});

  static const String routeName = "/homepage/datetime";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Text("1"),
      ),
    );
  }
}
