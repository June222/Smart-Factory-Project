import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childname, String fileName, Uint8List file) async {
    // /childname/filename 으로 위치 설정
    Reference ref = _storage.ref().child(childname).child(fileName);

    // 위에서 정한 위치에 이미지 파일 업로드 Task 준비
    UploadTask uploadTask = ref.putData(file);

    // 업로드
    TaskSnapshot snap = await uploadTask;

    // 다운로드 가능한 URL 반환
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
