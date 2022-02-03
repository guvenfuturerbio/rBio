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
    mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchDoctorCv(doctorNameNotTitle);
    });
  }

  LoadingProgress get progress => _progress;

  Future<void> fetchDoctorCv(String doctorName) async {
    _progress = LoadingProgress.loading;
    notifyListeners();

    try {
      final doctorId = Slugify(Utils.instance.clearDoctorTitle(
          doctorName.toLowerCase().xTurkishCharacterToEnglish));
      _doctorCvResponse =
          await getIt<Repository>().getDoctorCvDetails(doctorId);
      if (_doctorCvResponse != null) {
        _progress = LoadingProgress.done;
        _imageUrl = SecretUtils.instance.get(SecretKeys.dev4Guven) +
                "/storage/app/media/" +
                this?._doctorCvResponse?.image1 ??
            "";
      } else {
        _progress = LoadingProgress.error;
        _imageUrl = "";
      }
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      debugPrintStack(stackTrace: stackTrace);
      _progress = LoadingProgress.ERROR;
      _imageUrl = "";
      notifyListeners();
    }
  }

  DoctorCvResponse get doctorCvResponse => _doctorCvResponse;
  String get imageUrl => _imageUrl;

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }
}
