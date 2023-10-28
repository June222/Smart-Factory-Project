// Mysql 서버에서 데이터를 받는 모델 클래스 (DTO)
class GraphResponseModel {
  final int code;
  final String msg;
  final dynamic data;

  GraphResponseModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  // json(Map)형태에서 바로 생성하는 static method.
  static GraphResponseModel fromJson(Map<String, dynamic> jsonData) =>
      GraphResponseModel(
          code: jsonData["code"], msg: jsonData['msg'], data: jsonData['data']);
}
