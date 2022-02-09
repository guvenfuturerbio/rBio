import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/helper/workers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/core.dart';
import '../../core/data/imports/cronic_tracking.dart';
import '../../model/firebase/add_firebase_body.dart';
import '../../model/user/usermodel.dart';
import '../../model/user_profiles/save_and_retrieve_token_model.dart';
import '../../model/user_profiles/token_user_text_body.dart';

class UserService {
  static const String applicationConsentForm = "APPLICATION_CONSENT_FORM";

  Future<void> setApplicationConsentFormState(bool isChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked) {
      await prefs.setBool(applicationConsentForm, true);
    } else {
      await prefs.setBool(applicationConsentForm, false);
    }
  }

  Future<bool> getApplicationConsentFormState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(applicationConsentForm) != null) {
      return prefs.getBool(applicationConsentForm) ?? false;
    } else {
      return false;
    }
  }

  Future<UserCredential> signInWithEmailAndPasswordFirebase(
    String email,
    String password,
  ) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCred;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserCredential> signInWithCredentialFirebase(
    AuthCredential credential,
  ) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCred = await auth.signInWithCredential(credential);
      return userCred;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> saveAndRetrieveToken(User userCred, String from) async {
    String token = userCred.uid;
    String mailBase = userCred.email ?? '';

    TokenUserTextBody textBody = TokenUserTextBody(
      id: 'gWTiiCR81Ib9a3p2UZWTCvAbRbc2',
      name: userCred.displayName,
      email: userCred.email,
    );

    List<String> parts = mailBase.split("@");
    String firstPart = parts[0];
    String secondPart = parts[1];
    while (firstPart.length < 8) {
      firstPart = firstPart + "0";
    }

    String email = firstPart + "@" + secondPart;
    String encryptedTextBody = encryptWithSalsa20(jsonEncode(textBody.toJson()),
        firstPart.substring(0, 8)); // first 8 letters of the email

    final response =
        await getIt<ChronicTrackingRepository>().saveAndRetrieveToken(
      SaveAndRetrieveTokenModel(
        token: encryptedTextBody,
        accession: email,
      ),
      token,
    );

    await getIt<ISharedPreferencesManager>().setString(
      SharedPreferencesKeys.jwtToken,
      response.datum["access_token"],
    );
  }

  /*Future<AuthCredential> googleSignInService() async {
    try {
      bool isSignedIn = await GoogleSignIn().isSignedIn();
      if (isSignedIn) {
        await GoogleSignIn().disconnect();
      }

      final GoogleSignInAccount googleSignInAccount =
          await GoogleSignIn().signIn();
      LoggerUtils.instance.i('hree');

      if (googleSignInAccount == null) {
        LoggerUtils.instance.i("null googleSignInAccount");
        throw Exception("null googleSignInAccount");
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      if (googleSignInAuthentication == null) {
        LoggerUtils.instance.i("null googleSignInAuthentication");
        throw Exception("null googleSignInAuthentication");
      }
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      if (credential != null) {
        return credential;
      } else {
        throw Exception("null credential");
      }
    } catch (_, stk) {
      debugPrintStack(stackTrace: stk);
      rethrow;
    }
  }
*/
  /*Future<OAuthCredential> appleSignInService() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    if (appleCredential == null) {
      throw ("null appleCredential");
    }

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    if (oauthCredential == null) {
      throw Exception("null oauthCredential");
    } else {
      return oauthCredential;
    }
  }*/

  //Last selected language code fetcher metho

  OAuthCredential facebookSignInService(String result) {
    final credential = FacebookAuthProvider.credential(result);
    return credential;
  }

  void addFirebaseToken() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((tokenFirebase) async {
      await getIt<ChronicTrackingRepository>().addFirebaseToken(
        AddFirebaseToken(
          firebaseId: tokenFirebase,
          phoneInfo: await getDeviceInformation(),
        ),
      );
    });
  }

  Future<String> getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.toJsonString();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.toJsonString();
    } else {
      throw Exception('getDeviceInfo');
    }
  }

  handleAutoLogin(context) async {
    var userCred = FirebaseAuth.instance.currentUser;

    if (userCred != null) {
      FirebaseAuth.instance.signOut();
      throw Exception('signout');
    } else {
      throw Exception('not-current-user');
    }
  }

  Future handleCredential(User userCred, {bool isSignUp = false}) async {
    try {
      await saveAndRetrieveToken(userCred, 'handleCred');
      if (isSignUp) {
        final displayName = FirebaseAuth.instance.currentUser?.displayName;
        await getIt<ProfileStorageImpl>().write(
          Person().fromDefault(name: displayName ?? ''),
          shouldSendToServer: true,
        );
      }
      await handleSuccessfulLogin(userCred);
      return UserModel(
        displayName: userCred.displayName,
        email: userCred.email,
        imageUrl: userCred.photoURL,
        userID: userCred.uid,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> handleSuccessfulLogin(User userCredential) async {
    try {
      var profiles = await getIt<ChronicTrackingRepository>().getAllProfiles();
      if (profiles.isEmpty) {
        throw Exception('SignUp');
      }

      Person person = profiles.last;
      await getIt<ProfileStorageImpl>().write(person, shouldSendToServer: true);
      // UserProfilesNotifier().selection = profiles[0];
      saveInformationForAutoLogin(userCredential);

      // token save process
      addFirebaseToken();
      // glucose REpo initialize process
      //await ScaleRepository().initialize();

      //WARNING: Çoklu profil özelliği şuanlık askıya alındığı için sadece ilk profilden ilerlenecektir.

      //await ScaleRepository().getAllScaleData();
      //await ScaleRepository().getLatestMeasurement();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      if (e.toString().contains('SignUp')) {
        await handleCredential(userCredential, isSignUp: true);
      } else {
        throw Exception('handleSuccessfulLogin');
      }
    }
  }

  void saveInformationForAutoLogin(User user) async {
    // SharedPreferencesHandler().saveLastLoggedUserUid(user.uid);
    // SharedPreferencesHandler().saveLastDisplayName(user.displayName ?? "");
    // SharedPreferencesHandler().saveLastEmail(user.email ?? '');
  }

  Future<void> deleteInformationForAutoLogin() async {
    //SharedPreferencesHandler().saveLastLoggedUserUid(null); // Algorithm works by detecting change so never remove uid
    // SharedPreferencesHandler().deleteAutoLoginInfo();
  }
}

extension on AndroidDeviceInfo {
  String toJsonString() {
    Map<String, dynamic> jsonMap = {};
    jsonMap.addAll({
      "android_id": androidId,
      "is_physical_device": isPhysicalDevice,
      "product": product,
      "model": model,
      "id": id,
      "host": host,
      "hardware": hardware,
      "fingerprint": fingerprint,
      "display": display,
      "device": device,
      "brand": brand,
      "bootloader": bootloader,
      "board": board,
      "base_os": version.baseOS,
      "release": version.release,
      "sdk_int": version.sdkInt
    });

    return jsonEncode(jsonMap);
  }
}

extension on IosDeviceInfo {
  String toJsonString() {
    Map<String, dynamic> jsonMap = {};
    jsonMap.addAll({
      "name": name,
      "systemName": systemName,
      "systemVersion": systemVersion,
      "model": model,
      "localizedModel": localizedModel,
      "identifierForVendor": identifierForVendor,
      "isPhysicalDevice": isPhysicalDevice,
      "sysname": utsname.sysname,
      "nodename": utsname.nodename,
      "release": utsname.release,
      "version": utsname.version,
      "machine": utsname.machine
    });

    return jsonEncode(jsonMap);
  }
}
