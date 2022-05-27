import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:slugify/slugify.dart';

import '../../../../../core/enums/loading_progress.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../model/model.dart';

part 'doctor_cv_state.dart';
part 'doctor_cv_cubit.freezed.dart';

class DoctorCvCubit extends Cubit<DoctorCvState> {
  DoctorCvCubit() : super(const DoctorCvState.initial());

  late final DoctorCvResponse response;
  late String _imageUrl;

  LoadingProgress _progress = LoadingProgress.loading;
  LoadingProgress get progress => _progress;

  Future<void> fetchDoctorCv(String doctorName) async {
    emit(const DoctorCvState.loading());
    _progress = LoadingProgress.loading;
    try {
      final doctorId = slugify(Utils.instance.clearDoctorTitle(
          doctorName.toLowerCase().xTurkishCharacterToEnglish));
      response = await getIt<Repository>().getDoctorCvDetails(doctorId);
      _progress = LoadingProgress.done;
      _imageUrl = getIt<KeyManager>().get(Keys.dev4Guven) +
          "/storage/app/media/" +
          response.image1!;
      emit(DoctorCvState.success(response));
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      _progress = LoadingProgress.error;
      _imageUrl = "";
      emit(const DoctorCvState.error(null));
    }
  }

  String get imageUrl => _imageUrl;
}
