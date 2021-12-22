import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../../core/core.dart';

class PatientConsultationUserModel {
  String name;
  String lastMessage;
  String photoUrl;
  PatientConsultationUserModel({
     this.name,
     this.lastMessage,
     this.photoUrl,
  });
}

class PatientConsultationVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  List<PatientConsultationUserModel> list;

  PatientConsultationVm(this.mContext) {
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
        PatientConsultationUserModel(
          name: 'Ayşe Yıldırım',
          lastMessage: 'Bir sorum olacaktı',
          photoUrl: R.image.profile_avatar,
        ),
        PatientConsultationUserModel(
          name: 'Murat Koç',
          lastMessage: 'Bir sorum olacaktı',
          photoUrl: R.image.profile_avatar,
        ),
        PatientConsultationUserModel(
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
