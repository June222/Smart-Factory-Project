// MYSQL API Request DTO(Data Transfer Object)
class MysqlRequestModel {
  final String fileName;
  final List<dynamic> defectLabelList;
  final String originImgURL;
  final String detectedImgURL;

  MysqlRequestModel({
    required this.fileName,
    required this.defectLabelList,
    required this.originImgURL,
    required this.detectedImgURL,
  });

  // 클래스를 Map(json) 형태의 데이터로 변환 (**주의: 이 return 값을 jsonEncode(arg)의 arg로 넣어야 JSON 데이터)
  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "defectLabelList": defectLabelList,
        "originImgUrl": originImgURL,
        "detectedImgUrl": detectedImgURL,
      };
}
