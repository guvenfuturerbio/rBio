import 'package:freezed_annotation/freezed_annotation.dart';

part 'scale_hive_exception.freezed.dart';

@freezed
class ScaleHiveException with _$ScaleHiveException {
  @Implements<Exception>()
  const factory ScaleHiveException.boxClosed([String? message]) = ScaleHiveBoxClosedException;

  @Implements<Exception>()
  const factory ScaleHiveException.failedToDelete([String? message]) = ScaleHiveFailedToDeleteException;

  @Implements<Exception>()
  const factory ScaleHiveException.failedToWrite([String? message]) = ScaleHiveFailedToWriteException;

  @Implements<Exception>()
  const factory ScaleHiveException.failedToUpdate([String? message]) = ScaleHiveFailedToUpdateException;

  @Implements<Exception>()
  const factory ScaleHiveException.failedToRead([String? message]) = ScaleHiveFailedToReadException;
}
