import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

part 'recorder_cubit.freezed.dart';
part 'recorder_state.dart';

class RecorderCubit extends Cubit<RecorderState> {
  RecorderCubit()
      : super(const RecorderState(
          status: RecorderStatus.initial,
        ));

  final Record _audioRecorder = Record();

  Future<void> deleteRecordFolder() async {
    Directory tempFolder = await getTemporaryDirectory();
    Directory temp2 = Directory('${tempFolder.path}/myrecords/');

    if (await temp2.exists()) {
      temp2.delete(recursive: true);
    }
  }

  Future<void> startRecording() async {
    Map<Permission, PermissionStatus> permissions = await [
      // Permission.storage,
      Permission.microphone,
    ].request();

    bool permissionsGranted = permissions[Permission.microphone]!.isGranted;

    if (permissionsGranted) {
      Directory tempFolder = await getTemporaryDirectory();
      Directory temp2 = Directory('${tempFolder.path}/myrecords/');

      if (!await temp2.exists()) {
        await temp2.create();
      }

      String filePath = '${temp2.path}${DateTime.now().millisecondsSinceEpoch.toString()}.wav}';
      log('$filePath Ses Kayit Basladi...');

      await _audioRecorder.start(path: filePath);

      emit(const RecorderState(status: RecorderStatus.onRecord));
    } else {
      emit(const RecorderState(status: RecorderStatus.permissionDenied));
    }
  }

  void pauseRecording() async {
    await _audioRecorder.pause();
    emit(const RecorderState(status: RecorderStatus.onPause));
    log('Ses Kayit durduruldu...');
  }

  void resumeRecording() async {
    await _audioRecorder.resume();
    emit(const RecorderState(status: RecorderStatus.onRecord));
    log('Ses Kayit devam ediyor...');
  }

  Future<void> stopRecording() async {
    String? path = await _audioRecorder.stop();
    emit(const RecorderState(status: RecorderStatus.stopped));
    log('${path.toString()} Ses Kayit Bitti...');
  }

  Stream<double> aplitudeStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      final ap = await _audioRecorder.getAmplitude();
      yield ap.current;
    }
  }
}
