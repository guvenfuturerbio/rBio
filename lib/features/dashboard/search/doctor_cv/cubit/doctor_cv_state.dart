part of 'doctor_cv_cubit.dart';

@freezed
class DoctorCvState with _$DoctorCvState {
  const factory DoctorCvState.initial() = _InitialState;
  const factory DoctorCvState.success(DoctorCvResponse result) = _SuccessState;
  const factory DoctorCvState.loading() = _LoadingState;
  const factory DoctorCvState.error(DoctorCvResponse? result) = _ErrorState;
}
