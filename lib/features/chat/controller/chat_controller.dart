import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/core/utils/logger_helper.dart';

import '../../../core/core.dart';
import '../../../core/data/service/firebase_service.dart';
import '../model/message.dart';

class ChatController with ChangeNotifier {
  UserNotifier userProfilesNotifier = getIt<UserNotifier>();
  PickedFile imageFile;
  FirestoreManager manager = getIt<FirestoreManager>();
  bool isLoading;
  bool isShowSticker;
  String imageUrl;
  List<Message> messages;
  Stream<DocumentSnapshot<Map<String, dynamic>>> stream;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> streamSubscription;

  String chatId;
  String firstUser;
  String otherUser;
  bool hasOtherSeen;
  int otherLastSeen;
  @override
  void dispose() {
    cancelStreamSub();
    streamSubscription.cancel();
    super.dispose();
  }

  bool _getOtherHasRead(Map<String, dynamic> firebaseUserData, String to) {
    final users = firebaseUserData['users'] as Map;
    if (users == null) return true;
    return users[to] ?? true;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> init(
    String uuid,
    String uuidOther,
  ) {
    if (uuid.compareTo(uuidOther) == -1) {
      chatId = uuid + " - " + uuidOther;
      firstUser = uuid;
      otherUser = uuidOther;
    } else {
      chatId = uuidOther + " - " + uuid;
      firstUser = uuidOther;
      otherUser = uuid;
    }

    stream = manager.getMessages(uuid, uuidOther);
    streamSubscription = stream.listen((event) {
      final data = event.data();
      if (data != null && data['messages'] != null) {
        if (data['messages'].last['sentFrom'] == uuidOther &&
            data['users'][uuid] == false) {
          manager.setHasSeen(
              chatId,
              firstUser == uuid
                  ? {
                      uuid: true,
                      uuidOther: data['users'][uuidOther],
                    }
                  : {
                      uuidOther: data['users'][uuidOther],
                      uuid: true,
                    },
              data['messages'],
              {
                uuid: DateTime.now().millisecondsSinceEpoch,
                uuidOther: data['users_lastSeenDate'] == null
                    ? 0
                    : data['users_lastSeenDate'][uuidOther]
              });
        }
        otherLastSeen = data['users_lastSeenDate'] == null
            ? 0
            : data['users_lastSeenDate'][uuidOther];
      }

      LoggerUtils.instance.i(event.data());
    });

    return stream;
  }

  Future<bool> sendMessage(Message message, String sendTo) async {
    return await manager.sendMessage(message, sendTo);
  }

  void cancelStreamSub() {
    manager.cancelStreamSub();
  }

  Future<void> getImage(int index, String uuid, String uuidOther) async {
    manager.getImage(index, uuid, uuidOther);
  }
}
