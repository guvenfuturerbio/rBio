import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/core.dart';
import '../model/chat_person.dart';
import '../model/get_chat_contacts_response.dart';

class DoctorConsultationVm extends RbioVm {
  @override
  BuildContext mContext;

  late List<GetChatContactsResponse> apiUserList;
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  DoctorConsultationVm(this.mContext) {
    fetchAll();
  }

  Future<List<GetChatContactsResponse>> getChatContactsFirebaseId() async {
    return await getIt<Repository>().getChatContacts();
  }

  Future<void> fetchAll() async {
    try {
      apiUserList = [];
      progress = LoadingProgress.loading;
      apiUserList = await getChatContactsFirebaseId();
      if (apiUserList.isNotEmpty) {
        stream = getIt<FirestoreManager>().getContactsAndMessages();
      }
      progress = LoadingProgress.done;
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      progress = LoadingProgress.error;
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
    for (var apiItem in apiUserList) {
      final newPerson = ChatPerson(
        name: apiItem.contactNameSurname,
        lastMessage: '',
        lastMessageType: 0,
        lastMessageSender: '',
        messageTime: '',
        timestamp: 0,
        hasRead: true,
        url: "https://miro.medium.com/max/1000/1*vwkVPiu3M2b5Ton6YVywlg.png",
        id: apiItem.firebaseUserId,
        firebaseToken: apiItem.firebaseToken,
      );
      result.add(newPerson);
    }

    // Daha sonra api list içerisindeki tüm itemlardan firebase içerisinde olanları güncelliyoruz.
    for (var chatPerson in result) {
      for (var firebaseItem in streamList.docs) {
        final fbData = firebaseItem.data();
        final fbUsers = fbData['users'] as Map<dynamic, dynamic>?;
        if (fbUsers != null && fbUsers.containsKey(chatPerson.id)) {
          chatPerson.lastMessage = _getLastMessage(fbData);
          chatPerson.lastMessageType = _getLastMessageType(fbData);
          chatPerson.lastMessageSender = _getLastMessageSender(fbData);
          chatPerson.messageTime = _getMessageTime(fbData);
          chatPerson.timestamp = _getTimestamp(fbData);
          chatPerson.hasRead = _getHasRead(fbData);
          chatPerson.otherHasRead = _getOtherHasRead(fbData, chatPerson.id!);
        }
      }
    }
    result.sort((a, b) => b.timestamp!.compareTo(a.timestamp ?? 0));
    return result;
  }

  int _getLastMessageType(Map<String, dynamic> userData) {
    final messages = userData['messages'] as List?;
    if (messages == null) return 0;
    if (messages.isEmpty) return 0;
    return messages.last['type'] ?? 0;
  }

  String _getLastMessage(Map<String, dynamic> userData) {
    final messages = userData['messages'] as List?;
    if (messages == null) return '';
    if (messages.isEmpty) return '';
    return messages.last['message'] ?? '';
  }

  String _getLastMessageSender(Map<String, dynamic> userData) {
    final messages = userData['messages'] as List?;
    if (messages == null) return '';
    if (messages.isEmpty) return '';
    return messages.last['sentFrom'] ?? '';
  }

  String _getMessageTime(Map<String, dynamic> userData) {
    final messages = userData['messages'] as List?;
    if (messages == null) return '';
    if (messages.isEmpty) return '';
    DateTime messageDate =
        DateTime.fromMillisecondsSinceEpoch(messages.last['date']);
    if (messageDate.isToday) {
      return DateTime.fromMillisecondsSinceEpoch(messages.last['date'])
          .xFormatTime8(getIt<LocaleNotifier>().current.languageCode);
    } else {
      return timeago.format(
        DateTime.fromMillisecondsSinceEpoch(messages.last['date']),
        locale: getIt<LocaleNotifier>().current.languageCode,
      );
    }
  }

  bool _getHasRead(Map<String, dynamic> userData) {
    final users = userData['users'] as Map?;
    if (users == null) return true;
    return users[getIt<UserNotifier>().firebaseID] ?? true;
  }

  bool _getOtherHasRead(Map<String, dynamic> userData, String to) {
    final users = userData['users'] as Map?;
    if (users == null) return true;
    return users[to] ?? true;
  }

  int _getTimestamp(Map<String, dynamic> fbData) {
    final messages = fbData['messages'] as List;
    return messages.last['date'];
  }
}
