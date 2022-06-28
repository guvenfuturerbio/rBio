part of 'results_cubit.dart';

@freezed
// ignore_for_file: public_member_api_docs, sort_constructors_first

@freezed
class ResultsState with _$ResultsState {
  const factory ResultsState.initial() = _Initial;
  const factory ResultsState.loadInProgress() = _LoadInProgress;
  const factory ResultsState.success(ResultResponse response) = _Success;
  const factory ResultsState.failure() = _Failure;
}

class ResultResponse {
  List<VisitResponse>? visits;
  DateTime? startDate;
  DateTime? endDate;
  bool? hasResult = true;
  VisitRequest? visitRequestBody;

  ResultResponse(
      {this.visits,
      VisitRequest? visitRequestBody,
      this.hasResult = true,
      DateTime? startDate,
      DateTime? endDate}) {
    startDate = startDate ??
        DateTime(
          DateTime.now().year - 1,
          DateTime.now().month,
          DateTime.now().day,
        );
    endDate = endDate ??
        DateTime(
          DateTime.now().year + 1,
          DateTime.now().month,
          DateTime.now().day,
        );
    visitRequestBody = visitRequestBody ??
        VisitRequest(
            from: DateTime(DateTime.now().year - 1, DateTime.now().month,
                    DateTime.now().day)
                .toString(),
            to: DateTime(DateTime.now().year + 1, DateTime.now().month,
                    DateTime.now().day)
                .toString(),
            isForeignPatient:
                getIt<UserNotifier>().getPatient().nationalityId == 213
                    ? 0
                    : 1, // 213 - Türk
            hasResults: 1,
            identityNumber:
                getIt<UserNotifier>().getPatient().nationalityId == 213
                    ? getIt<UserNotifier>().getPatient().identityNumber
                    : getIt<UserNotifier>().getPatient().passportNumber);
  }

  ResultResponse copyWith({
    List<VisitResponse>? visits,
    DateTime? startDate,
    DateTime? endDate,
    VisitRequest? visitRequestBody,
    bool? hasResult,
  }) {
    return ResultResponse(
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      visitRequestBody: visitRequestBody ?? this.visitRequestBody,
      visits: visits ?? this.visits,
      hasResult: hasResult ?? this.hasResult,
    );
  }
}
