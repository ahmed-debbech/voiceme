import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:js' as js;
import 'dart:js_util' as js_util;

import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;
import 'package:voiceme/logic/recording_mobile.dart';
import 'package:voiceme/logic/recording_web.dart';

class VoiceComposer extends StatefulWidget {
  const VoiceComposer({super.key});

  @override
  State<VoiceComposer> createState() => _VoiceComposerState();
}

class _VoiceComposerState extends State<VoiceComposer> {
  //final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  late AudioRecorder record;
  late js.JsObject audioRecorder;

  @override
  void initState() {
    //record = AudioRecorder();
    audioRecorder = js.JsObject(js.context['AudioRecorder']);

    super.initState();
  }

  @override
  void dispose() {
    //record.dispose();
    super.dispose();
  }

  void stopRecording() async {
    try {
      var blob = await audioRecorder.callMethod('stop') as js.JsObject;
      var data = await blob.callMethod('arrayBuffer') as Uint8List;
      // Handle the recorded audio data here
      print('Recorded audio length: ${data.length} bytes');
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _startRec() async {
    if (kIsWeb) {
      //webRecStart(record);
      audioRecorder.callMethod('start');
    } else if (Platform.isAndroid) {
      mobileRecStart(record);
    }
  }

  Future<void> _stopRec() async {
    if (kIsWeb) {
      //webRecStop(record);
      stopRecording();
    } else if (Platform.isAndroid) {
      mobileRecStop(record);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text('Record a voice message ->'),
          ),
        ),
        Spacer(),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  _stopRec();
                },
                child: Icon(Icons.stop)),
          ),
        ),
        Spacer(),
        Container(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  _startRec();
                },
                child: Icon(Icons.voice_chat))),
      ],
    );
  }
}
