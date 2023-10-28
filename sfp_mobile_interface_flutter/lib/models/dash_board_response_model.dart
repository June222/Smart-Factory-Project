class DashBoardResponseModel {
  final int code;
  final String msg;
  final List<dynamic> data;

  DashBoardResponseModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  @override
  String toString() {
    return "code: $code, msg: $msg, data: ${data.toString()}";
  }

  static DashBoardResponseModel fromJson(Map<String, dynamic> jsonData) =>
      DashBoardResponseModel(
        code: jsonData["code"],
        msg: jsonData["msg"],
        data: jsonData["data"],
      );
}
