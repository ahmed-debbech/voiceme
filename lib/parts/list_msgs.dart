import 'package:flutter/material.dart';

class ListMessages extends StatefulWidget {
  const ListMessages({super.key});
  @override
  State<StatefulWidget> createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  final List<Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    _messages.add(Message(text: "voice message...", sentByMe: true));

    _messages.add(Message(text: "voice message...", sentByMe: false));

    _messages.add(Message(text: "voice message...", sentByMe: true));

    _messages.add(Message(text: "voice message...", sentByMe: false));
    _messages.add(Message(text: "voice message...", sentByMe: true));

    _messages.add(Message(text: "voice message...", sentByMe: false));
    _messages.add(Message(text: "voice message...", sentByMe: true));

    _messages.add(Message(text: "voice message...", sentByMe: false));
    _messages.add(Message(text: "voice message...", sentByMe: true));

    _messages.add(Message(text: "voice message...", sentByMe: false));
    _messages.add(Message(text: "voice message...", sentByMe: true));

    _messages.add(Message(text: "voice message...", sentByMe: false));
    _messages.add(Message(text: "voice message...", sentByMe: true));
    _messages.add(Message(text: "voice message...", sentByMe: false));
    _messages.add(Message(text: "voice message...", sentByMe: false));

    _messages.add(Message(text: "voice message...", sentByMe: false));

    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => _messages[index],
        itemCount: _messages.length,
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String text;
  final bool sentByMe;

  Message({required this.text, required this.sentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: sentByMe
                ? const EdgeInsets.only(left: 16.0)
                : const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: sentByMe
                  ? Color.fromARGB(255, 17, 134, 142)
                  : Color.fromARGB(255, 73, 71, 74),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment:
                  sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
