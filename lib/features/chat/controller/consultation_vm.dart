import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chat/model/chat_person.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';

class DoctorConsultationVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  List<ChatPerson> list;

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
        ChatPerson(
            name: 'Ayşe Yıldırım',
            id: 'Bir sorum olacaktı',
            lastMessage: R.image.profile_avatar,
            hasRead: true,
            messageTime:
                DateTime.now().subtract(Duration(days: 1)).xFormatTime3(),
            url:
                "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png"),
        ChatPerson(
            name: 'Ayşe Yıldırım',
            id: 'Bir sorum olacaktı',
            lastMessage: R.image.profile_avatar,
            hasRead: true,
            messageTime:
                DateTime.now().subtract(Duration(days: 1)).xFormatTime3(),
            url:
                "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png"),
        ChatPerson(
            name: 'Ayşe Yıldırım',
            id: 'Bir sorum olacaktı',
            hasRead: false,
            lastMessage: R.image.profile_avatar,
            messageTime:
                DateTime.now().subtract(Duration(days: 1)).xFormatTime3(),
            url:
                "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png"),
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
