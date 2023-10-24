import 'dart:developer';

import 'package:camera_app/screens/take_photo_screen.dart';
import 'package:camera_app/setting/show_text_dialog.dart';
import 'package:flutter/material.dart';

class InputNameScreen extends StatefulWidget {
  const InputNameScreen({super.key});

  @override
  State<InputNameScreen> createState() => _InputNameScreenState();
}

class _InputNameScreenState extends State<InputNameScreen> {
  late final TextEditingController _textEditingController; // TextForm 제어
  late FocusNode _focusNode; // TextForm 입력 상태를 제어함.

  String _text = "";

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      // TextForm의 값이 달라질 때마다 변경
      setState(() {
        _text = _textEditingController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Resource를 아끼기 위해 화면에서 벗어날 때 생성한 인스터스를 없앰.
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  // 화면 이동
  void moveToDisplayScreen(String path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(
          photoGrapherName: _text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log("page: 1");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("SMART FACTORY"),
            TextField(
              controller: _textEditingController,
              focusNode: _focusNode,
              autofocus: true,
              // 다른 곳을 누르면 입력 상태 종료 (키보드 내림)
              onTapOutside: (event) => _focusNode.unfocus(),
            ),
            // 사용자 이름을 입력하고 화면 이동
            ElevatedButton(
              onPressed: () async {
                if (_text.isEmpty) {
                  showTextDialog("이름을 입력하지 않았습니다.", context);
                } else {
                  moveToDisplayScreen(_text);
                }
              },
              child: const Text("사용자 이름 입력"),
            ),
          ],
        ),
      ),
    );
  }
}
