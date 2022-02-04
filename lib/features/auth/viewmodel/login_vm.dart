import 'dart:io' as platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
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

enum VersionCheckProgress { done, loading, error }

class LoginScreenVm extends ChangeNotifier {
  BuildContext mContext;

  LoginScreenVm(this.mContext) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      fetchConsentFormState();
      await getSavedLoginInfo();
    });
  }

  String locale = "";
  LoadingDialog? loadingDialog;

  ApplicationVersionResponse? _applicationVersionResponse;
  ApplicationVersionResponse? get applicationVersion =>
      _applicationVersionResponse;

  RbioLoginResponse? _guvenLogin;
  RbioLoginResponse? get guvenLogin => _guvenLogin;

  bool _needForceUpdate = false;
  bool get needForceUpdate => _needForceUpdate;

  VersionCheckProgress get versionCheckProgress => _versionCheckProgress;
  VersionCheckProgress _versionCheckProgress = VersionCheckProgress.done;

  bool _rememberMeChecked = false;
  bool get rememberMeChecked => _rememberMeChecked;
  void toggleRememberMeChecked() {
    _rememberMeChecked = !rememberMeChecked;
    notifyListeners();
  }

  String _userId = "", _password = "";
  String get userId => _userId;
  void setUserIdText(String text) {
    _userId = text;
  }

  String get password => _password;
  void setPasswordText(String text) {
    _password = text;
  }

  bool _passwordVisibility = false;
  bool get passwordVisibility => _passwordVisibility;
  void togglePasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  bool _clickedGeneralForm = false;
  bool get clickedGeneralForm => _clickedGeneralForm;
  set clickedGeneralForm(bool value) {
    clickedGeneralForm = value;
    notifyListeners();
  }

  bool _checkedKvkk = false;
  bool get checkedKvkkForm => _checkedKvkk;
  set checkedKvkkForm(bool value) {
    _checkedKvkk = value;
    notifyListeners();
  }

  void fetchConsentFormState() {
    _clickedGeneralForm = getIt<UserManager>().getApplicationConsentFormState();
  }

  Future<void> fetchKvkkFormState() async {
    _checkedKvkk = await getIt<UserManager>().getKvkkFormState();
  }

  void toggleGeneralFormClick() {
    _clickedGeneralForm = !clickedGeneralForm;
    if (clickedGeneralForm) {}
    notifyListeners();
  }

  Future<void> getSavedLoginInfo() async {
    var userLoginInfo = getIt<UserManager>().getSavedLoginInfo();
    if (userLoginInfo.password != null &&
        (userLoginInfo.password?.length ?? 0) > 0) {
      _rememberMeChecked = true;
    }

    setUserIdText(userLoginInfo.username ?? '');
    setPasswordText(userLoginInfo.password ?? '');
    notifyListeners();

    if ((userLoginInfo.username ?? "").isNotEmpty &&
        (userLoginInfo.password ?? "").isNotEmpty) {
      await login(userLoginInfo.username ?? '', userLoginInfo.password ?? '');
    }
  }

  Future<void> startAppVersionOperation() async {
    _versionCheckProgress = VersionCheckProgress.loading;
    notifyListeners();
    try {
      if (!kIsWeb) {
        //await fetchAppVersion();
        //await checkAppVersion();
      } else {
        //autoLogin();
      }
      _versionCheckProgress = VersionCheckProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      _versionCheckProgress = VersionCheckProgress.error;
      notifyListeners();
    }
  }

  Future<void> fetchAppVersion() async {
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 2));
      _applicationVersionResponse =
          await getIt<Repository>().getCurrentApplicationVersion();
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      notifyListeners();
    }
  }

  Future<void> checkAppVersion() async {
    Version requiredMinVersion =
        Version.parse(applicationVersion?.minimum ?? '');
    Version latestVersion = Version.parse(applicationVersion?.latest ?? '');

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Version currentVersion = Version.parse(packageInfo.version);

    if (requiredMinVersion > currentVersion) {
      _needForceUpdate = true;
      notifyListeners();
      // force Update
      showCompulsoryUpdateDialog(
        context: mContext,
        onPressed: () {
          updateNow();
        },
        message: LocaleProvider.of(mContext).force_update_message +
            "\n${applicationVersion?.name ?? ""}\n${applicationVersion?.releaseNotes ?? ""}",
      );
    } else if (latestVersion > currentVersion) {
      _needForceUpdate = false;
      notifyListeners();
      // optional update
      bool check = isShowOptional();
      if (check) {
        showOptionalUpdateDialog(
          context: mContext,
          message: LocaleProvider.of(mContext).optional_update_message +
              "\n${applicationVersion?.name ?? ""}\n${applicationVersion?.releaseNotes ?? ""}",
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
    _needForceUpdate = false;
    notifyListeners();
    getIt<UserManager>().getSavedLoginInfo();
  }

  Future<void> login(String username, String password) async {
    if (checkFields(username, password)) {
      showLoadingDialog();

      try {
        // Roles and token
        _guvenLogin = await getIt<UserManager>().login(username, password);
        await saveLoginInfo(
            username, password, guvenLogin?.token?.accessToken ?? '');
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
        _checkedKvkk = results[3];

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
          await getIt<ISharedPreferencesManager>().setString(
            SharedPreferencesKeys.profileImage,
            profilImage,
          );
        } catch (e) {
          //
        }

        final term = Atom.queryParameters['then'];
        if (term != null && term != '') {
          Atom.to(term, isReplacement: true);
        }
        final allUsersModel = getIt<UserNotifier>().getHomeWidgets(username);
        if (allUsersModel != null) {
          mContext.read<HomeVm>().init(allUsersModel);
        }
        await Future.delayed(const Duration(milliseconds: 100));
        hideDialog(mContext);
        notifyListeners();
        Atom.to(PagePaths.main, isReplacement: true);
      } catch (e, stackTrace) {
        Sentry.captureException(e, stackTrace: stackTrace);
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
            PagePaths.forgotPasswordStep2,
            queryParameters: {'identityNumber': username},
          );
        } else {
          showGradientDialog(
            mContext,
            LocaleProvider.current.warning,
            LocaleProvider.current.sorry_dont_transaction,
          );
        }
      }
    }
  }

  bool checkFields(String username, String password) {
    if (clickedGeneralForm) {
      if (username.isNotEmpty && password.isNotEmpty) {
        return true;
      } else {
        showGradientDialog(
          mContext,
          LocaleProvider.current.warning,
          LocaleProvider.current.tc_or_pass_cannot_empty,
        );
        return false;
      }
    } else {
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.approve_consent_form,
      );
      return false;
    }
  }

  Future<void> saveLoginInfo(
      String userName, String password, String token) async {
    if (!rememberMeChecked) {
      password = "";
    }

    await getIt<UserManager>()
        .saveLoginInfo(userName, password, rememberMeChecked, token);
  }

  bool isShowOptional() {
    final showUpdates = getIt<ISharedPreferencesManager>()
        .getBool(SharedPreferencesKeys.updateDialog);
    if (showUpdates != null) {
      return showUpdates;
    } else {
      return true;
    }
  }

  Future<void> updateNow() async {
    String applicationUrl = platform.Platform.isIOS
        ? (applicationVersion?.iosUrl ?? '')
        : (applicationVersion?.androidUrl ?? '');
    bool urlActive = await canLaunch(applicationUrl);
    if (urlActive) {
      launch(applicationUrl);
    }
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
        _clickedGeneralForm = true;
        notifyListeners();
      } else if (value != null && !value) {
        _clickedGeneralForm = false;
        notifyListeners();
      }
    });
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null) {
      if (loadingDialog!.isShowing()) {
        Navigator.of(context).pop();
        loadingDialog = null;
      }
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
        _checkedKvkk = true;
        notifyListeners();
      } else if (value != null && !value) {
        _checkedKvkk = false;
        notifyListeners();
      }
    });
  }
}
