import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:slugify/slugify.dart';

import '../../../../core/core.dart';
import '../../../../model/home/take_appointment/doctor_cv_response.dart';

class DoctorCvScreenVm extends ChangeNotifier {
  DoctorCvResponse _doctorCvResponse;
  BuildContext mContext;
  LoadingProgress _progress;
  String _imageUrl;
  
  DoctorCvScreenVm({BuildContext context, String doctorNameNotTitle}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchDoctorCv(doctorNameNotTitle);
    });
  }

  LoadingProgress get progress => this._progress;

  Future<void> fetchDoctorCv(String doctorName) async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();

    try {
      final doctorId = Slugify(turkishCharacterToEnglish(
          clearDoctorTitle(doctorName.toLowerCase())));
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

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
        });
  }
}
