import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final pathtosaveautio = 'audio_example.aac';

class Soundrecord {
  FlutterSoundRecorder? _soundRecorder;

  String? path = '';

  bool isrecordiniti = false;

  bool get isRecoding => _soundRecorder!.isRecording;

  Future init() async {
    _soundRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission');
    }

    await _soundRecorder!.openAudioSession();
    isrecordiniti = true;
  }

  void dispose() {
    if (!isrecordiniti) return;
    _soundRecorder!.closeAudioSession();
    _soundRecorder = null;
    isrecordiniti = false;
  }

  Future record() async {
    if (!isrecordiniti) return;
    await _soundRecorder!.startRecorder(toFile: pathtosaveautio);
  }

  Future stop() async {
    if (!isrecordiniti) return;
    await _soundRecorder!.stopRecorder();
  }

  Future tooglerecording() async {
    if (_soundRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }

  //audio play

}
