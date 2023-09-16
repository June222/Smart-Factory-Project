import 'package:flutter/material.dart';

class RealTimePage extends StatefulWidget {
  const RealTimePage({super.key});

  static const routeName = '/homepage/realtime';

  @override
  State<RealTimePage> createState() => _RealTimePageState();
}

class _RealTimePageState extends State<RealTimePage> {
  // late final TextEditingController _controller;
  late FocusNode _focusNode;
  String text = "";

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController();
    // _controller.addListener(() {});
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("실시간 확인"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                // controller: _controller,
                focusNode: _focusNode,
                onTapOutside: (event) => _focusNode.unfocus(),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 20),
              DataTable(
                headingRowHeight: height / 10,
                dataRowHeight: height / 12,
                columns: const [
                  DataColumn(
                    label: Text("파일 이름"),
                  ),
                  DataColumn(
                    label: Text("파일 번호"),
                  ),
                  DataColumn(
                    label: Text("날짜"),
                  ),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(
                        Text("가나다라"),
                      ),
                      DataCell(
                        Text("00001번"),
                      ),
                      DataCell(
                        Text("2023-09-14"),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("가나다라"),
                      ),
                      DataCell(
                        Text("00001번"),
                      ),
                      DataCell(
                        Text("2023-09-14"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
