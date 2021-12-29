import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/core.dart';
import '../../../core/data/service/firebase_service.dart';
import '../model/chat_person.dart';
import '../model/get_chat_contacts_response.dart';

class DoctorConsultationVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  List<GetChatContactsResponse> list;
  Stream<QuerySnapshot<Map<String, dynamic>>> stream;

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
      list = await getChatContactsFirebaseId();
      stream = getIt<FirestoreManager>().getContactsAndMessages();
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

  List<ChatPerson> getChatPersonWithStream(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> streamList) {
    List<ChatPerson> chatPersonList = <ChatPerson>[];
    list.forEach((apiItem) {
      final newPerson = ChatPerson(
        name: apiItem.contactNameSurname,
        lastMessage: '',
        messageTime: '',
        hasRead: true,
        url: "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png",
        id: apiItem.firebaseUserId,
      );
      chatPersonList.add(newPerson);
    });

    chatPersonList.forEach((chatPerson) {
      streamList.data.docs.forEach((firebaseItem) {
        final firebaseUserData = firebaseItem.data();
        final firebaseUserUsers = firebaseUserData['users'] as Map;
        if (firebaseUserUsers.containsKey(chatPerson.id)) {
          chatPerson.lastMessage = firebaseUserData['messages'].last['message'];
          chatPerson.messageTime = _getMessageTime(firebaseUserData);
          chatPerson.hasRead = _getHasRead(firebaseUserData);
        }
      });
    });

    return chatPersonList;
  }

  String _getMessageTime(Map<String, dynamic> firebaseUserData) {
    final messages = firebaseUserData['messages'] as List;
    if (messages == null) return '';
    if (messages.isEmpty) return '';
    return timeago.format(
      DateTime.fromMillisecondsSinceEpoch(messages.last['date']),
      locale: getIt<LocaleNotifier>().current.languageCode,
    );
  }

  bool _getHasRead(Map<String, dynamic> firebaseUserData) {
    final users = firebaseUserData['users'] as Map;
    if (users == null) return true;
    return users[getIt<UserNotifier>().firebaseID] ?? true;
  }
}
