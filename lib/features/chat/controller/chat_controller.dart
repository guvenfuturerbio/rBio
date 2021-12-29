
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/data/service/firebase_service.dart';
import 'package:onedosehealth/features/chat/model/message.dart';

class ChatController with ChangeNotifier {
  UserNotifier userProfilesNotifier = getIt<UserNotifier>();
  PickedFile imageFile;
  FirestoreManager manager = getIt<FirestoreManager>();
  bool isLoading;
  bool isShowSticker;
  String imageUrl;
  List<Message> messages;
  Future<bool> sendMessage(Message message,String sendTo) async {
    return await manager.sendMessage(message,sendTo);
  }

  @override
  void dispose() {
    cancelStreamSub();
    super.dispose();
  }

  void cancelStreamSub() {
    manager.cancelStreamSub();
  }

   Stream<DocumentSnapshot<Map<String, dynamic>>> getMessages(String uuid, uuidOther) {
    return manager.getMessages(uuid, uuidOther);
  }

  Future<void> getImage(int index, String uuid, String uuidOther) async {
    manager.getImage(index, uuid, uuidOther);
  }
}
