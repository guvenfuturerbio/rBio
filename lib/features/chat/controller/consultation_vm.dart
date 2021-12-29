import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/data/service/firebase_service.dart';
import 'package:onedosehealth/features/chat/model/chat_person.dart';
import 'package:onedosehealth/features/chat/model/get_chat_contacts_response.dart';
import 'package:onedosehealth/generated/intl/messages_tr.dart';
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
    Stream<QuerySnapshot<Map<String, dynamic>>> streamList =
        getIt<FirestoreManager>().getContactsAndMessages();

    try {
      list = [];
      progress = LoadingProgress.LOADING;
      List<GetChatContactsResponse> firebaseIdList =
          await getChatContactsFirebaseId();

      firebaseIdList.forEach((restApiElement) {
        streamList.forEach((element) {
          element.docs.forEach((element2) {
            if ((element2.data()['users'] as Map)
                .containsKey(restApiElement.firebaseUserId)) {
              ChatPerson newPerson = ChatPerson(
                name: restApiElement.contactNameSurname,
                lastMessage: element2.data()['messages'].last['message'],
                messageTime: element2.data()['messages'].last['messageTime'],
                hasRead: (element2.data()['users']
                        as Map)[getIt<UserNotifier>().firebaseID] ??
                    false,
                url:
                    "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png",
                id: restApiElement.firebaseUserId,
              );
              list.add(newPerson);
            }
          });
        });
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
