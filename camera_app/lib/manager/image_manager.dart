import 'package:camera/camera.dart';
import 'package:camera_app/constants/color_constant.dart';
import 'package:camera_app/setting/show_loading_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageManager {
  // 전달받은 이미지 파일 편집
  static Future<CroppedFile?> cropImage(XFile file) async {
    // 전달받은 이미지 파일을 자르는 화면을 띄움.
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 800, ratioY: 128),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '사진 자르기',
          toolbarColor: mainColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile;
  }

  // 자른 이미지를 파일로 변환함.
  static Future<Uint8List> readAsBytesFromCroppedFile(
      CroppedFile croppedFile, BuildContext context) async {
    showLoadingBar(context);
    final file = await croppedFile.readAsBytes();
    Navigator.pop(context);
    return file;
  }
}
