import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/features/chat/model/chat_person.dart';

import '../../../features/chat/model/message.dart';
import '../../core.dart';

class FirestoreManager {
  PickedFile imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  final keyConversations = 'conversations/';
  final keyUsers = 'users';
  final keyUsersDot = 'users.';
  final keyMessages = 'messages';
  final keyUsersLastSeenDate = 'users_lastSeenDate';

  final firestoreNotFoundException = "not-found";
  String getChatId(String first, String second) => first + " - " + second;

  Future<void> loginFirebase() async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: getIt<UserNotifier>().firebaseEmail,
      password: getIt<UserNotifier>().firebasePassword,
    );
    final User user = userCredential.user;
    getIt<UserNotifier>().firebaseID = user.uid;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getContactsAndMessages() {
    return _firebaseDB
        .collection(keyConversations)
        .where(keyUsersDot + _auth.currentUser.uid, isNull: false)
        .snapshots();
  }

  Future<void> writeMessageToFirebase(
    String first,
    String second,
    Message message,
  ) async {
    Map<String, dynamic> usersMap = {};
    if (message.sentFrom != second) {
      usersMap = {first: true, second: false};
    } else {
      usersMap = {first: false, second: true};
    }

    try {
      await _firebaseDB
          .collection(keyConversations)
          .doc(getChatId(first, second))
          .update(
        {
          keyMessages: FieldValue.arrayUnion([message.toMap()]),
          keyUsers: usersMap,
        },
      );
    } on FirebaseException catch (e) {
      if (e.code == firestoreNotFoundException) {
        await _firebaseDB
            .collection(keyConversations)
            .doc(getChatId(first, second))
            .set({
          keyMessages: FieldValue.arrayUnion([message.toMap()]),
          keyUsers: usersMap,
        });
      }
    }
  }

  Future<void> setHasSeen(
    String chatId,
    Map<String, dynamic> users,
    List messages,
    Map<String, dynamic> lastSeenDate,
  ) async {
    await _firebaseDB.collection(keyConversations).doc(chatId).set(
      {
        keyMessages: messages,
        keyUsers: users,
        keyUsersLastSeenDate: lastSeenDate
      },
    );
  }

  Future<bool> sendMessage(
      Message message, String sendTo, ChatPerson currentPerson) async {
    if (sortUid(message, sendTo) == -1) {
      await writeMessageToFirebase(message.sentFrom, sendTo, message);
    } else {
      await writeMessageToFirebase(sendTo, message.sentFrom, message);
    }
    return true;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserSnapShots(
    String currentUserId,
    String otherUserId,
  ) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> snapShots;
    if (sortUid(Message(sentFrom: currentUserId), otherUserId) == -1) {
      snapShots = readMessagesFromFirebase(currentUserId, otherUserId);
    } else {
      snapShots = readMessagesFromFirebase(otherUserId, currentUserId);
    }
    return snapShots;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> readMessagesFromFirebase(
    String first,
    String second,
  ) {
    return _firebaseDB
        .collection(keyConversations)
        .doc(getChatId(first, second))
        .snapshots();
  }

  int sortUid(Message message, String sendTo) =>
      message.sentFrom.compareTo(sendTo);

  Future<void> getImage(int index, String sender, String reciever,
      ChatPerson currentPerson) async {
    ImagePicker imagePicker = new ImagePicker();
    imageFile = index == 0
        ? await imagePicker.getImage(source: ImageSource.gallery)
        : await imagePicker.getImage(source: ImageSource.camera);

    if (imageFile != null) {
      uploadFile(sender, reciever, currentPerson);
    }
  }

  Future<void> uploadFile(
      String sender, String reciever, ChatPerson currentPerson) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    await FlutterNativeImage.compressImage(
      imageFile.path,
      quality: 80,
      percentage: 90,
    );
    await reference.putFile(File(imageFile.path));
    sendMessage(
      Message(
        sentFrom: sender,
        message: await reference.getDownloadURL(),
        date: DateTime.now().millisecondsSinceEpoch,
        type: 1,
      ),
      reciever,
      currentPerson,
    );
  }

  Future<void> sendNotification(
    ChatPerson currentUser,
    String toToken,
    Message message,
  ) async {
    String endURL = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAAPdkryvk:APA91bHk4qe_nsEly9N1IihDx85GG5k_nw3tKlcBVyBPLrzsQ9Ytyih9BPbI2m3VSOiaHb0cPGMOSAtnqwxYJlCB8Puz4CJqWDuTDdEjtw_PrhQOcyQEOoVBqCnJrKZvpNFBKK-IdsfW";
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$firebaseKey"
    };

    final jsonBody = <String, dynamic>{
      "to": "$toToken",
      "notification": {
        "title":
            "${getIt<UserNotifier>().getPatient().firstName} ${getIt<UserNotifier>().getPatient().lastName}",
        "body": message.message,
      },
      "data": {
        "type": 'chat',
        "chatPerson": currentUser.toMap(),
      }
    };

    try {
      await http.post(
        Uri.parse(endURL),
        headers: headers,
        body: jsonEncode(jsonBody),
      );
    } catch (e) {
      LoggerUtils.instance.e(message);
    }
  }
}
