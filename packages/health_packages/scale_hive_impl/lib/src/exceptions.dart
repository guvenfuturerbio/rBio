import 'package:freezed_annotation/freezed_annotation.dart';

part 'exceptions.freezed.dart';

@freezed
class HiveScaleException with _$HiveScaleException {
  @Implements<Exception>()
  const factory HiveScaleException.boxClosed([String? message]) =
      HiveScaleBoxClosedException;

  @Implements<Exception>()
  const factory HiveScaleException.failedToDelete([String? message]) =
      HiveScaleFailedToDeleteException;

  @Implements<Exception>()
  const factory HiveScaleException.failedToWrite([String? message]) =
      HiveScaleFailedToWriteException;

  @Implements<Exception>()
  const factory HiveScaleException.failedToUpdate([String? message]) =
      HiveScaleFailedToUpdateException;

  @Implements<Exception>()
  const factory HiveScaleException.failedToRead([String? message]) =
      HiveScaleFailedToReadException;
}
