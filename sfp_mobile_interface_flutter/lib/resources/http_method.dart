import 'dart:convert';
import 'dart:developer';

import 'package:sfp_mobile_interface_flutter/constants/classified.dart';
import 'package:http/http.dart' as http;
import 'package:sfp_mobile_interface_flutter/models/dash_board_image_model.dart';
import 'package:sfp_mobile_interface_flutter/models/dash_board_request_model.dart';
import 'package:sfp_mobile_interface_flutter/models/dash_board_response_model.dart';

class HttpMethod {
  static Future<List<DashBoardImageModel>> getDataList(
      DashBoardRequestModel model) async {
    List<dynamic> dataList = [];
    List<DashBoardImageModel> modelList = [];

    final headers = {"Content-Type": "application/json"};
    Uri uri = Uri.parse("http://$mysqlServerIPPort$specificURL");
    try {
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(model.toJson()),
      );
      log(response.body);
      if (response.statusCode == 202) {
        // log("success");
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final DashBoardResponseModel dashBoardResponseModel =
            DashBoardResponseModel.fromJson(jsonResponse);

        log(dashBoardResponseModel.data.toString());
        dataList = dashBoardResponseModel.data;
        for (var data in dataList) {
          modelList.add(DashBoardImageModel.fromJson(data));
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log("error");
      log(e.toString());
    }
    return modelList;
  }
  // // Flask API를 호출
  // Future<DetectionImageModel?> transferToFlaskAPI(
  //     final DetectionImageModel steelImageModel, BuildContext context) async {
  //   // return 받을 변수 선언
  //   DetectionImageModel? model;
  //   showLoadingBar(context);

  //   // http 통신 결과
  //   var response = await http.post(
  //     StaticData.flaskApiURL,
  //     headers: StaticData.headers,
  //     body: jsonEncode(DetectionImageModel.toJson(steelImageModel)),
  //   );

  //   log("response comes");
  //   Navigator.pop(context);

  //   // 통신이 정상적인 경우
  //   if (response.statusCode == 200) {
  //     // JSON 데이터를 managable 하게 변환
  //     var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  //     model = DetectionImageModel.fromJson(jsonResponse);
  //     log(response.body);

  //     // 통신이 된 경우 결과 이미지를 띄움.
  //     await showDialog(
  //         context: context,
  //         builder: (context) {
  //           return Dialog(
  //             child: Image.network(
  //               model!.imageURL,
  //               loadingBuilder: (context, child, loadingProgress) {
  //                 // loading이 완료될 경우 원래 설정한 이미지를 렌더링
  //                 if (loadingProgress == null) {
  //                   return child;
  //                 }
  //                 // 아니면 로딩화면 렌더링
  //                 return const Center(
  //                   child: CircularProgressIndicator(color: mainColor),
  //                 );
  //               },
  //               errorBuilder: (context, error, stackTrace) =>
  //                   Text(error.toString()),
  //             ),
  //           );
  //         });
  //   } else {
  //     showSnackBar("${response.statusCode}", context);
  //     log("Response Error: ${response.statusCode}\n${response.body.toString()} ");
  //   }
  //   log("transfer Flask API() done.");

  //   return model;
  // }

  // // mysql(을 관리하고 있는 JPA)로 데이터 전송
  // Future<MysqlResponseModel?> transferToMysqlServer(
  //   final MysqlRequestModel requestModel,
  //   BuildContext context,
  // ) async {
  //   log("init transfer to MysqlServer");
  //   log(requestModel.toString());

  //   // return 받을 변수 선언
  //   MysqlResponseModel? responseModel;

  //   showLoadingBar(context);
  //   try {
  //     // http 통신 결과
  //     var response = await http.post(
  //       StaticData.mysqlServerURL,
  //       headers: StaticData.headers,
  //       body: jsonEncode(requestModel.toJson()),
  //     );

  //     log(response.body);

  //     // 통신이 정상적인 경우
  //     if (response.statusCode == 201) {
  //       // JSON 데이터를 managable 하게 변환
  //       var jsonReponse = jsonDecode(response.body) as Map<String, dynamic>;
  //       responseModel = MysqlResponseModel.fromJson(jsonReponse);

  //       log(responseModel.toString());

  //       // 전송이 된 경우 알림 띄움.
  //       await showTextDialog("mysql 서버에 등록을 완료했습니다.", context);
  //     } else {
  //       showSnackBar("${response.statusCode}", context);
  //       log("Response Error: ${response.statusCode}\n${response.body.toString()} ");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   // loading bar 제거
  //   Navigator.pop(context);

  //   return responseModel;
  // }
}
