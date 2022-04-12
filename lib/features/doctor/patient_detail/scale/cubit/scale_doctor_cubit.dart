import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/data/service/model/patient_scale_measurement.dart';
import 'package:onedosehealth/features/doctor/patient_detail/scale/cubit/scale_doctor_loaded_result.dart';
import 'package:onedosehealth/model/doctor/get_my_patient_filter.dart';

part 'scale_doctor_state.dart';
part 'scale_doctor_cubit.freezed.dart';

class ScaleDoctorCubit extends Cubit<ScaleDoctorState> {
  int patientId;
  List<PatientScaleMeasurement>? patientScaleMeasurements;
  ScaleDoctorCubit(this.patientId) : super(const ScaleDoctorState.initial());
  void toogleChart() {
    final currentState = state;

    currentState.whenOrNull(
      loaded: (result) {
        emit(
          ScaleDoctorState.loaded(
            result.copyWith(isChartVisible: result.isChartVisible),
          ),
        );
      },
    );
  }

  Future<List<PatientScaleMeasurement>> fetchScaleData() async {
    emit(ScaleDoctorState.loading());
    var response = await getIt<DoctorRepository>().getMyPatientScale(
      patientId,
      GetMyPatientFilter(end: null, start: null),
    );
    patientScaleMeasurements = response;
    final currentState = state;

    emit(ScaleDoctorState.loaded(ScaleDoctorLoadedResult(
      patientScaleMeasurements: patientScaleMeasurements ?? [],
      isChartVisible: false,
    )));
    return response;
  }
}
