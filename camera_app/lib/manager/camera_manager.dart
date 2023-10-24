import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:camera_app/constants/res.dart';

class CameraManager {
  late final List<CameraDescription> cameras;

  CameraManager();

  // 카메라 실행 준비
  Future<void> initializeCameras() async {
    try {
      // 접근 가능한 카메라들을 List 형태로 반환
      cameras = await availableCameras();
    } catch (e) {
      log(e.toString());
    }
    log(Res.succesMessage);
  }

  // dart 언어의 Getter
  // 가능한 카메라 중 첫번째로 등록된 카메라 반환 (휴대폰의 경우 전면 카메라)
  CameraDescription get firstCamera => cameras.first;
}
