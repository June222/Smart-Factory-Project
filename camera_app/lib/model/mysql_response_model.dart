// MYSQL API Response DTO(Data Transfer Object)
class MysqlResponseModel {
  final int code;
  final String msg;
  final Map<String, dynamic> data;

  MysqlResponseModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  // 전달받은 Map(json) 형태의 데이터를 클래스로 변환
  // (**주의: JSON 데이터를 jsonDecode()로 변환한 뒤 이 메소드를 실행해야함.)
  static MysqlResponseModel fromJson(Map<String, dynamic> jsonData) {
    return MysqlResponseModel(
      code: jsonData["code"],
      msg: jsonData["msg"],
      data: jsonData["data"],
    );
  }
}
