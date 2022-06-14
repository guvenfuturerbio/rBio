import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/chat/model/chat_notification.dart';
import '../../../features/chat/model/chat_person.dart';
import '../../../features/chat/model/message.dart';
import '../../../features/chat/model/notification_data.dart';
import '../../../features/chat/model/notification_model.dart';
import '../../core/core.dart';

class FirestoreManager {
  XFile? imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  final keyConversations = 'conversations/';
  final keyUsers = 'users';
  final keyUsersDot = 'users.';
  final keyMessages = 'messages';
  final keyUsersLastSeenDate = 'users_lastSeenDate';

  final firestoreNotFoundException = "not-found";
  String getChatId(String first, String second) => "$first - $second";

  Future<void> loginFirebase() async {
    if (getIt<UserNotifier>().firebaseEmail != null &&
        getIt<UserNotifier>().firebasePassword != null) {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: getIt<UserNotifier>().firebaseEmail!,
        password: getIt<UserNotifier>().firebasePassword!,
      );
      final User? user = userCredential.user;
      if (user != null) {
        getIt<UserNotifier>().firebaseID = user.uid;
      }
    } else {
      if (getIt<IAppConfig>().productType == ProductType.oneDose) {
        throw Exception('Firebase email or password null');
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getContactsAndMessages() {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId != null) {
      return _firebaseDB
          .collection(keyConversations)
          .where(keyUsersDot + currentUserId, isNull: false)
          .snapshots();
    }

    throw Exception("currentUserId null");
  }

  Future<void> writeMessageToFirebase(
    String? first,
    String? second,
    Message message,
  ) async {
    if (first == null) return;
    if (second == null) return;

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
    } on FirebaseException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
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
    Message message,
    String sendTo,
    ChatPerson currentPerson,
    String otherNotiToken,
  ) async {
    if (sortUid(message, sendTo) == -1) {
      await writeMessageToFirebase(message.sentFrom, sendTo, message);
    } else {
      await writeMessageToFirebase(sendTo, message.sentFrom, message);
    }
    sendNotification(
      currentPerson,
      otherNotiToken,
      message,
    );
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

  int sortUid(
    Message message,
    String sendTo,
  ) {
    final compare = message.sentFrom?.compareTo(sendTo);
    if (compare == null) {
      throw Exception("compare null");
    }

    return compare;
  }

  Future<void> getImage(
    int index,
    String sender,
    String reciever,
    ChatPerson currentPerson,
    String otherNotiToken,
  ) async {
    final ImagePicker imagePicker = ImagePicker();
    imageFile = index == 0
        ? await imagePicker.pickImage(source: ImageSource.gallery)
        : await imagePicker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      Atom.show(const RbioLoading(), barrierDismissible: false);
      await uploadFile(sender, reciever, currentPerson, otherNotiToken);
      Atom.dismiss();
    }
  }

  Future<void> uploadFile(
    String sender,
    String reciever,
    ChatPerson currentPerson,
    String otherNotiToken,
  ) async {
    if (imageFile == null) return;

    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference reference = FirebaseStorage.instance.ref().child(fileName);
    await FlutterNativeImage.compressImage(
      imageFile!.path,
      quality: 80,
      percentage: 90,
    );
    await reference.putFile(File(imageFile!.path));
    sendMessage(
      Message(
        sentFrom: sender,
        message: await reference.getDownloadURL(),
        date: DateTime.now().millisecondsSinceEpoch,
        type: 1,
      ),
      reciever,
      currentPerson,
      otherNotiToken,
    );
  }

  Future<void> sendNotification(
    ChatPerson currentUser,
    String toToken,
    Message message,
  ) async {
    getIt<Repository>().sendNotification(
      ChatNotificationModel(
        to: toToken,
        contentAvailable: true,
        notification: NotificationModel(
          body: message.type == 0 ? message.message : "Media",
          title: getIt<UserNotifier>().getCurrentUserNameAndSurname(),
        ),
        data: NotificationData(
          body: message.type == 0 ? message.message : "Media",
          title: getIt<UserNotifier>().getCurrentUserNameAndSurname(),
          chatPerson: currentUser,
          type: 'chat',
        ),
      ),
    );
  }
}
