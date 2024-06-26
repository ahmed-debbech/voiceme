import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  late String duration;
  late String date;
  late String status;
  late bool sentByMe;

  Message({required this.duration, required this.sentByMe, required this.date, required this.status});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(duration),
                ),
                Row(
                    children: [
                      Text(date),
                      SizedBox(width: 10,),
                      Text(status)
                    ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
