import 'dart:developer';
import 'dart:typed_data';

import 'package:camera_app/constants/res.dart';
import 'package:camera_app/resources/storage_method.dart';
import 'package:camera_app/setting/show_loading_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FirestoreMethod {
  // 현재 로그인되어 있는 google ID로 접근.
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Firebase에 이미지를 저장하고 다운로드 가능한 URL을 return
  Future<String> getImageURL(BuildContext context, String childname,
      String fileName, Uint8List file) async {
    String photoUrl = "";
    showLoadingBar(context);
    try {
      photoUrl =
          await StorageMethod().uploadImageToStorage(childname, fileName, file);
      log("upload ${Res.succesMessage}");
    } catch (e) {
      log(e.toString());
    }
    // loding bar 제거
    Navigator.pop(context);
    return photoUrl;
  }
}
