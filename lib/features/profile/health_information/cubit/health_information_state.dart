// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'health_information_cubit.dart';

enum HealthInformationType {
  diabetType,
  weight,
  normalRange,
  height,
  maxRange,
  minRange,
  smoker,
  yearofDiagnosis,
}

class HealthInformationState {
  Person? selection;
  bool showProgressOverlay;
  late RbioLoadingProgress status;
  HealthInformationState({
    this.selection,
    this.showProgressOverlay = false,
    this.status = RbioLoadingProgress.initial,
  });

  HealthInformationState copyWith({
    Person? selection,
    bool? showProgressOverlay,
    RbioLoadingProgress? status,
    HealthInformationType? informationType,
  }) {
    return HealthInformationState(
      selection: selection ?? this.selection,
      showProgressOverlay: showProgressOverlay ?? this.showProgressOverlay,
      status: status ?? this.status,
    );
  }
}
