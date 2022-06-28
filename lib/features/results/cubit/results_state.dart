part of 'results_cubit.dart';

class ResultsState {
  late List<VisitResponse> visits;
  late DateTime startDate;
  late DateTime endDate;
  late RbioLoadingProgress status;

  ResultsState({
    List<VisitResponse>? visits,
    DateTime? startDate,
    DateTime? endDate,
    RbioLoadingProgress? status,
  }) {
    this.visits = visits ?? [];
    this.startDate = startDate ??
        DateTime(
          DateTime.now().year - 1,
          DateTime.now().month,
          DateTime.now().day,
        );
    this.endDate = endDate ??
        DateTime(
          DateTime.now().year + 1,
          DateTime.now().month,
          DateTime.now().day,
        );
    this.status = status ?? RbioLoadingProgress.initial;
  }

  ResultsState copyWith({
    List<VisitResponse>? visits,
    DateTime? startDate,
    DateTime? endDate,
    RbioLoadingProgress? status,
  }) {
    return ResultsState(
      visits: visits ?? this.visits,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}
