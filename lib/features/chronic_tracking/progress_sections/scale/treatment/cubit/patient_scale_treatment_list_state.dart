part of 'patient_scale_treatment_list_cubit.dart';

@freezed
class PatientScaleTreatmentListState with _$PatientScaleTreatmentListState {
  const factory PatientScaleTreatmentListState.initial() = _Initial;
  const factory PatientScaleTreatmentListState.loadInProgress() =
      _LoadInProgress;
  const factory PatientScaleTreatmentListState.success(
      PatientScaleTreatmentListResult result) = _Success;
  const factory PatientScaleTreatmentListState.failure() = _Failure;
}

class PatientScaleTreatmentListResult {
  final List<RbioTreatmentModel> list;
  final TreatmentFilterType filterType;
  final DateTime startCurrentDate;
  final DateTime endCurrentDate;

  PatientScaleTreatmentListResult({
    this.list = const [],
    this.filterType = TreatmentFilterType.current,
    required this.startCurrentDate,
    required this.endCurrentDate,
  });

  PatientScaleTreatmentListResult copyWith({
    List<RbioTreatmentModel>? list,
    TreatmentFilterType? filterType,
    DateTime? startCurrentDate,
    DateTime? endCurrentDate,
  }) {
    return PatientScaleTreatmentListResult(
      list: list ?? this.list,
      filterType: filterType ?? this.filterType,
      startCurrentDate: startCurrentDate ?? this.startCurrentDate,
      endCurrentDate: endCurrentDate ?? this.endCurrentDate,
    );
  }
}
