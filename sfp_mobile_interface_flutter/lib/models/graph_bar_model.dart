class GraphBarModel {
  final String date;
  final int class_one_num;
  final int class_two_num;
  final int class_three_num;
  final int class_four_num;

  GraphBarModel(this.class_one_num, this.class_two_num, this.class_three_num,
      this.class_four_num, this.date);

  static GraphBarModel fromJson(Map<String, dynamic> jsonData) => GraphBarModel(
      jsonData["num_class_one"],
      jsonData["num_class_two"],
      jsonData["num_class_three"],
      jsonData["num_class_four"],
      jsonData["date"]);
}
