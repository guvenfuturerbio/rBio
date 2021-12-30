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

  List<GetChatContactsResponse> apiUserList;
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
      apiUserList = [];
      progress = LoadingProgress.LOADING;
      apiUserList = await getChatContactsFirebaseId();
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

  List<ChatPerson> getChatPersonListWithStream(
    QuerySnapshot<Map<String, dynamic>> streamList,
  ) {
    List<ChatPerson> result = <ChatPerson>[];

    // İlk önce api'den gelen tüm kullanıcıları listeye ekliyoruz.
    apiUserList.forEach((apiItem) {
      final newPerson = ChatPerson(
        name: apiItem.contactNameSurname,
        lastMessage: '',
        lastMessageType: 0,
        lastMessageSender: '',
        messageTime: '',
        hasRead: true,
        url: "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png",
        id: apiItem.firebaseUserId,
      );
      result.add(newPerson);
    });

    // Daha sonra api list içerisindeki tüm itemlardan firebase içerisinde olanları güncelliyoruz.
    result.forEach((chatPerson) {
      streamList.docs.forEach((firebaseItem) {
        final fbData = firebaseItem.data();
        final fbUsers = fbData['users'] as Map;
        if (fbUsers != null && fbUsers.containsKey(chatPerson.id)) {
          chatPerson.lastMessage = _getLastMessage(fbData);
          chatPerson.lastMessageType = _getLastMessageType(fbData);
          chatPerson.lastMessageSender = _getLastMessageSender(fbData);
          chatPerson.messageTime = _getMessageTime(fbData);
          chatPerson.hasRead = _getHasRead(fbData);
          chatPerson.otherHasRead = _getOtherHasRead(fbData, chatPerson.id);
        }
      });
    });

    return result;
  }

  int _getLastMessageType(Map<String, dynamic> userData) {
    final messages = userData['messages'] as List;
    if (messages == null) return 0;
    if (messages.isEmpty) return 0;
    return messages.last['type'] ?? 0;
  }

  String _getLastMessage(Map<String, dynamic> userData) {
    final messages = userData['messages'] as List;
    if (messages == null) return '';
    if (messages.isEmpty) return '';
    return messages.last['message'] ?? '';
  }

  String _getLastMessageSender(Map<String, dynamic> userData) {
    final messages = userData['messages'] as List;
    if (messages == null) return '';
    if (messages.isEmpty) return '';
    return messages.last['sentFrom'] ?? '';
  }

  String _getMessageTime(Map<String, dynamic> userData) {
    final messages = userData['messages'] as List;
    if (messages == null) return '';
    if (messages.isEmpty) return '';
    // return timeago.format(
    //   DateTime.fromMillisecondsSinceEpoch(messages.last['date']),
    //   locale: getIt<LocaleNotifier>().current.languageCode,
    // );
    return DateTime.fromMillisecondsSinceEpoch(messages.last['date'])
        .xFormatTime8(getIt<LocaleNotifier>().current.languageCode);
  }

  bool _getHasRead(Map<String, dynamic> userData) {
    final users = userData['users'] as Map;
    if (users == null) return true;
    return users[getIt<UserNotifier>().firebaseID] ?? true;
  }

  bool _getOtherHasRead(Map<String, dynamic> userData, String to) {
    final users = userData['users'] as Map;
    if (users == null) return true;
    return users[to] ?? true;
  }
}
