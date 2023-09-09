import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_assignment/data/function_data/function_data.dart';
import 'package:graduation_assignment/data/string_data/string_data.dart';
import 'package:graduation_assignment/data/widget_data/widget_data.dart';
import 'package:image_picker/image_picker.dart';

import 'widget/class_bar_graph_widget.dart';
import 'widget/image_source_button_widget.dart';

class UsingServicePage extends StatefulWidget {
  const UsingServicePage({super.key});

  @override
  State<UsingServicePage> createState() => _UsingServicePageState();
}

class _UsingServicePageState extends State<UsingServicePage> {
  final unSortedClassMap = {
    "Class 1": 8,
    "Class 2": 32,
    "Class 3": 50,
    "Class 4": 10
  };
  final String firstDefectNumber = "3";
  final String secondDefectNumber = "2";
  final String thirdDefectNumber = "4";
  final String lastDefectNumber = "1";

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      log("Image picking failed: $e");
    }
    Navigator.pop(context);
  }

  Map<String, int> sortMapByKey(Map<String, int> unsortedMap) {
    List<MapEntry<String, int>> sortedEntries = unsortedMap.entries.toList()
      ..sort(((a, b) => b.value.compareTo(a.value)));
    print(sortedEntries);
    return Map.fromEntries(sortedEntries);
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageSourceButton(
              onPressed: () => _pickImage(ImageSource.camera),
              iconData: Icons.camera_alt_rounded,
              text: "카메라",
            ),
            ImageSourceButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              iconData: Icons.photo_library_rounded,
              text: "갤러리",
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final sortedMap = sortMapByKey(unSortedClassMap);
    print(sortedMap);

    return Scaffold(
      appBar: introductionAppBar("서비스 이용하기"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: introductionPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(ai_image),
                Text(
                  "예측하기",
                  style: headLineStyle,
                ),
                Text(
                  "웹 화면에서는 다량의 이미지를 업로드 할 수 있으며, 결과를 하나의 excel 파일로 다운 받을 수 있어요!",
                  style: boldStyle,
                ),
                const SizedBox(height: 10),
                if (_imageFile == null)
                  GestureDetector(
                    onTap: () {
                      log("철강사진 tap");
                      _showImageSourceDialog();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      width: width,
                      height: width / 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Spacer(flex: 2),
                          const Icon(
                            Icons.add_photo_alternate_rounded,
                            size: 75,
                          ),
                          const Spacer(),
                          Text(
                            "철강 사진을 업로드 하여\n불량을 검출해보세요!",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                if (_imageFile != null) ...{
                  Image.file(File(_imageFile!.path)),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${sortedMap.keys.first} 불량품으로 의심 됩니다!",
                          style: headLineStyle.copyWith(height: 1),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "업로드한 철강이미지에는 불량으로 의심이 되는 부분이 있습니다. ${sortedMap.keys}순으로 불량이 의심이 됩니다.",
                          style: boldStyle,
                        ),
                        const SizedBox(height: 20),
                        ClassBarGraphWidget(
                          unSortedClassMap: unSortedClassMap,
                          color: Colors.red,
                          classNumber: 1,
                        ),
                        ClassBarGraphWidget(
                          unSortedClassMap: unSortedClassMap,
                          color: Colors.orange,
                          classNumber: 2,
                        ),
                        ClassBarGraphWidget(
                          unSortedClassMap: unSortedClassMap,
                          color: Colors.green,
                          classNumber: 3,
                        ),
                        ClassBarGraphWidget(
                          unSortedClassMap: unSortedClassMap,
                          color: Colors.indigo,
                          classNumber: 4,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () => _showImageSourceDialog(),
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue)),
                            child: const Text("사진 다시 업로드"),
                          ),
                        )
                      ],
                    ),
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 웹으로보기 버튼
// TextButton(
                //   onPressed: () {
                //     log("message");
                //   },
                //   style: ButtonStyle(
                //     shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(8)))),
                //     side: MaterialStatePropertyAll(BorderSide(
                //         color: Theme.of(context).colorScheme.secondary)),
                //   ),
                //   child: const Text("웹으로 보기"),
                // ),

