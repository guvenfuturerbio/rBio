import 'dart:io';

import 'package:onedosehealth/app/bluetooth_v2/bluetooth_v2.dart';

class RecordModel extends Equatable {
  final FileSystemEntity file;
  final Duration fileDuration;
  late final DateTime dateTime;

  RecordModel({
    required this.file,
    required this.fileDuration,
  }) {
    final millisecond = int.parse(file.path.split('/').last.split('.').first);
    dateTime = DateTime.fromMillisecondsSinceEpoch(millisecond);
  }

  @override
  List<Object?> get props => [file, fileDuration];

  @override
  bool? get stringify => true;
}
