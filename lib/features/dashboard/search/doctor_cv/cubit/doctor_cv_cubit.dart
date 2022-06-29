import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slugify/slugify.dart';

import '../../../../../core/core.dart';
import '../../../../../model/model.dart';

part 'doctor_cv_cubit.freezed.dart';
part 'doctor_cv_state.dart';

class DoctorCvCubit extends Cubit<DoctorCvState> {
  DoctorCvCubit() : super(const DoctorCvState.initial());

  late final DoctorCvResponse response;

  String _imageUrl = "";

  Future<void> fetchDoctorCv({required String doctorName, required String cvLink}) async {
    emit(const DoctorCvState.loading());

    try {
      final String doctorId = cvLink == ''
          ? slugify(
              Utils.instance.clearDoctorTitle(doctorName.toLowerCase().xTurkishCharacterToEnglish),
            )
          : cvLink;
      response = await getIt<Repository>().getDoctorCvDetails(doctorId);
      _imageUrl = response.image1 == null ? '' : getIt<KeyManager>().get(Keys.dev4Guven) + "/storage/app/media/" + response.image1!;
      emit(DoctorCvState.success(response));
    } catch (e) {
      emit(const DoctorCvState.error(null));
    }
  }

  String get imageUrl => _imageUrl;
}
