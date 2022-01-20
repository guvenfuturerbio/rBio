import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:slugify/slugify.dart';

import '../../../../model/home/take_appointment/doctor_cv_response.dart';
import '../../core/core.dart';

class DoctorCvScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  DoctorCvScreenVm({BuildContext context, String doctorNameNotTitle}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchDoctorCv(doctorNameNotTitle);
    });
  }

  DoctorCvResponse _doctorCvResponse;
  LoadingProgress _progress;
  String _imageUrl;

  LoadingProgress get progress => this._progress;

  Future<void> fetchDoctorCv(String doctorName) async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();

    try {
      final doctorId = Slugify(clearDoctorTitle(doctorName.toLowerCase())
          .xTurkishCharacterToEnglish);
      this._doctorCvResponse =
          await getIt<Repository>().getDoctorCvDetails(doctorId);
      if (this._doctorCvResponse != null) {
        this._progress = LoadingProgress.DONE;
        this._imageUrl = SecretUtils.instance.get(SecretKeys.DEV_4_GUVEN) +
                "/storage/app/media/" +
                this?._doctorCvResponse?.image1 ??
            "";
      } else {
        this._progress = LoadingProgress.ERROR;
        this._imageUrl = "";
      }
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      debugPrintStack(stackTrace: stackTrace);
      this._progress = LoadingProgress.ERROR;
      this._imageUrl = "";
      notifyListeners();
    }
  }

  DoctorCvResponse get doctorCvResponse => this._doctorCvResponse;
  String get imageUrl => this._imageUrl;

  String clearDoctorTitle(String text) {
    if (text.contains('dr.')) {
      return text.split('dr.')[1];
    } else {
      return text;
    }
  }
}
