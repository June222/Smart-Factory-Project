import 'package:camera_app/my_app.dart';
import 'package:camera_app/manager/camera_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

late final CameraManager cameraManager;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 기기 초기화 - 카메라용

  cameraManager = CameraManager(); // 모든 스크린에서 내장 카메라 접근을 위한 전역변수
  await cameraManager.initializeCameras();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // firestore 실행용
  runApp(const MyApp());
}
