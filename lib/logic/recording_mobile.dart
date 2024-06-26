import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:path_provider/path_provider.dart';

import 'package:record/record.dart';

Future<void> mobileRecStart(AudioRecorder record) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  // Check and request permission if needed
  if (await record.hasPermission()) {
    // Start recording to file
    try {
      await record.start(const RecordConfig(encoder: AudioEncoder.opus),
          path: '${appDocPath}/myFile.m4a');
    } catch (e) {
      print("could not record");
    }
  }
}

Future<void> mobileRecStop(AudioRecorder record) async {
  print("stoping");
  try {
    final path = await record.stop();
    print(path);
    File f = File(path!);
    final contents = f.readAsBytesSync();
    String base = base64Encode(contents);
    final response = await http.post(
      Uri.parse("http://localhost:3000/string"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'string': base,
      }),
    );
  } catch (e) {
    print("eeee");
  }
}
