import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/chat/model/message.dart';
import '../../core.dart';

class FirestoreManager {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> streamSubscription;
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  PickedFile imageFile;

  Future<void> loginFirebase() async {
    final User user = (await _auth.signInWithEmailAndPassword(
            email: getIt<UserNotifier>().firebaseEmail,
            password: getIt<UserNotifier>().firebasePassword))
        .user;
    getIt<UserNotifier>().firebaseID = user.uid;
  }

  sortUid(Message message, String sendTo) {
    return message.sentFrom.compareTo(sendTo);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getContactsAndMessages() {
    return _firebaseDB
        .collection("conversations/")
        .where('users.' + _auth.currentUser.uid, isNull: false)
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
          .collection("conversations/")
          .doc(first + " - " + second)
          .update(
        {
          'messages': FieldValue.arrayUnion([message.toMap()]),
          'users': usersMap,
        },
      );
    } on FirebaseException catch (e) {
      if (e.code == "not-found") {
        await _firebaseDB
            .collection("conversations/")
            .doc(first + " - " + second)
            .set({
          'messages': FieldValue.arrayUnion([message.toMap()]),
          'users': usersMap,
        });
      }
      LoggerUtils.instance.e(e.code);
      LoggerUtils.instance.e(e);
    }
  }

  Future<void> setHasSeen(String chatId, Map<String, dynamic> users,
      List messages, Map<String, dynamic> lastSeenDate) async {
    await _firebaseDB.collection("conversations/").doc(chatId).set(
      {
        'messages': messages,
        'users': users,
        'users_lastSeenDate': lastSeenDate
      },
    );
  }

  Future<bool> sendMessage(Message message, String sendTo) async {
    if (sortUid(message, sendTo) == -1) {
      await writeMessageToFirebase(message.sentFrom, sendTo, message);
    } else {
      await writeMessageToFirebase(sendTo, message.sentFrom, message);
    }
    //sendNotification(message);
    return true;
  }

  /*Future<bool> sendNotification(Message message) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.doc("tokens/" + message.sentTo).get();
    String token = snapshot.data()['token'];
    String endURL = "https://fcm.googleapis.com/fcm/send";
    String firebaseKey =
        "AAAAfciWego:APA91bEH2_uwKP5pCFqtl9IOaIT_T7vlUtCxCPbL3uNnG0rl_JDkk6jYd4XCNWy1DI_aGiujqeUIz3ND_RnTp07o3LNymihr_7_kF0Nn3vM2aB_jWYS9JhkowWEDnLSscwK7iRtvUlCE";
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "key=$firebaseKey"
    };

    String json =
        '{ "to" : "$token", "notification" :{ "title" : "${userProfilesNotifier.selection.name}", "body" : "${message.message}" }, "data" : {"type":"3", "message" : "${message.message}", "title": "${userProfilesNotifier.selection.name} ","id": "${PatientIdHolder().patient_id}" } }';

    http.Response response =
        await http.post(Uri.parse(endURL), headers: headers, body: json);

    if (response.statusCode == 200) {
      print(response.body);
      print("işlem basarılı");
      print("yollanan json: " + json);
    } else {
      print("işlem basarısız:" + response.statusCode.toString());
      print("jsonumuz:" + json);
    }
  }*/

  Stream<DocumentSnapshot<Map<String, dynamic>>> readMessagesFromFirebase(
      String first, String second) {
    return _firebaseDB
        .collection("conversations/")
        .doc(first + " - " + second)
        .snapshots();
  }

  void cancelStreamSub() {
    streamSubscription.cancel();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getMessages(
      String currentUserID, String sohbetEdilenUserID) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> snapShots;
    if (sortUid(
            Message(
              sentFrom: currentUserID,
            ),
            sohbetEdilenUserID) ==
        -1) {
      snapShots = readMessagesFromFirebase(currentUserID, sohbetEdilenUserID);
    } else {
      snapShots = readMessagesFromFirebase(sohbetEdilenUserID, currentUserID);
    }
    streamSubscription = snapShots.listen((event) {
      event.toString();
    });

    return snapShots;
  }

  Future<void> getImage(int index, String sender, String reciever) async {
    ImagePicker imagePicker = new ImagePicker();
    imageFile = index == 0
        ? await imagePicker.getImage(source: ImageSource.gallery)
        : await imagePicker.getImage(source: ImageSource.camera);

    if (imageFile != null) {
      uploadFile(sender, reciever);
    }
  }

  Future<void> uploadFile(String sender, String reciever) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    await FlutterNativeImage.compressImage(imageFile.path,
        quality: 80, percentage: 90);
    await reference.putFile(File(imageFile.path));
    sendMessage(
        Message(
            sentFrom: sender,
            message: await reference.getDownloadURL(),
            date: DateTime.now().millisecondsSinceEpoch,
            type: 1),
        reciever);
  }
}
