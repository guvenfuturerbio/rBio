import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chat/model/chat_person.dart';
import 'package:onedosehealth/features/chat/model/get_chat_contacts_response.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';

class DoctorConsultationVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  List<ChatPerson> list;

  DoctorConsultationVm(this.mContext) {
    fetchAll();
  }
  Future<List<GetChatContactsResponse>> getChatContactsFirebaseId() async {
    return await getIt<Repository>().getChatContacts();
  }

  LoadingProgress _progress;
  LoadingProgress get progress => _progress;
  set progress(LoadingProgress value) {
    _progress = value;
    notifyListeners();
  }

  Future<void> fetchAll() async {
    try {
      list = [];
      progress = LoadingProgress.LOADING;
      List<GetChatContactsResponse> firebaseIdList =
          await getChatContactsFirebaseId();
      firebaseIdList.forEach((element) {
        ChatPerson newPerson = ChatPerson(
            name: element.contactNameSurname,
            url:
                "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png",
            id: element.firebaseUserId);
        list.add(newPerson);
      });

      progress = LoadingProgress.DONE;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);

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
