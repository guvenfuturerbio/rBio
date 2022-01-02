import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:onedosehealth/features/chat/model/chat_person.dart';

import '../../../core/core.dart';
import '../../../core/data/service/firestore_manager.dart';
import '../model/message.dart';

class ChatVm with ChangeNotifier {
  FirestoreManager firestoreManager = getIt<FirestoreManager>();
  Stream<DocumentSnapshot<Map<String, dynamic>>> stream;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> streamSubscription;

  String chatId;
  String firstUser;
  String otherUser;
  int otherLastSeen;

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> init(
    String currentUserId,
    String otherUserId,
    VoidCallback receiveNewMessage,
  ) {
    if (currentUserId.compareTo(otherUserId) == -1) {
      chatId = firestoreManager.getChatId(currentUserId, otherUserId);
      firstUser = currentUserId;
      otherUser = otherUserId;
    } else {
      chatId = firestoreManager.getChatId(otherUserId, currentUserId);
      firstUser = otherUserId;
      otherUser = currentUserId;
    }

    stream =
        firestoreManager.getCurrentUserSnapShots(currentUserId, otherUserId);
    streamSubscription = stream.listen((event) {
      final data = event.data();
      if (data != null && data['messages'] != null) {
        final widgetsBinding = WidgetsBinding.instance;
        if (widgetsBinding != null) {
          widgetsBinding.addPostFrameCallback((_) {
            receiveNewMessage();
          });
        }

        if (data['messages'].last['sentFrom'] == otherUserId &&
            data['users'][currentUserId] == false) {
          firestoreManager.setHasSeen(
              chatId,
              firstUser == currentUserId
                  ? {
                      currentUserId: true,
                      otherUserId: data['users'][otherUserId],
                    }
                  : {
                      otherUserId: data['users'][otherUserId],
                      currentUserId: true,
                    },
              data['messages'],
              {
                currentUserId: DateTime.now().millisecondsSinceEpoch,
                otherUserId: data['users_lastSeenDate'] == null
                    ? 0
                    : data['users_lastSeenDate'][otherUserId]
              });
        }
        otherLastSeen = data['users_lastSeenDate'] == null
            ? 0
            : data['users_lastSeenDate'][otherUserId];
      }

      LoggerUtils.instance.i(event.data());
    });

    return stream;
  }

  Future<bool> sendMessage(
      Message message, String sendTo, ChatPerson currentPerson,String otherNotiToken) async {
    return await firestoreManager.sendMessage(message, sendTo, currentPerson,otherNotiToken);
  }

  Future<void> getImage(int index, String uuid, String uuidOther,
      ChatPerson currentPerson,String otherNotiToken) async {
    firestoreManager.getImage(index, uuid, uuidOther, currentPerson,otherNotiToken);
  }
}
