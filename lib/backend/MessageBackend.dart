import 'package:voiceme/model/MessageModel.dart';

class MessageBackend{
  Future<List<MessageModel>> getOfToday() async{
    //get date of today
    //get messages from db
    List<MessageModel> list  = [];
    list.add(MessageModel(duration: "15/45", isByMe: true, date: "11:10 - 26 juin", status: "sent"));
    list.add(MessageModel(duration: "15/45", isByMe: false, date: "11:10 - 26 juin", status: "sent"));
    list.add(MessageModel(duration: "15/45", isByMe: true, date: "11:10 - 26 juin", status: "sent"));
    list.add(MessageModel(duration: "15/45", isByMe: false, date: "11:10 - 26 juin", status: "sent"));
    list.add(MessageModel(duration: "15/45", isByMe: true, date: "11:10 - 26 juin", status: "sent"));
    list.add(MessageModel(duration: "15/22", isByMe: true, date: "11:10 - 26 juin", status: "sent"));
    list.add(MessageModel(duration: "15/45", isByMe: false, date: "11:10 - 26 juin", status: "sent"));
    list.add(MessageModel(duration: "15/45", isByMe: true, date: "11:10 - 26 juin", status: "sent"));


    return list;
  }
}