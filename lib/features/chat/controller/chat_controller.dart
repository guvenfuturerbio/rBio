import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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
  Future<bool> sendMessage(Message message) async {
    return manager.sendMessage(message);
  }

  Stream<List<Message>> getMessages(String uuid, uuidOther) {
    return manager.getMessages(uuid, uuidOther);
  }

  Future<void> getImage(int index, String uuid, String uuidOther) async {
    manager.getImage(index, uuid, uuidOther);
  }
}
