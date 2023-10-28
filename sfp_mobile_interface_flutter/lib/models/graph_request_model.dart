// mysql로 보낼 데이터 클래스 모델(DTO)
class GraphRequestModel {
  final String dateStart;
  final String dateEnd;

  GraphRequestModel({
    required this.dateStart,
    required this.dateEnd,
  });

  // DatePicker에서 설정한 값으로 클래스 생성
  static GraphRequestModel fromDateTime(DateTime t1, DateTime t2) {
    return GraphRequestModel(dateStart: t1.toString(), dateEnd: t2.toString());
  }

  // json에 전달할 형태로 변환
  // [주의]
  // 전달할 때는 jsonEncode(model.toJson())로 전달하여야함.
  Map<String, dynamic> toJson() => {
        "localDateTimeStart": dateStart,
        "localDateTimeEnd": dateEnd,
      };
}
