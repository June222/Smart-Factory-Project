import 'dart:developer';

import 'package:camera_app/constants/res.dart';

// Flask API DTO(Data Transfer Object)
class DetectionImageModel {
  final String imageURL;
  final List<dynamic> label;

  DetectionImageModel({required this.imageURL, required this.label});

  // 전달받은 Map(json) 형태의 데이터를 클래스로 변환 (**주의: JSON 데이터는 jsonDecode()로 변환한 뒤 이 메소드를 실행해야함.)
  static DetectionImageModel fromJson(Map<String, dynamic> jsonData) {
    final result = DetectionImageModel(
      imageURL: jsonData["image_url"],
      label: jsonData["label"],
    );
    log("url parsing ${Res.succesMessage}");
    return result;
  }

  // 클래스를 Map(json) 형태의 데이터로 변환 (**주의: 이 return 값을 jsonEncode(arg)의 arg로 넣어야 JSON 데이터)
  static Map<String, dynamic> toJson(DetectionImageModel model) => {
        "image_url": model.imageURL,
      };
}
