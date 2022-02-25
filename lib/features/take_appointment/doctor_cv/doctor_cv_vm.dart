import 'package:flutter/material.dart';
import 'package:slugify/slugify.dart';

import '../../../../core/core.dart';
import '../../../../model/home/take_appointment/doctor_cv_response.dart';

class DoctorCvScreenVm extends ChangeNotifier {
  late DoctorCvResponse _doctorCvResponse;
  late BuildContext mContext;
  late String _imageUrl;

  LoadingProgress _progress = LoadingProgress.loading;
  LoadingProgress get progress => _progress;

  DoctorCvScreenVm({
    required BuildContext context,
    required String doctorNameNotTitle,
  }) {
    mContext = context;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await fetchDoctorCv(doctorNameNotTitle);
    });
  }

  Future<void> fetchDoctorCv(String doctorName) async {
    _progress = LoadingProgress.loading;
    notifyListeners();

    try {
      final doctorId = slugify(Utils.instance.clearDoctorTitle(
          doctorName.toLowerCase().xTurkishCharacterToEnglish));
      _doctorCvResponse =
          await getIt<Repository>().getDoctorCvDetails(doctorId);
      _progress = LoadingProgress.done;
      _imageUrl = SecretHelper.instance.get(SecretKeys.dev4Guven) +
          "/storage/app/media/" +
          _doctorCvResponse.image1!;
      notifyListeners();
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      _progress = LoadingProgress.error;
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
