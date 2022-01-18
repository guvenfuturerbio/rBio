import 'dart:developer';
import 'dart:io' as platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/src/provider.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';
import '../../../core/data/imports/cronic_tracking.dart';
import '../../../model/model.dart';
import '../../home/viewmodel/home_vm.dart';
import '../../shared/consent_form/consent_form_dialog.dart';
import '../../shared/kvkk_form/kvkk_form_screen.dart';
import '../auth.dart';

enum VersionCheckProgress { DONE, LOADING, ERROR }

class LoginScreenVm extends ChangeNotifier {
  BuildContext mContext;

  VersionCheckProgress _versionCheckProgress;

  ApplicationVersionResponse _applicationVersionResponse;

  bool _rememberMeChecked;

  RbioLoginResponse _guvenLogin;

  bool _needForceUpdate;

  UserLoginInfo _userLoginInfo;

  LoadingDialog loadingDialog;

  String _userId, _password;

  String _locale;

  bool _clickedGeneralForm;

  bool _checkedKvkk;

  bool _passwordVisibility;
  PackageInfo packageInfo;
  LoginScreenVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      fetchConsentFormState();
      await getSavedLoginInfo();
      //await startAppVersionOperation();
      //    packageInfo = await PackageInfo.fromPlatform();
    });
  }

  String get locale => this._locale ?? "";

  set clickedGeneralForm(bool value) {
    this._clickedGeneralForm = value;
    notifyListeners();
  }

  bool get clickedGeneralForm => this._clickedGeneralForm ?? false;

  set checkedKvkkForm(bool value) {
    this._checkedKvkk = value;
    notifyListeners();
  }

  bool get checkedKvkkForm => this._checkedKvkk ?? false;

  bool get passwordVisibility => this._passwordVisibility ?? false;

  void fetchConsentFormState() {
    this._clickedGeneralForm =
        getIt<UserManager>().getApplicationConsentFormState();
  }

  Future<void> fetchKvkkFormState() async {
    this._checkedKvkk = await getIt<UserManager>().getKvkkFormState();
  }

  toggleGeneralFormClick() {
    this._clickedGeneralForm = !clickedGeneralForm;
    if (clickedGeneralForm) {}
    notifyListeners();
  }

  Future<void> getSavedLoginInfo() async {
    var userLoginInfo = getIt<UserManager>().getSavedLoginInfo();
    this._userLoginInfo = userLoginInfo;
    if (userLoginInfo.password != null && userLoginInfo.password.length > 0) {
      this._rememberMeChecked = true;
    }
    setUserIdText(userLoginInfo.username);
    setPasswordText(userLoginInfo.password);
    notifyListeners();
    if ((userLoginInfo?.username ?? "").length > 0 &&
        (userLoginInfo?.password ?? "").length > 0) {
      await login(userLoginInfo.username, userLoginInfo.password);
    }
  }

  setUserIdText(String text) {
    this._userId = text;
  }

  String get userId => this._userId ?? "";

  setPasswordText(String text) {
    this._password = text;
  }

  String get password => this._password ?? "";

  UserLoginInfo get userLoginInfo => this._userLoginInfo ?? UserLoginInfo();

  Future<void> startAppVersionOperation() async {
    this._versionCheckProgress = VersionCheckProgress.LOADING;
    notifyListeners();
    try {
      if (!kIsWeb) {
        //await fetchAppVersion();
        //await checkAppVersion();
      } else {
        //autoLogin();
      }
      this._versionCheckProgress = VersionCheckProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._versionCheckProgress = VersionCheckProgress.ERROR;
      notifyListeners();
    }
  }

  VersionCheckProgress get versionCheckProgress =>
      this._versionCheckProgress ?? VersionCheckProgress.DONE;

  Future<void> fetchAppVersion() async {
    notifyListeners();
    try {
      await Future.delayed(Duration(seconds: 2));
      this._applicationVersionResponse =
          await getIt<Repository>().getCurrentApplicationVersion();
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      notifyListeners();
    }
  }

  Future<void> checkAppVersion() async {
    Version requiredMinVersion = Version.parse(applicationVersion.minimum);
    Version latestVersion = Version.parse(applicationVersion.latest);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Version currentVersion = Version.parse(packageInfo.version);

    if (requiredMinVersion > currentVersion) {
      this._needForceUpdate = true;
      notifyListeners();
      // force Update
      showCompulsoryUpdateDialog(
        context: mContext,
        onPressed: () {
          updateNow();
        },
        message: LocaleProvider.of(mContext).force_update_message +
            "\n${applicationVersion.name ?? ""}\n${applicationVersion.releaseNotes ?? ""}",
      );
    } else if (latestVersion > currentVersion) {
      this._needForceUpdate = false;
      notifyListeners();
      // optional update
      bool check = await isShowOptional();
      if (check) {
        showOptionalUpdateDialog(
          context: mContext,
          message: LocaleProvider.of(mContext).optional_update_message +
              "\n${applicationVersion.name ?? ""}\n${applicationVersion.releaseNotes ?? ""}",
          onPressed: () {
            updateNow();
          },
        );
      }
    } else {
      autoLogin();
    }
  }

  Future<void> autoLogin() async {
    this._needForceUpdate = false;
    notifyListeners();

    // app is up to date
    UserLoginInfo userLoginInfo =
        await getIt<UserManager>().getSavedLoginInfo();
  }

  bool get needForceUpdate => this._needForceUpdate ?? false;

  Future<void> login(String username, String password) async {
    if (checkFields(username, password)) {
      showLoadingDialog();

      try {
        // Roles and token
        this._guvenLogin = await getIt<UserManager>().login(username, password);

        await saveLoginInfo(username, password, guvenLogin.token.accessToken);

        List<dynamic> results = await Future.wait(
          [
            getIt<UserManager>().setApplicationConsentFormState(true),
            //One dose hasta bilgileri
            getIt<Repository>().getPatientDetail(),
            // Güven online kullanıcı bilgileri
            getIt<UserManager>().getUserProfile(),
            getIt<UserManager>().getKvkkFormState()
          ],
        );

        final patientDetail = results[1];
        this._checkedKvkk = results[3];

        if (getIt<UserNotifier>().isCronic) {
          var profiles =
              await getIt<ChronicTrackingRepository>().getAllProfiles();
          if (profiles.isNotEmpty) {
            await getIt<ProfileStorageImpl>().write(
              profiles.last,
              shouldSendToServer: false,
            );
          } else {
            await getIt<ProfileStorageImpl>().write(
              Person().fromDefault(
                name: patientDetail?.firstName ?? 'Name',
                lastName: patientDetail?.lastName ?? 'LastName',
                birthDate: patientDetail?.birthDate ?? '01.01.2000',
                gender: patientDetail?.gender ?? 'unsp',
              ),
              shouldSendToServer: true,
            );
          }
        }

        if (!Atom.isWeb) {
          var devices = await getIt<BleDeviceManager>().getPairedDevices();
          if (devices.isNotEmpty) {
            getIt<BleScannerOps>().startScan();
          }
        }

        // await getIt<SymptomRepository>().getSymtptomsApiToken();

        try {
          final profilImage = await getIt<Repository>().getProfilePicture();
          if (profilImage != null) {
            await getIt<ISharedPreferencesManager>().setString(
              SharedPreferencesKeys.PROFILE_IMAGE,
              profilImage,
            );
          }
        } catch (e) {
          //
        }

        final term = Atom.queryParameters['then'];
        if (term != null && term != '') {
          Atom.to(term, isReplacement: true);
        }

        final allUsersModel = getIt<UserNotifier>().checkUserExist(username);
        if (allUsersModel != null) {
          await getIt<ISharedPreferencesManager>().setStringList(
            SharedPreferencesKeys.DELETED_WIDGETS,
            allUsersModel.deletedWidgets,
          );
          await getIt<ISharedPreferencesManager>().setStringList(
            SharedPreferencesKeys.WIDGET_QUERY,
            allUsersModel.useWidgets,
          );
        }

        mContext.read<HomeVm>().init();

        await Future.delayed(Duration(milliseconds: 100));
        hideDialog(mContext);
        notifyListeners();

        Atom.to(PagePaths.MAIN, isReplacement: true);

        // MainNavigation.toHome(mContext);
      } catch (e, stackTrace) {
        Sentry.captureException(e, stackTrace: stackTrace);
        print(e);
        debugPrintStack(stackTrace: stackTrace);
        hideDialog(mContext);
        notifyListeners();
        if (e.toString().contains("401")) {
          showGradientDialog(
            mContext,
            LocaleProvider.current.warning,
            LocaleProvider.current.wrong_username_password,
          );
        } else if (e.toString().contains("400")) {
          Atom.to(
            PagePaths.FORGOT_PASSWORD_STEP_2,
            queryParameters: {'identityNumber': username},
          );
        } else {
          showGradientDialog(mContext, LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction);
        }
      }
    }
  }

  bool checkFields(String username, String password) {
    if (clickedGeneralForm) {
      if (username.length > 0 && password.length > 0) {
        return true;
      } else {
        showGradientDialog(mContext, LocaleProvider.current.warning,
            LocaleProvider.current.tc_or_pass_cannot_empty);
        return false;
      }
    } else {
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.approve_consent_form);
      return false;
    }
  }

  RbioLoginResponse get guvenLogin => this._guvenLogin;

  Future<void> saveLoginInfo(
      String userName, String password, String token) async {
    if (!rememberMeChecked) {
      password = "";
    }

    await getIt<UserManager>()
        .saveLoginInfo(userName, password, rememberMeChecked, token);
  }

  isShowOptional() async {
    bool showUpdates = false;
    showUpdates = getIt<ISharedPreferencesManager>()
        .getBool(SharedPreferencesKeys.UPDATE_DIALOG);
    if (showUpdates != null) {
      return showUpdates;
    } else {
      return true;
    }
  }

  updateNow() async {
    String applicationUrl = platform.Platform.isIOS
        ? applicationVersion.iosUrl
        : applicationVersion.androidUrl;
    bool urlActive = await canLaunch(applicationUrl);
    if (urlActive) {
      launch(applicationUrl);
    }
  }

  ApplicationVersionResponse get applicationVersion =>
      this._applicationVersionResponse;

  bool get rememberMeChecked => this._rememberMeChecked ?? false;

  void toggleRememberMeChecked() {
    this._rememberMeChecked = !rememberMeChecked;
    notifyListeners();
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    ).then(
      (value) {
        if (text == LocaleProvider.current.approve_consent_form) {
          showApplicationContestForm();
        } else if ((text == LocaleProvider.current.must_clicked_kvkk)) {
          showKvkkInfo();
        }
      },
    );
  }

  void showLoadingDialog() async {
    await showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
  }

  showApplicationContestForm() {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ConsentFormDialog(
            title: LocaleProvider.current.approve_consent_form,
            text: LocaleProvider.current.application_consent_form_text,
            alwaysAsk: false,
          );
        }).then((value) async {
      if (value != null && value) {
        this._clickedGeneralForm = true;
        notifyListeners();
      } else if (value != null && !value) {
        this._clickedGeneralForm = false;
        notifyListeners();
      }
    });
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  void showKvkkInfo() {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return KvkkFormScreen(
            title: LocaleProvider.current.kvkk_title,
            text: LocaleProvider.current.kvkk_url_text,
            alwaysAsk: true,
          );
        }).then((value) async {
      if (value != null && value) {
        this._checkedKvkk = true;
        notifyListeners();
      } else if (value != null && !value) {
        this._checkedKvkk = false;
        notifyListeners();
      }
    });
  }
}
