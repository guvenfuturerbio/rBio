import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/locator.dart';
import 'package:onedosehealth/models/chat/message.dart';
import 'package:http/http.dart' as http;
import 'package:onedosehealth/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/pages/chat/patient_id_holder.dart';

class ChatController with ChangeNotifier {
  UserProfilesNotifier userProfilesNotifier = locator<UserProfilesNotifier>();
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;
  PickedFile imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;
  List<Message> messages;
  Future<bool> sendMessage(Message message) async {
    var _kaydedilecekMesajMapYapisi = message.toMap();
    await _firebaseDB
        .collection("conversations")
        .doc(message.sentFrom)
        .collection(message.sentTo)
        .doc()
        .set(_kaydedilecekMesajMapYapisi);
    print(message.sentTo);
    print(message.sentFrom);

    await _firebaseDB
        .collection("conversations")
        .doc(message.sentTo)
        .collection(message.sentFrom)
        .doc()
        .set(_kaydedilecekMesajMapYapisi);
    sendNotification(message);
    return true;
  }

  Future<bool> sendNotification(Message message) async {
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
  }

  Stream<List<Message>> getMessages(
      String currentUserID, String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("conversations")
        .doc(currentUserID)
        .collection(sohbetEdilenUserID)
        .orderBy("date", descending: true)
        .snapshots();
    return snapShot.map((mesajListesi) => mesajListesi.docs
        .map((mesaj) => Message.fromMap(mesaj.data()))
        .toList());
  }

  Future getImage(int index, String sender, String reciever) async {
    ImagePicker imagePicker = new ImagePicker();
    imageFile = index == 0
        ? await imagePicker.getImage(source: ImageSource.gallery)
        : await imagePicker.getImage(source: ImageSource.camera);

    if (imageFile != null) {
      uploadFile(sender, reciever);
    }
  }

  Future uploadFile(String sender, String reciever) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    var compressedFile = await FlutterNativeImage.compressImage(imageFile.path,
        quality: 80, percentage: 90);
    var uploadTask = await reference.putFile(File(imageFile.path));
    sendMessage(Message(
        sentFrom: sender,
        sentTo: reciever,
        message: await reference.getDownloadURL(),
        type: 1));
  }
}
