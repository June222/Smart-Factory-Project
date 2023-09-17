import 'package:flutter/material.dart';

class RealTimeImagePage extends StatelessWidget {
  const RealTimeImagePage({
    super.key,
  });

  static const String routeName = "/homepage/realtime/realtimeimage";

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as RealTimeImageArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("실시간 이미지 확인"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(args.imageName),
          ],
        ),
      ),
    );
  }
}

class RealTimeImageArguments {
  final String fileName;
  final String fileNumber;
  final String date;
  final String imageName;

  RealTimeImageArguments(
    this.fileName,
    this.fileNumber,
    this.date,
    this.imageName,
  );
}
