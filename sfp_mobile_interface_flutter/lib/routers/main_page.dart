import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/screens/dashboard_mode_screen.dart';
import 'package:sfp_mobile_interface_flutter/screens/graph_mode_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static String routeName = '/mainpage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Dashboard Mode와 GraphMode를 구분
  bool dashBoardMode = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Steel See Preview"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                dashBoardMode = !dashBoardMode;
              });
              log("dashboard Mode : $dashBoardMode");
            },
            child: dashBoardMode
                ? const Text("Turn to Graph")
                : const Text("Turn to DashBoard"),
          )
        ],
      ),
      body: SafeArea(
        child: dashBoardMode
            ? const DashBoardModeScreen()
            : const GraphModeScreen(),
      ),
    );
  }
}
