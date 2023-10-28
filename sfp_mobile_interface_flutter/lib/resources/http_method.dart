// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/constants/classified.dart';
import 'package:http/http.dart' as http;
import 'package:sfp_mobile_interface_flutter/models/dash_board_image_model.dart';
import 'package:sfp_mobile_interface_flutter/models/dash_board_request_model.dart';
import 'package:sfp_mobile_interface_flutter/models/dash_board_response_model.dart';
import 'package:sfp_mobile_interface_flutter/models/graph_bar_model.dart';
import 'package:sfp_mobile_interface_flutter/models/graph_request_model.dart';
import 'package:sfp_mobile_interface_flutter/models/graph_response_model.dart';
import 'package:sfp_mobile_interface_flutter/setting/show_loading_bar.dart';

class HttpMethod {
  // http통신의 MIME 타입을 json형태로 설정
  static const headers = {"Content-Type": "application/json"};

  static Future<List<DashBoardImageModel>> getDashBoardDataList(
      DashBoardRequestModel model, BuildContext context) async {
    // loading 화면
    showLoadingBar(context);

    // jsonData List
    List<dynamic> dataList = [];
    // flutter에서 사용할 클래스 List
    List<DashBoardImageModel> modelList = [];

    Uri uri = Uri.parse("http://$mysqlServerIPPort$urlGetDashboard");
    try {
      // http 통신
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(model.toJson()),
      );
      log(response.body);

      // 통신이 정상적으로 된 경우
      if (response.statusCode == 202) {
        // json 데이터를 flutter에서 사용할 수 있게 변환
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        // 클래스로 변환
        final DashBoardResponseModel dashBoardResponseModel =
            DashBoardResponseModel.fromJson(jsonResponse);

        log(dashBoardResponseModel.data.toString());

        // data에 담겨있는 list
        dataList = dashBoardResponseModel.data;

        // list의 data들을 클래스로 변환
        for (var data in dataList) {
          // modelList에 추가
          modelList.add(DashBoardImageModel.fromJson(data));
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log("error");
      log(e.toString());
    }
    Navigator.pop(context);
    return modelList;
  }

  static Future<List<GraphBarModel>> getGraphDataList(
      GraphRequestModel model, BuildContext context) async {
    showLoadingBar(context);

    // jsonData List
    List<dynamic> dataList = [];
    // flutter에서 사용할 클래스 List
    List<GraphBarModel> modelList = [];

    Uri uri = Uri.parse("http://$mysqlServerIPPort$urlGetGraph");

    try {
      // http 통신
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      log(response.body);

      // 통신이 정상적으로 된 경우
      if (response.statusCode == 202) {
        // json 데이터를 flutter에서 사용할 수 있게 변환
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        // 클래스로 변환
        final GraphResponseModel graphResponseModel =
            GraphResponseModel.fromJson(jsonResponse);

        log(graphResponseModel.data.toString());

        // data에 담겨있는 list
        dataList = graphResponseModel.data;

        // list의 data들을 클래스로 변환
        for (var data in dataList) {
          // modelList에 추가
          modelList.add(GraphBarModel.fromJson(data));
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log("error");
      log(e.toString());
    }
    Navigator.pop(context);
    return modelList;
  }
}
