import 'dart:convert';
import 'dart:typed_data';

import 'package:record/record.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

Future<void> webRecStart(AudioRecorder record) async {
  // Check and request permission if needed
  if (await record.hasPermission()) {
    // Start recording to file
    try {
      await record.start(const RecordConfig(encoder: AudioEncoder.opus),
          path: '/home/swared/myFile.m4a');
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<void> webRecStop(AudioRecorder record) async {
  try {
    final path = await record.stop();
    print(path);
    final uri = Uri.file(path!.substring(5));
    final response = await html.HttpRequest.request(uri.toString(),
        responseType: 'arraybuffer');
    final contents = response.response as ByteBuffer;

    String base = base64Encode(contents.asUint8List());
    print(base);
    final res = await http.post(
      Uri.parse("http://localhost:3000/string"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'string': base,
      }),
    );
  } catch (e) {
    print(e.toString());
  }
}
