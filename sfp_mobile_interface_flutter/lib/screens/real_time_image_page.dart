import 'package:flutter/material.dart';

class RealTimeImagePage extends StatelessWidget {
  const RealTimeImagePage({super.key});

  static const String routeName = "/homepage/realtime/realtimeimage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("실시간 이미지 확인"),
      ),
      body: const SafeArea(child: Text("1")),
    );
  }
}
