part of 'scale_doctor_cubit.dart';

@freezed
class ScaleDoctorState with _$ScaleDoctorState {
  const factory ScaleDoctorState.initial() = _Initial;
  const factory ScaleDoctorState.loading() = _Loading;
  const factory ScaleDoctorState.loaded(ScaleDoctorLoadedResult result) = _Loaded;
  const factory ScaleDoctorState.error() = _Error;
}
