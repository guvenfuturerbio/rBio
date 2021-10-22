import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

enum LoadingStatus { done, loading }

class AccountScreenVm with ChangeNotifier {
  LoadingStatus status = LoadingStatus.loading;
  BuildContext context;
  AccountScreenVm(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadLocaleIfStored();
      await _fetchDetails();
    });
  }
  LoadingDialog loadingDialog;
  UserAccount userAccount;

  static const String DID_COMPLETE_SURVEY_KEY = "DID_COMPLETE_SURVEY";
  static const String LOGIN_PASSWORD_PREFS_KEY = "LOGIN_PASSWORD";
  bool isLocaleChecked = false;
  String currentLocale = "en";
  Uint8List imageBytes;
  bool isYoutubeVisible = false;
  String youtubeWatchId = "";
  String courseId = "";
  String courseName = "";
  String _token;
  String mobileFilePath = '';

  // LOCALE CHANGER
  Future<void> loadLocaleIfStored() async {
    if (!isLocaleChecked) {
      String current = getIt<ISharedPreferencesManager>()
          .getString(SharedPreferencesKeys.SELECTED_LOCALE);
      if (current != null) {
        print('Current locale = $current.');
        changeCountryCode(current);
        currentLocale = current.toUpperCase();
      } else {
        currentLocale = Intl.getCurrentLocale().toLowerCase();
        changeCountryCode(currentLocale);
      }
      isLocaleChecked = true;
    }
    notifyListeners();
  }

  Future<void> _fetchDetails() async {
    final token =
        getIt<ISharedPreferencesManager>().get(SharedPreferencesKeys.JWT_TOKEN);
    _token = token;
    try {
      userAccount = await getIt<Repository>().getUserProfile();
      await getActiveStream();

      if (kIsWeb) {
        await getProfilePictureWeb();
      } else {
        await getProfilePicturePhone();
      }

      status = LoadingStatus.done;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print(e.toString());
      showGradientDialog(
          context, "Error", LocaleProvider.of(context).no_network_connection);
    }
  }

  Future<void> getActiveStream() async {
    final response = await getIt<Repository>().getActiveStream();
    try {
      youtubeWatchId = response["id"];
      isYoutubeVisible = response["visible"];
      notifyListeners();
      final courseResponse = await getIt<Repository>().getCourseId();
      var courseDatum = courseResponse.datum;
      courseId = courseDatum["id"];
      courseName = courseDatum["name"];
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return;
    }
  }

  void getProfilePicturePhone() async {
    imageCache.clearLiveImages();
    imageCache.clear();

    var bytes;

    try {
      final response = await getIt<Repository>().getProfilePicture();
      bytes = base64.decode(response);
      final fileName = "profile_picture_guvenonline";
      final dir = (await getApplicationDocumentsDirectory()).path;
      final file = new File('$dir/$fileName');
      await file.writeAsBytes(bytes);
      mobileFilePath = file.path;
      notifyListeners();
    } catch (_) {
      bytes = base64.decode(
          '''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''');
      final fileName = "profile_picture_guvenonline";
      final dir = (await getApplicationDocumentsDirectory()).path;
      final file = new File('$dir/$fileName');
      await file.writeAsBytes(bytes);
      mobileFilePath = file.path;
      notifyListeners();
    }
  }

  void changeCountryCode(String locale) async {
    print("CHANGING LOCALE TO " + locale);
    if (LocaleProvider.delegate.isSupported(Locale(locale.toLowerCase()))) {
      LocaleProvider.delegate.load(Locale(locale.toLowerCase()));
      currentLocale = locale.toUpperCase();
      await getIt<ISharedPreferencesManager>().setString(
          SharedPreferencesKeys.SELECTED_LOCALE, locale.toLowerCase());
    } else {
      showGradientDialog(
          context,
          LocaleProvider.of(context).unsupported_language,
          LocaleProvider.of(context).select_another_language);
    }
    notifyListeners();
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(title, text);
      },
    );
  }

  void navigateToYoutubeViewer(BuildContext context) async {
    if (youtubeWatchId != "") {
      bool didCompleteSurvey = getIt<ISharedPreferencesManager>()
              .getBool(SharedPreferencesKeys.DID_COMPLETE_SURVEY) ??
          false;

      Atom.to(
        kIsWeb ? PagePaths.YOUTUBEVIEWERWEB : PagePaths.YOUTUBEVIEWERMOBILE,
        queryParameters: {
          'url': youtubeWatchId,
          'courseId': Uri.encodeFull(courseId),
          'courseName': Uri.encodeFull(courseName),
          'didCompleteSurvey': didCompleteSurvey.toString()
        },
      );
    }
  }

  void showLoadingDialog(BuildContext context) async {
    await Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  Future<void> logout(BuildContext context) async {
    await getIt<ISharedPreferencesManager>()
        .remove(SharedPreferencesKeys.LOGIN_PASSWORD);
    await getIt<ISharedPreferencesManager>()
        .remove(SharedPreferencesKeys.JWT_TOKEN);
    await getIt<ISharedPreferencesManager>()
        .remove(SharedPreferencesKeys.PATIENT);
    AnalyticsManager().sendEvent(LogoutEvent());
    Atom.to(PagePaths.LOGIN, isReplacement: true);
  }

  Future changeUserToDefault(BuildContext context) async {
    showLoadingDialog(context);
    try {
      final response = await getIt<Repository>().getRelativeRelationships();
      var user_id = response.datum["id"];
      await getIt<Repository>().changeActiveUserToRelative(user_id.toString());
      hideDialog(context);
      AnalyticsManager().sendEvent(ChangeToDefaultFromRelativeSuccessEvent());
      Atom.to(PagePaths.MAIN, isReplacement: true, historyState: {});
      return;
    } on Exception {
      AnalyticsManager().sendEvent(ChangeToDefaultFromRelativeFailEvent());
      showGradientDialog(context, LocaleProvider.of(context).warning,
          LocaleProvider.of(context).sorry_dont_transaction);
    }

    hideDialog(context);
    Navigator.pop(context);
  }

  Future<void> getProfilePictureWeb() async {
    imageCache.clearLiveImages();
    imageCache.clear();

    try {
      final response = await getIt<Repository>().getProfilePicture();
      imageBytes = base64.decode(response);
      notifyListeners();
    } catch (_) {
      imageBytes = base64.decode(
          '''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''');
      notifyListeners();
    }
  }
}
