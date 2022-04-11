import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/model/doctor/get_my_patient_filter.dart';

part 'scale_doctor_state.dart';
part 'scale_doctor_cubit.freezed.dart';

class ScaleDoctorCubit extends Cubit<ScaleDoctorState> {
  int patientId;
  List<ScaleModel>? scaleModel;
  ScaleDoctorCubit(this.patientId) : super(const ScaleDoctorState.initial());

  Future<List<ScaleModel>> fetchScaleData() async {
    var response = await getIt<DoctorRepository>().getMyPatientScale(
      patientId,
      GetMyPatientFilter(end: null, start: null),
    );
    scaleModel = response;
    return response;
  }
}
