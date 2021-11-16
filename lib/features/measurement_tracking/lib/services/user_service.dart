import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/repository/glucose_repository.dart';
import '../database/repository/profile_repository.dart';
import '../database/repository/scale_repository.dart';
import '../generated/l10n.dart';
import '../helper/workers.dart';
import '../models/firebase/add_firebase_body.dart';
import '../models/user/additional_info_model.dart';
import '../models/user/country.dart';
import '../models/user/usermodel.dart';
import '../models/user_profiles/person.dart';
import '../models/user_profiles/save_and_retrieve_token_model.dart';
import '../models/user_profiles/token_user_text_body.dart';
import '../notifiers/shared_preferences_handler.dart';
import '../notifiers/user_profiles_notifier.dart';
import '../pages/signup&login/token_provider.dart';
import '../widgets/utils/base_provider_repository.dart';
import 'base_provider.dart';
import 'repository_services.dart';

class UserService {
  String token = TokenProvider().authToken;
  Person person;
  static const String APPLICATION_CONSENT_FORM = "APPLICATION_CONSENT_FORM";
  Future<bool> hasIdentificationNumber(int entegrationId) async {
    final response = await BaseProvider.create(token)
        .userHasIdentificationNumber(entegrationId);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        return responseBody['datum'];
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  setApplicationConsentFormState(bool isChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked) {
      prefs.setBool(APPLICATION_CONSENT_FORM, true);
    } else {
      prefs.setBool(APPLICATION_CONSENT_FORM, false);
    }
  }

