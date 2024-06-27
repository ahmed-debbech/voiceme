import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class Player {
  static final Player _singleton = Player._internal();
  AudioPlayer? player = null;

  factory Player() {
    return _singleton;
  }

  Player._internal();

  Future<String> writeToFile(Uint8List data) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/temp_audio.mp3');
    await file.writeAsBytes(data);
    return file.path;
  }

  Future<void> play(Uint8List data) async {
    if (player != null) return;
    player = AudioPlayer();
    String path = await writeToFile(data);
    await player?.setAudioSource(AudioSource.uri(Uri.file(path)));
    //await player.setAsset('assets/audio/download.mp3');
    player?.play().then((value) => {player?.dispose(), player = null});
  }

  Future<void> stop() async {
    if (player == null) return;

    player?.stop().then((value) => {player?.dispose(), player = null});
  }
}
