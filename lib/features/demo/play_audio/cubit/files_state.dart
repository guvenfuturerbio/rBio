// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'files_cubit.dart';

@freezed
class FilesState with _$FilesState {
  const factory FilesState.initial() = _Initial;
  const factory FilesState.loadInProgress() = _LoadInProgress;
  const factory FilesState.success({
   required List<RecordModel> recordList,
  }) = _Success;
  const factory FilesState.failure() = _Failure;
}


