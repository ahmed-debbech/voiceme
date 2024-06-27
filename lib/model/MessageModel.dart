class MessageModel {
  late String id;
  late int duration;
  late String date;
  late String status;
  late bool isByMe;

  MessageModel(
      {required this.id,
      required this.duration,
      required this.date,
      required this.status,
      required this.isByMe});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json["id"],
        duration: json["duration"],
        date: json["date"],
        status: json["status"],
        isByMe: json["isByMe"]);
  }
}
