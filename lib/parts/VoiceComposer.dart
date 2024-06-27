import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;
import 'package:voiceme/backend/MessageBackend.dart';
import 'package:voiceme/logic/recording_mobile.dart';
import 'package:voiceme/logic/recording_web.dart';
import 'package:voiceme/globals.dart' as globals;

class VoiceComposer extends StatefulWidget {
  const VoiceComposer({super.key});

  @override
  State<VoiceComposer> createState() => _VoiceComposerState();
}

class _VoiceComposerState extends State<VoiceComposer> {
  //final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  late AudioRecorder record;
  //late js.JsObject audioRecorder;
  int _counter = globals.numOfSecOfRec;
  late Timer _timer;
  MessageBackend mb = MessageBackend();
  bool isRecording = false;

  @override
  void initState() {
    record = AudioRecorder();
    //audioRecorder = js.JsObject(js.context['AudioRecorder']);
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_counter == 0) {
        resetTimer();
        _stopRec();
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() => _counter = globals.numOfSecOfRec);
  }

  @override
  void dispose() {
    record.dispose();
    _timer.cancel();
    super.dispose();
  }

  /*void stopRecording() async {
    try {
      var blob = await audioRecorder.callMethod('stop') as js.JsObject;
      var data = await blob.callMethod('arrayBuffer') as Uint8List;
      // Handle the recorded audio data here
      print('Recorded audio length: ${data.length} bytes');
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }*/

  Future<void> _startRec() async {
    setState(() => isRecording = true);
    if (kIsWeb) {
      //webRecStart(record);
      //audioRecorder.callMethod('start');
    } else if (Platform.isAndroid) {
      await mobileRecStart(record);
    }
    startTimer();
  }

  Future<String> _stopRec() async {
    setState(() => isRecording = false);
    resetTimer();
    if (kIsWeb) {
      //webRecStop(record);
      //stopRecording();
    } else if (Platform.isAndroid) {
      String base = await mobileRecStop(record);
      return base;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
              alignment: Alignment.center,
              child: (!isRecording)
                  ? Text('Record a voice message ->')
                  : Text(_counter.toString())),
        ),
        /*Spacer(),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  _stopRec();
                },
                child: Icon(Icons.stop)),
          ),
        ),*/
        Spacer(),
        Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  if (!isRecording)
                    _startRec();
                  else
                    _stopRec().then((value) => {
                          if (value != "")
                            {
                              mb.addNew(value).then((value) => {
                                    //addd message to list with status
                                  })
                            }
                        });
                },
                child: (!isRecording)
                    ? Icon(Icons.voice_chat)
                    : Icon(Icons.stop_rounded))),
      ],
    );
  }
}
