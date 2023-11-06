// mysql로 보낼 데이터 클래스 모델(DTO)
class GraphRequestModel {
  final String dateStart;
  final String dateEnd;

  GraphRequestModel({
    required this.dateStart,
    required this.dateEnd,
  });

  // DatePicker에서 설정한 값으로 클래스 생성
  static GraphRequestModel fromDateTime(
      DateTime dateTimeStart, DateTime dateTimeEnd) {
    var dts = "${dateTimeStart.toString().split(' ')[0]} 00:00:00";
    var dte = "${dateTimeEnd.toString().split(' ')[0]} 23:59:59";
    return GraphRequestModel(dateStart: dts, dateEnd: dte);
  }

  // json에 전달할 형태로 변환
  // [주의]
  // 전달할 때는 jsonEncode(model.toJson())로 전달하여야함.
  Map<String, dynamic> toJson() => {
        "localDateTimeStart": dateStart,
        "localDateTimeEnd": dateEnd,
      };
}
