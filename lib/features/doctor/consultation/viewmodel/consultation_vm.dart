import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../model/consultation_user_model.dart';

class DoctorConsultationVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  List<DoctorConsultationUserModel> list;

  DoctorConsultationVm(this.mContext) {
    fetchAll();
  }

  LoadingProgress _progress;
  LoadingProgress get progress => _progress;
  set progress(LoadingProgress value) {
    _progress = value;
    notifyListeners();
  }

  Future<void> fetchAll() async {
    try {
      progress = LoadingProgress.LOADING;
      await Future.delayed(Duration(seconds: 1));
      list = [
        DoctorConsultationUserModel(
          name: 'Ayşe Yıldırım',
          lastMessage: 'Bir sorum olacaktı',
          photoUrl: R.image.profile_avatar,
        ),
        DoctorConsultationUserModel(
          name: 'Murat Koç',
          lastMessage: 'Bir sorum olacaktı',
          photoUrl: R.image.profile_avatar,
        ),
        DoctorConsultationUserModel(
          name: 'Ali Uysal',
          lastMessage: 'Bir sorum olacaktı',
          photoUrl: R.image.profile_avatar,
        ),
      ];
      progress = LoadingProgress.DONE;
    } catch (e, stackTrace) {
      progress = LoadingProgress.ERROR;
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
        true,
      );
    }
  }
}
