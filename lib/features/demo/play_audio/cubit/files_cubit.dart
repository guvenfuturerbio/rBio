import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onedosehealth/features/demo/audio_recorder/model/record_mode.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/audio_controller.dart';

part 'files_cubit.freezed.dart';
part 'files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit() : super(const FilesState.initial());

  Future<void> getFiles({required String path}) async {
    List<RecordModel> recordings = [];
    emit(const FilesState.loadInProgress());

    Directory tempFolder = await getTemporaryDirectory();
    Directory temp2 = Directory('${tempFolder.path}/myrecords/');

    final List<FileSystemEntity> files = temp2.listSync();

    for (final file in files) {
      AudioPlayerController controller = AudioPlayerController();

      /// Used controller her just to get the duration on file using [setPath()]
      Duration? fileDuration = await controller.setPath(filePath: file.path);
      if (fileDuration != null) {
        recordings.add(RecordModel(file: file, fileDuration: fileDuration));
      }
    }

    emit(FilesState.success(recordList: recordings));
  }

  removeRecording(RecordModel recording) {
    state.mapOrNull(
      success: (_Success successState) async {
        final List<RecordModel> recordList = successState.recordList.where((element) {
          Directory recordDirectory = Directory(element.file.path);
          recordDirectory.deleteSync();
          return element != recording;
        }).toList();
        emit(FilesState.success(recordList: recordList));
      },
    );
  }
}
