class DashBoardRequestModel {
  final String dateTimeStart;
  final String dateTimeEnd;
  final String status;
  final String label;

  DashBoardRequestModel({
    required this.dateTimeStart,
    required this.dateTimeEnd,
    required this.status,
    required this.label,
  });

  @override
  String toString() {
    return "start: ${dateTimeStart.toString()}, end: ${dateTimeEnd.toString()}, status: $status, label: $label";
  }

  static DashBoardRequestModel makeReqModel({
    required DateTime dateTimeStart,
    required DateTime dateTimeEnd,
    required String status,
    required String defectLabel,
  }) {
    var dts = "${dateTimeStart.toString().split(' ')[0]} 00:00:00";
    var dte = "${dateTimeEnd.toString().split(' ')[0]} 23:59:59";
    var model = DashBoardRequestModel(
      dateTimeStart: dts,
      dateTimeEnd: dte,
      status: status,
      label: defectLabel,
    );
    return model;
  }

  Map<String, dynamic> toJson() => {
        "localDateTimeStart": dateTimeStart,
        "localDateTimeEnd": dateTimeEnd,
        "status": status,
        "label": label,
      };
}
