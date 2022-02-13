import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final fileUri =
    "https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.aac";

class AudioPlay {
  FlutterSoundPlayer? _flutterSoundPlayer;

  bool get isaudioplay => _flutterSoundPlayer!.isPlaying;

  Future<void> playaudio(VoidCallback whenfinish) async {
    String path =
        join((await getTemporaryDirectory()).path, 'audio_example.aac');
    await _flutterSoundPlayer!.startPlayer(
      fromURI: path,
      whenFinished: whenfinish,
      codec: Codec.aacADTS,
    );
  }

  Future stopaudio() async {
    await _flutterSoundPlayer!.stopPlayer();
  }

  Future toogleaudioplayer({required VoidCallback whenfinish}) async {
    if (_flutterSoundPlayer!.isStopped) {
      await playaudio(whenfinish);
    } else {
      await stopaudio();
    }
  }

  Future playaudioinit() async {
    _flutterSoundPlayer = FlutterSoundPlayer();
    await _flutterSoundPlayer!.openAudioSession();
  }

  Future audiodispose() async {
    _flutterSoundPlayer!.closeAudioSession();
    _flutterSoundPlayer = null;
  }
}