  getApplicationConsentFormState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(APPLICATION_CONSENT_FORM) != null) {
      return prefs.getBool(APPLICATION_CONSENT_FORM);
    } else {
      return false;
    }
  }

  Future<List<Country>> getAllCountry() async {
    final response = await BaseProvider.create(token).fetchAllCountry().timeout(
        new Duration(seconds: BaseProviderRepository.TIMEOUT_DURATION));
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        List<Country> countries = [];
        var body = responseBody['datum'];
        for (var data in body) {
          countries.add(Country.fromJson(data));
        }
        return countries;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<bool> addAdditionalInfo(
      AdditionalInfoModel additionalInfoModel, int entegrationId) async {
    final response = await BaseProvider.create(token)
        .addAdditionalInformation(additionalInfoModel, entegrationId);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        if (responseBody['datum'] == true) {
          return true;
        } else {
          throw Exception(responseBody['datum']);
        }
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<UserCredential> signInWithEmailAndPasswordFirebase(
      String email, String password) async {
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
      AuthCredential credential) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCred = await auth.signInWithCredential(credential);
      return userCred;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  saveAndRetrieveToken(User userCred, String from) async {
    print(from);
    String token = userCred.uid;
    String mailBase = userCred.email;
    TokenUserTextBody textBody = new TokenUserTextBody(
        id: userCred.uid, name: userCred.displayName, email: userCred.email);

    List<String> parts = mailBase.split("@");
    String firstPart = parts[0];
    String secondPart = parts[1];
    while (firstPart.length < 8) {
      firstPart = firstPart + "0";
    }
    String email = firstPart + "@" + secondPart;
    String encryptedTextBody = encryptWithSalsa20(jsonEncode(textBody.toJson()),
        firstPart.substring(0, 8)); // first 8 letters of the email

    final response = await BaseProvider.create(token).saveAndRetrieveToken(
        SaveAndRetrieveTokenModel(text: encryptedTextBody, mail: email));
    print(utf8.decode(response.bodyBytes));
    if (response.statusCode == HttpStatus.ok &&
        response.body['is_successful']) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      TokenProvider().setAuthToken(responseBody["datum"]["access_token"]);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw Exception(HttpStatus.unauthorized);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<AuthCredential> googleSignInService() async {
    try {
      bool isSignedIn = await GoogleSignIn().isSignedIn();
      if (isSignedIn) {
        await GoogleSignIn().disconnect();
      }

      final GoogleSignInAccount googleSignInAccount =
          await GoogleSignIn().signIn();
      print('hree');

      if (googleSignInAccount == null) {
        print("null googleSignInAccount");
        throw Exception("null googleSignInAccount");
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      if (googleSignInAuthentication == null) {
        print("null googleSignInAuthentication");
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

  selectedCountryCode(String locale) async {
    if (LocaleProvider.delegate.isSupported(Locale(locale.toLowerCase()))) {
      LocaleProvider lp =
          await LocaleProvider.delegate.load(Locale(locale.toLowerCase()));
      LocaleProvider.current = lp;
    }
  }

  OAuthCredential facebookSignInService(String result) {
    final credential = FacebookAuthProvider.credential(result);
    if (credential == null) {
      throw Exception("null credential");
    } else {
      return credential;
    }
  }

  addFirebaseToken() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((tokenFirebase) async {
      final response = await BaseProvider.create(token).addFirebaseToken(
          AddFirebaseToken(
              firebaseId: tokenFirebase,
              phoneInfo: await getDeviceInformation()));
      print("firebase token: " + tokenFirebase);
      print(response.statusCode);
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

  createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential == null)
        throw Exception("null credential");
      else {
        User user = FirebaseAuth.instance.currentUser;
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Person>> getAllProfile() async {
    BaseProvider _baseProvider = BaseProvider.create(TokenProvider().authToken);
    final response = await _baseProvider.getAllProfiles();

    if (response.statusCode == HttpStatus.ok) {
      var parsedBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (parsedBody['is_successful']) {
        return (parsedBody['datum'] as List)
            .map((item) => Person.fromJson(item))
            .toList();
      } else {
        throw Exception('get-all-profile isSuccessful:false');
      }
    } else {
      throw Exception('get-all-profile ${response.statusCode}');
    }
  }

  User checkFirebaseUser() {
    return FirebaseAuth.instance.currentUser;
  }

  handleAutoLogin(context) async {
    var userCred = checkFirebaseUser();

    if (userCred != null) {
      await handleCredential(userCred);
    } else {
      throw Exception('not-current-user');
    }
  }

  Future handleCredential(User userCred, {bool isSignUp = false}) async {
    try {
      await saveAndRetrieveToken(userCred, 'handleCred');
      if (isSignUp) {
        //TODO: this section will be refactored !!!
        await ProfileRepository().addProfile(new Person().fromDefault(), true);
      }
      await handleSuccessfulLogin(userCred);

      return UserModel(
          displayName: userCred.displayName,
          email: userCred.email,
          imageUrl: userCred.photoURL,
          userID: userCred.uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> handleSuccessfulLogin(
    User userCredential,
  ) async {
    try {
      var profiles = await getAllProfile();
      if (profiles.isEmpty) {
        throw Exception('SignUp');
      }
      person = profiles[0];
      await ProfileRepository().addProfile(person, false);
      print('hii');
      UserProfilesNotifier().selection = profiles[0];
      saveInformationForAutoLogin(userCredential);

      // token save process
      UserService().addFirebaseToken();
      // glucose REpo initialize process
      await GlucoseRepository().initialize();
      await ScaleRepository().initialize();

      //WARNING: Çoklu profil özelliği şuanlık askıya alındığı için sadece ilk profilden ilerlenecektir.
      var glucoseMeasurements =
          await RepositoryServices().getBloodGlucoseDataOfPerson(profiles[0]);

      //db save process
      if (glucoseMeasurements.isNotEmpty) {
        await GlucoseRepository().addNewGlucoseDataList(glucoseMeasurements);
      }
      await GlucoseRepository().getAllGlucoseData();
      await GlucoseRepository().getLatestMeasurement();
      await ScaleRepository().getAllScaleData();
      await ScaleRepository().getLatestMeasurement();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      Sentry.captureException(e, stackTrace: stk);
      print(e);
      print(e.toString().contains('SignUp'));
      if (e.toString().contains('SignUp')) {
        await handleCredential(userCredential, isSignUp: true);
      } else {
        throw Exception('handleSuccessfulLogin');
      }
    }
  }

  changeGender(String val) {}

  signOut() {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.signOut();
  }

  saveInformationForAutoLogin(User user) async {
    SharedPreferencesHandler().saveLastLoggedUserUid(user.uid);
    SharedPreferencesHandler().saveLastDisplayName(user.displayName ?? "");
    SharedPreferencesHandler().saveLastEmail(user.email);
  }

  deleteInformationForAutoLogin() async {
    //SharedPreferencesHandler().saveLastLoggedUserUid(null); // Algorithm works by detecting change so never remove uid
    SharedPreferencesHandler().deleteAutoLoginInfo();
  }
}

extension on AndroidDeviceInfo {
  String toJsonString() {
    Map<String, dynamic> jsonMap = new Map();
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
    Map<String, dynamic> jsonMap = new Map();
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
