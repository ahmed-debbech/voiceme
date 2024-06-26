class MessageModel{
  late String duration;
  late String date;
  late String status;
  late bool isByMe;

  MessageModel({required this.duration,required this.date,required this.status, required this.isByMe});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(duration: json["duration"], date: json["date"], status: json["status"], isByMe: json["isByMe"]);
  }
}