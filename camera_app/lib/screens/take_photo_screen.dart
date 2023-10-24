// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app/constants/res.dart';
import 'package:camera_app/constants/storage_constants.dart';
import 'package:camera_app/main.dart';
import 'package:camera_app/manager/image_manager.dart';
import 'package:camera_app/model/detection_image_model.dart';
import 'package:camera_app/model/mysql_request_model.dart';
import 'package:camera_app/model/mysql_response_model.dart';
import 'package:camera_app/resources/firestore_method.dart';
import 'package:camera_app/resources/http_method.dart';
import 'package:camera_app/setting/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen({super.key, required this.photoGrapherName});

  final String photoGrapherName;

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late final CameraController _cameraController;
  // 촬영한 이미지를 저장할 변수
  XFile? _takenFile;

  // 편집된 이미지를 저장할 변수
  CroppedFile? _croppedFile;

  // 오전송을 막기 위한 flag
  bool _doImageExist = false;

  // 전송 시작
  Future<void> transmitionStart(
      CroppedFile croppedFile, BuildContext context) async {
    // 카메라 미리보기 중지
    await _cameraController.pausePreview();

    final file =
        await ImageManager.readAsBytesFromCroppedFile(croppedFile, context);

    final String originImageURL = await FirestoreMethod().getImageURL(
      context,
      StaticData.originImageFolder,
      widget.photoGrapherName,
      file,
    );

    // request DTO 생성
    DetectionImageModel detectionReqModel = DetectionImageModel(
      imageURL: Uri.parse(originImageURL).toString(),
      label: [],
    );

    // response DTO 생성
    DetectionImageModel? detectionResModel =
        await HttpMethod().transferToFlaskAPI(detectionReqModel, context);

    // response가 된 경우
    if (detectionResModel != null) {
      // mysql Request DTO 생성
      MysqlRequestModel mysqlRequestModel = MysqlRequestModel(
          fileName: widget.photoGrapherName,
          defectLabelList: detectionResModel.label,
          originImgURL: detectionReqModel.imageURL,
          detectedImgURL: detectionResModel.imageURL);

      // mysql response DTO 생성
      MysqlResponseModel? mysqlResponseModel =
          await HttpMethod().transferToMysqlServer(mysqlRequestModel, context);

      if (mysqlResponseModel != null) {
        // 정상적으로 처리시에 화면 이탈.
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    // 카메라 컨트롤러 생성
    _cameraController = CameraController(
      cameraManager.firstCamera, // 전면 카메라
      ResolutionPreset.ultraHigh, // 고화질
      imageFormatGroup: ImageFormatGroup.jpeg, // jpeg로 저장
    );

    // 카메라 컨트롤러 시작
    _cameraController.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    }).catchError((Object e) {
      log(e.toString());
    }); // 카메라 준비

    // 화면 가로로 고정
    _cameraController
        .lockCaptureOrientation(DeviceOrientation.landscapeRight)
        .then((_) {
      log("landscape${Res.succesMessage}");
    });

    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("page: 2");
    // 현재 사용중인 디바이스의 화면 크기 저장
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    _doImageExist = (_takenFile != null);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (_doImageExist)
              Column(
                children: [
                  const Text("촬영 이미지"),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: 0.2 * height, maxWidth: width),
                    child: Image.file(
                      File(
                        // 편집이 안된 경우 편집 전 이미지 렌더링
                        // 편집이 된 경우 편집 후 이미지 렌더링
                        _croppedFile == null
                            ? _takenFile!.path
                            : _croppedFile!.path,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 50),
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: 0.5 * height, maxWidth: width),
              // 카메라에 찍히는 화면 렌더링
              child: CameraPreview(_cameraController),
            ), // CameraPreview
            Text(
              "촬영자 이름: ${widget.photoGrapherName}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _takenFile = await _cameraController.takePicture();
                    if (_takenFile != null) {
                      _croppedFile = await ImageManager.cropImage(_takenFile!);
                    }
                    setState(() {});
                  },
                  child: Text(
                    _doImageExist ? "재촬영" : "촬영",
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_doImageExist) {
                        _croppedFile =
                            await ImageManager.cropImage(_takenFile!);
                      } else {
                        showSnackBar("촬영을 먼저 해주세요.", context);
                      }
                      setState(() {});
                    },
                    child: const Text("편집하기")),
                ElevatedButton(
                    onPressed: () async {
                      if (_croppedFile == null) {
                        showSnackBar("편집된 이미지가 없습니다.", context);
                      } else {
                        transmitionStart(_croppedFile!, context);
                      }
                    },
                    child: const Text("전송"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
