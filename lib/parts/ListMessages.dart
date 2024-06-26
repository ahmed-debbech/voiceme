import 'dart:async';

import 'package:flutter/material.dart';
import 'package:voiceme/backend/MessageBackend.dart';
import 'package:voiceme/parts/Message.dart';
import 'package:voiceme/model/MessageModel.dart';

class ListMessages extends StatefulWidget {

  List<MessageModel> messages = [];

  ListMessages({super.key});
  @override
  State<StatefulWidget> createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {

  MessageBackend messageBackend = MessageBackend();
  List<Message> ui = [];
  late Timer _timer;
  
  @override
  void initState(){
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) { loadNewMessages(); });
  }
  @override
  void dispose(){
    _timer.cancel(); 
  }
  Future<void> loadNewMessages()async {
    List<MessageModel> list = await messageBackend.getOfToday();
    setState(() => {ui.clear()});
    for (MessageModel mm in list){
      setState(() => {ui.add(Message(sentByMe: mm.isByMe, duration: mm.duration, date: mm.date, status: mm.status,))});    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => ui[index],
        itemCount: ui.length,
      ),
    );
  }
}

