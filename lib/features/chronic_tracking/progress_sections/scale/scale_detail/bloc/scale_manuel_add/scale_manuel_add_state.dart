part of 'scale_manuel_add_cubit.dart';

@freezed
class ScaleManuelAddState with _$ScaleManuelAddState {
  const factory ScaleManuelAddState.initial(ScaleManuelAddResult result) = _Initial;
  const factory ScaleManuelAddState.loadInProgress() = _LoadInProgress;
  const factory ScaleManuelAddState.showWarningDialog(String description) = _ShowWarningDialog;
  const factory ScaleManuelAddState.failure() = _Failure;
  const factory ScaleManuelAddState.successAdded() = _SuccessAdded;
}

class ScaleManuelAddResult {
  final DateTime dateTime;
  final double? weight;
  final ScaleUnit scaleUnit;

  ScaleManuelAddResult({
    required this.dateTime,
    this.weight,
    this.scaleUnit = ScaleUnit.kg,
  });

  ScaleManuelAddResult copyWith({
    DateTime? dateTime,
    double? weight,
    ScaleUnit? scaleUnit,
  }) {
    return ScaleManuelAddResult(
      dateTime: dateTime ?? this.dateTime,
      weight: weight ?? this.weight,
      scaleUnit: scaleUnit ?? this.scaleUnit,
    );
  }
}
