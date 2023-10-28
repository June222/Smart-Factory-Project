class DashBoardImageModel {
  final String fileName;
  final String originImgURL;
  final String detectedImgURL;
  final List<dynamic> labelList;
  final String date;
  final String second;

  DashBoardImageModel({
    required this.fileName,
    required this.originImgURL,
    required this.detectedImgURL,
    required this.labelList,
    required this.date,
    required this.second,
  });

  static DashBoardImageModel fromJson(Map<String, dynamic> jsonData) =>
      DashBoardImageModel(
        fileName: jsonData["fileName"],
        originImgURL: jsonData["originImgUrl"],
        detectedImgURL: jsonData["detectedImgUrl"],
        labelList: jsonData["labelList"],
        date: jsonData["date"],
        second: jsonData["second"],
      );
}
// {
//             "fileName": "123",
//             "originImgUrl": "originURL",
//             "detectedImgUrl": "detectedImgURL",
//             "labelList": [
//                 2
//             ],
//             "date": "2023-10-24",
//             "second": "22:59:47"
//         }