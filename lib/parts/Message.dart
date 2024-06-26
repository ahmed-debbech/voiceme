import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:voiceme/backend/MessageBackend.dart';

class Message extends StatefulWidget {
  final String duration;
  final String date;
  final String status;
  final bool sentByMe;

  Message({
    required this.duration,
    required this.sentByMe,
    required this.date,
    required this.status,
  });

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  MessageBackend mb = MessageBackend();

  Future<void> play() async{
    Uint8List l = await mb.getMessageContent("id");
    print(l);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        play();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: widget.sentByMe
                  ? const EdgeInsets.only(left: 16.0)
                  : const EdgeInsets.only(right: 16.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: widget.sentByMe
                    ? Color.fromARGB(255, 37, 153, 161)
                    : Color.fromARGB(255, 73, 71, 74),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(widget.duration),
                  ),
                  Row(
                    children: [
                      Text(widget.date),
                      SizedBox(width: 10),
                      Text(widget.status),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}