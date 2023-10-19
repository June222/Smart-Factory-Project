import 'package:flutter/material.dart';

class RealTimeImagePage extends StatefulWidget {
  const RealTimeImagePage({
    super.key,
  });

  static const String routeName = "/homepage/realtime/realtimeimage";

  @override
  State<RealTimeImagePage> createState() => _RealTimeImagePageState();
}

class _RealTimeImagePageState extends State<RealTimeImagePage> {
  int _pointersCount = 0;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as RealTimeImageArguments;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("실시간 이미지 확인"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            physics: _pointersCount == 2
                ? const NeverScrollableScrollPhysics()
                : null,
            child: Column(
              children: [
                const Text("촬영된 이미지"),
                Listener(
                  onPointerDown: (event) => setState(() {
                    _pointersCount++;
                  }),
                  onPointerUp: (event) => setState(() {
                    _pointersCount--;
                  }),
                  child: Container(
                    color: Colors.amber,
                    child: InteractiveViewer(
                      maxScale: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          args.imageName,
                          width: width,
                          height: height / 3,
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Text("${args.fileName} / ${args.fileNumber} / ${args.date}"),
                // const Divider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Divider(),
                      ElevatedButton(
                        autofocus: true,
                        onPressed: () {},
                        child: const Text("분류하기"),
                      ),
                    ],
                  ),
                ),
                const Text("Detection 된 이미지"),
                Listener(
                  onPointerDown: (_) => setState(() {
                    _pointersCount++;
                  }),
                  onPointerUp: (_) => setState(() {
                    _pointersCount--;
                  }),
                  child: Container(
                    color: Colors.amber,
                    child: InteractiveViewer(
                      maxScale: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          args.imageName,
                          width: width,
                          height: height / 3,
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Text("${args.fileName} / ${args.fileNumber} / ${args.date}"),
              ],
            ),
          ),
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
