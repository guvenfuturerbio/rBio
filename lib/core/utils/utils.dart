// ignore_for_file: prefer_equal_for_default_values

import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:path/path.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../features/shared/do_not_show_again_dialog.dart';

import '../../model/model.dart';
import '../core.dart';
import '../widgets/rbio_height_info_dialog.dart';

class Utils {
  Utils._();

  static Utils? _instance;

  static Utils get instance {
    return _instance ??= Utils._();
  }

  String? get getCacheProfileImageStr => getIt<ISharedPreferencesManager>()
      .getString(SharedPreferencesKeys.profileImage);
  ImageProvider<Object> get getCacheProfileImage {
    if (getCacheProfileImageStr != null) {
      return MemoryImage(base64.decode(getCacheProfileImageStr!));
    } else {
      return NetworkImage(R.image.circlevatar);
    }
  }

  /// * device_listing_screen.dart'da "DeviceType.miScale" kontrol ediyorum.
  ///
  /// * scale_manuel_add_cubit.dart'da kontrol ediyorum, yoksa "Kaydet" butonunu disable yapıyorum.
  bool checkUserHeight([bool backRoute = false]) {
    final height = getHeight();
    if (height == null) {
      return true;
    } else {
      Atom.show(RbioHeightInfoDialog(backRoute: backRoute));
      return false;
    }
  }

  int? getHeight() {
    final height = getIt<ProfileStorageImpl>().getFirst().height;
    return height == null ? null : int.tryParse(height);
  }

  int getGender() {
    return getIt<ProfileStorageImpl>().getFirst().gender == 'Male' ||
            getIt<ProfileStorageImpl>().getFirst().gender == 'Erkek'
        ? 1
        : 0;
  }

  Gradient appGradient() => LinearGradient(
        colors: [
          getIt<IAppConfig>().theme.mainColor,
          getIt<IAppConfig>().theme.mainColor,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
      );

  int getAge() {
    final List<String> nums =
        getIt<ProfileStorageImpl>().getFirst().birthDate!.split(".");
    final yearOfBirth = int.parse(nums[2]);
    return DateTime.now().year - yearOfBirth < 15
        ? 15
        : DateTime.now().year - yearOfBirth;
  }

  void showSnackbar(
    BuildContext context,
    String text, {
    Color? backColor,
    Widget? trailing,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backColor,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            Expanded(
              child: Text(
                text,
                style: context.xHeadline3.copyWith(
                  color: getIt<IAppConfig>().theme.textColor,
                ),
              ),
            ),

            //
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  // #region showSuccessSnackbar
  void showSuccessSnackbar(BuildContext context, String text) {
    showSnackbar(
      context,
      text,
      backColor: getIt<IAppConfig>().theme.mainColor,
      trailing: SvgPicture.asset(
        R.image.done,
        height: R.sizes.iconSize2,
        color: getIt<IAppConfig>().theme.iconSecondaryColor,
      ),
    );
  }
  // #endregion

  // #region showErrorSnackbar
  void showErrorSnackbar(BuildContext context, String text) {
    showSnackbar(
      context,
      text,
      backColor: getIt<IAppConfig>().theme.darkRed,
      trailing: SvgPicture.asset(
        R.image.error,
        height: R.sizes.iconSize2,
        color: getIt<IAppConfig>().theme.iconSecondaryColor,
      ),
    );
  }
  // #endregion

  String encryptWithSalsa20(String plainText, String email) {
    //final key = encrypt.Key.fromLength(32);
    final ivMail = email.substring(0, 8);
    final key = encrypt.Key.fromUtf8("+@rzf7>5(/pP`S4<K&.=*~6=;.~**Mm=");
    final iv = encrypt.IV.fromUtf8(ivMail);
    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    LoggerUtils.instance.i(
        decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    LoggerUtils.instance.i(encrypted
        .base64); // CR+IAWBEx3sA/dLkkFM/orYr9KftrGa7lIFSAAmVPbKIOLDOzGwEi9ohstDBqDLIaXMEeulwXQ==
    return encrypted.base64;
    //String text = "{\"Id\":\"RiHgVRsWeNVZhpX3u9ZvZBgyD0n1\",\"NameSurname\":\"Can Avcı\",\"ElectronicMail\":\"canavci95@hotmail.com\"}"
  }

  Map<String, dynamic> parseJwtPayLoad(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Future<TimeOfDay?> openMaterialTimePicker(
    BuildContext context,
    TimeOfDay timeOfDay,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: getIt<IAppConfig>().theme.mainColor,
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      initialTime: timeOfDay,
      initialEntryMode: TimePickerEntryMode.input,
    );
    return picked;
  }

  // #region hideKeyboard
  void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
  // #endregion

  // #region hideKeyboardWithoutContext
  void hideKeyboardWithoutContext() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  // #endregion

  // #region forcePortraitOrientation
  void forcePortraitOrientation() {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: SystemUiOverlay.values);
  }
  // #endregion

  void releaseOrientation() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  // #region getCacheApiCallList
  Future<List<T>> getCacheApiCallList<T extends IBaseModel>(
    String url,
    Future<List<T>> Function() apiCall,
    Duration cacheDuration,
    T model,
    LocalCacheService localCacheService, {
    bool localeHandle = false,
  }) async {
    final cacheUrl = url +
        (localeHandle
            ? '/${getIt<ISharedPreferencesManager>().getString(SharedPreferencesKeys.selectedLocale)}'
            : '');

    String localData;
    try {
      localData = await localCacheService.get(cacheUrl);
      final localModel = json.decode(localData);
      if (localModel is List) {
        return localModel.map((e) => model.fromJson(e)).cast<T>().toList();
      }
      return [];
    } catch (e, stackTrace) {
      final apiData = await apiCall();
      await localCacheService.write(
          cacheUrl, json.encode(apiData), cacheDuration);
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return apiData;
    }
  }
  // #endregion

  // #region getCacheApiCallModel
  Future<T> getCacheApiCallModel<T extends IBaseModel>(
    String url,
    Future<T> Function() apiCall,
    Duration cacheDuration,
    T model,
    LocalCacheService localCacheService, {
    bool localeHandle = false,
  }) async {
    final cacheUrl = url +
        (localeHandle
            ? '/${getIt<ISharedPreferencesManager>().getString(SharedPreferencesKeys.selectedLocale)}'
            : '');
    String localData;

    try {
      localData = await localCacheService.get(cacheUrl);
      final localModel = json.decode(localData);
      if (localModel is Map) {
        return model.fromJson(localModel as Map<String, dynamic>);
      }

      throw Exception('getCacheApiCallModel : ${model.runtimeType}');
    } catch (e, stackTrace) {
      final apiData = await apiCall();
      await localCacheService.write(
          cacheUrl, json.encode(apiData), cacheDuration);
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return apiData;
    }
  }
  // #endregion

  // chronic_tracking
  DeviceType getDeviceType(DiscoveredDevice device) {
    if (device.name == 'MIBFS' &&
        device.serviceData.length == 1 &&
        device.serviceData.values.first.length == 13) {
      return DeviceType.miScale;
    } else if (device.manufacturerData[0] == 112) {
      return DeviceType.accuCheck;
    } else if (device.manufacturerData[0] == 103) {
      return DeviceType.contourPlusOne;
    }

    throw Exception('Nondefined device');
  }

  InputDecoration inputImageDecoration({
    String? image,
    String? hintText,
    required Function suffixIconClicked,
    Widget? suffixIcon,
  }) =>
      InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: image != null
            ? SvgPicture.asset(
                image,
                fit: BoxFit.none,
              )
            : const Icon(Icons.close),
        focusedBorder: _borderTextField(),
        border: _borderTextField(),
        focusColor: getIt<IAppConfig>().theme.mainColor,
        suffixIcon: Visibility(
          visible: suffixIcon != null ? true : false,
          child: InkWell(
            onTap: () {
              suffixIconClicked();
            },
            child: suffixIcon ??
                const SizedBox(
                  width: 0,
                ),
          ),
        ),
        enabledBorder: _borderTextField(),
        hintText: hintText,
        hintStyle: hintStyle(),
      );

  TextStyle inputTextStyle([Color? textColor]) => TextStyle(
        fontSize: 16,
        color: textColor ?? getIt<IAppConfig>().theme.darkBlack,
      );

  TextStyle hintStyle() =>
      TextStyle(fontSize: 16, color: getIt<IAppConfig>().theme.gray);

  GradientButton button({
    text: String,
    required Function() onPressed,
    double height = 16,
    double width = 200,
  }) =>
      GradientButton(
        increaseHeightBy: height,
        increaseWidthBy: width,
        elevation: 0,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: getIt<IAppConfig>().theme.white),
        ),
        textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: getIt<IAppConfig>().theme.white),
        callback: onPressed,
        gradient: appGradient(),
        shadowColor: Colors.black,
      );

  GradientButton passiveButton({
    text: String,
    required Function onPressed,
    double height = 16,
    double width = 200,
  }) =>
      GradientButton(
        callback: onPressed(),
        increaseWidthBy: width,
        increaseHeightBy: height,
        shadowColor: Colors.black.withAlpha(50),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: getIt<IAppConfig>().theme.grey,
        ),
        gradient: LinearGradient(
          colors: [
            getIt<IAppConfig>().theme.mainColor.withAlpha(15),
            getIt<IAppConfig>().theme.mainColor.withAlpha(15)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
      );

  InputDecoration inputDecorationForLogin({
    String? hintText,
    String? labelText,
    EdgeInsetsGeometry? contentPadding,
    InputBorder? inputBorder,
    Widget? prefixIcon,
  }) =>
      InputDecoration(
        contentPadding: contentPadding ??
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        focusedBorder: inputBorder,
        border: inputBorder,
        enabledBorder: inputBorder,
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        hintStyle: Atom.context.xHeadline4.copyWith(
          color: getIt<IAppConfig>().theme.textColorPassive,
        ),
      );

  Widget customCircleAvatar({
    double size = 50,
    Widget? child,
    BoxDecoration? decoration,
  }) =>
      Container(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: child,
        ),
        decoration: decoration,
      );

  String clearDoctorTitle(String text) {
    if (text.contains('dr.')) {
      return text.split('dr.')[1];
    } else {
      return text;
    }
  }

  Color fetchMeasurementColor({
    required int measurement,
    required int criticMin,
    required int criticMax,
    required int targetMax,
    required int targetMin,
  }) {
    Color color;
    if (measurement <= criticMin) {
      color = getIt<IAppConfig>().theme.veryLow;
    } else if (measurement > criticMin && measurement < targetMin) {
      color = getIt<IAppConfig>().theme.low;
    } else if (measurement >= targetMin && measurement <= targetMax) {
      color = getIt<IAppConfig>().theme.target;
    } else if (measurement > targetMax && measurement < criticMax) {
      color = getIt<IAppConfig>().theme.high;
    } else if (measurement >= criticMax) {
      color = getIt<IAppConfig>().theme.veryHigh;
    } else {
      color = Colors.white;
    }
    return color;
  }

  InputBorder _borderTextField() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(200),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.solid,
          color: getIt<IAppConfig>().theme.darkWhite,
        ),
      );

  Widget titleAppBarWhite({String? title}) => Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text(
          title ?? "No title",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      );

  Widget mainAppBar({
    required BuildContext context,
    Widget? leading,
    Widget? title,
    List<Widget>? actions,
    Widget? bottom,
  }) =>
      PreferredSize(
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: leading ?? const SizedBox(),
                  left: 0,
                ),
                Center(
                  child: title == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: title,
                        ),
                ),
                Positioned(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions ?? [],
                  ),
                  right: 0,
                )
              ],
            ),
            decoration: BoxDecoration(gradient: appGradient()),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 50.0));

  String getFormattedDateWithTime(String date) =>
      DateTime.parse(date).xFormatTime3();

  String? validateIdentificationNumber(String? identificationNum) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');

    if ((identificationNum ?? "").isEmpty) {
      return LocaleProvider.current.need_identification_number;
    } else if (!regex.hasMatch(identificationNum ?? "")) {
      return LocaleProvider.current.identification_match_problem;
    } else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    RegExp hasUpper = RegExp(r'[A-Z]');
    RegExp hasLower = RegExp(r'[a-z]');
    RegExp hasDigit = RegExp(r'\d');
    RegExp hasPunct = RegExp(r'[_!@#\$()!+%.,$€₺&*~-]');

    if (!hasUpper.hasMatch(password ?? "")) {
      return LocaleProvider.current.must_contain_uppercase;
    }
    if (!hasLower.hasMatch(password ?? "")) {
      return LocaleProvider.current.must_contain_lowercase;
    }
    if (!hasDigit.hasMatch(password ?? "")) {
      return LocaleProvider.current.must_contain_digit;
    }
    if (!hasPunct.hasMatch(password ?? "")) {
      return LocaleProvider.current.must_contain_special;
    }
    if (!RegExp(r'.{8,}').hasMatch(password ?? "")) {
      return LocaleProvider.current.password_must_8_char;
    }

    return null;
  }
}

/// Page Irrelevant operations
class UtilityManager {
  static final UtilityManager _instance = UtilityManager._internal();

  factory UtilityManager() {
    return _instance;
  }

  UtilityManager._internal();

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    if (nextFocus == null) {
      return;
    } else {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  void showConfirmationAlertDialog(
    BuildContext context,
    String title,
    String text,
    Widget okButton,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GuvenAlert(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          actions: [
            okButton,
          ],
          content: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getReadableTimeFromDateTime(DateTime measureDT) {
    return "${measureDT.hour > 9 ? measureDT.hour : "0" + measureDT.hour.toString()}:${measureDT.minute > 9 ? measureDT.minute : "0" + measureDT.minute.toString()}  ${measureDT.day}.${measureDT.month}.${measureDT.year}";
  }

  String getReadableHour(DateTime measureDT) {
    return "${measureDT.hour > 9 ? measureDT.hour : "0" + measureDT.hour.toString()}:${measureDT.minute > 9 ? measureDT.minute : "0" + measureDT.minute.toString()}";
  }

  String getReadableDate(DateTime measureDT) {
    return "${measureDT.day}/${measureDT.month}/${measureDT.year}";
  }

  /// MG14
  Color getGlucoseMeasurementColor(int result) {
    Person activeProfile = getIt<ProfileStorageImpl>().getFirst();

    if (result < activeProfile.hypo!) {
      return getIt<IAppConfig>().theme.veryLow;
    } else if (result >= activeProfile.hypo! &&
        result < activeProfile.rangeMin!) {
      return getIt<IAppConfig>().theme.low;
    } else if (result >= activeProfile.rangeMin! &&
        result < activeProfile.rangeMax!) {
      return getIt<IAppConfig>().theme.target;
    } else if (result >= activeProfile.rangeMax! &&
        result < activeProfile.hyper!) {
      return getIt<IAppConfig>().theme.high;
    } else {
      return getIt<IAppConfig>().theme.veryHigh;
    }
  }

  Widget? getDeviceImage(int deviceId) {
    switch (deviceId) {
      case 87:
        return Image.asset(R.image.miScale);

      case 103:
        return Image.asset(R.image.contour);

      case 112:
        return Image.asset(R.image.accuCheckPng);

      default:
        return null;
    }
  }

  Widget? getDeviceImageFromType(DeviceType device) {
    switch (device) {
      case DeviceType.miScale:
        return Image.asset(R.image.miScale);

      case DeviceType.contourPlusOne:
        return Image.asset(R.image.contour);

      case DeviceType.accuCheck:
        return Image.asset(R.image.accuCheckPng);

      default:
        return null;
    }
  }

  String? getDeviceImageStringFromType(DeviceType device) {
    switch (device) {
      case DeviceType.miScale:
        return R.image.miScale;

      case DeviceType.contourPlusOne:
        return R.image.contour;

      case DeviceType.accuCheck:
        return R.image.accuCheckPng;
      default:
        return null;
    }
  }

  String getDeviceName(int deviceId) {
    switch (deviceId) {
      case 103:
        return "Contour Plus";

      case 112:
        return "ACCU-CHEK";

      default:
        return "";
    }
  }
}

String getHospitalName(BuildContext context, PatientAppointmentsResponse data) {
  if (data.type == R.constants.onlineAppointmentType) {
    return (LocaleProvider.current.online_appo);
  } else if (data.tenantId == R.constants.tenantAyranciId) {
    return (LocaleProvider.current.guven_hospital_ayranci);
  } else if (data.tenantId == R.constants.tenantCayyoluId) {
    return (LocaleProvider.current.guven_cayyolu_campus);
  }

  return "";
}

/// Captures tab key and switches to next input field(focus node)
/// If next input field(focus node) is null, unfocuses the first field
class TabToNextFieldTextInputFormatter extends TextInputFormatter {
  BuildContext context;
  FocusNode fromFN;
  FocusNode? toFN;

  TabToNextFieldTextInputFormatter(this.context, this.fromFN, this.toFN);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    if (text != "") {
      int codeUnit = text.codeUnitAt(text.length - 1);
      // If user pressed TAB key
      if (codeUnit == 9) {
        if (toFN == null) {
          fromFN.unfocus();
        } else {
          UtilityManager().fieldFocusChange(context, fromFN, toFN);
        }
        return oldValue;
      }
    }

    return newValue;
  }
}

Future<void> showCompulsoryUpdateDialog({
  required VoidCallback onPressed,
  required BuildContext context,
  required String message,
}) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      String btnLabel = LocaleProvider.of(context).update_now;

      return RbioBaseGreyDialog(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  LocaleProvider.current.app_update_available,
                  style: getIt<IAppConfig>().theme.dialogTheme.title(context),
                  textAlign: TextAlign.center,
                ),
              ),
              R.sizes.hSizer32,
              Center(
                child: Text(
                  LocaleProvider.current.force_update_message,
                  style: getIt<IAppConfig>()
                      .theme
                      .dialogTheme
                      .description(context),
                  textAlign: TextAlign.center,
                ),
              ),
              R.sizes.hSizer32,
              Center(
                child: RbioSmallDialogButton.green(
                    title: LocaleProvider.current.update_now,
                    onPressed: onPressed),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showOptionalUpdateDialog({
  required Function()? onPressed,
  context,
  String? message,
}) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      String title = LocaleProvider.of(context).app_update_available;
      String btnLabel = LocaleProvider.of(context).update_now;
      String btnLabelCancel = LocaleProvider.of(context).later;
      String btnLabelDontAskAgain = LocaleProvider.of(context).dont_ask_again;

      return DoNotAskAgainDialog(
        title: title,
        subTitle: message ?? "No message",
        positiveButtonText: btnLabel,
        negativeButtonText: btnLabelCancel,
        onPositiveButtonClicked: onPressed,
        doNotAskAgainText: Platform.isIOS
            ? btnLabelDontAskAgain
            : LocaleProvider.of(context).never_ask_again,
      );
    },
  );
}

String fillAllFields(String formContext, String userName, String email,
    String phoneNumber, String currentDate, String packageName) {
  List<String> formTmpList = formContext.split(' ').toList();
  formContext = "";
  for (var element in formTmpList) {
    if (element.contains(R.constants.userName)) {
      formContext += ' ' + element.replaceFirst(R.constants.userName, userName);
    } else if (element.contains(R.constants.adress)) {
      formContext += ' ' + element.replaceFirst(R.constants.adress, "-");
    } else if (element.contains(R.constants.phoneNumber)) {
      formContext +=
          ' ' + element.replaceFirst(R.constants.phoneNumber, phoneNumber);
    } else if (element.contains(R.constants.email)) {
      formContext += ' ' + element.replaceFirst(R.constants.email, email);
    } else if (element.contains(R.constants.paymentPlan)) {
      formContext += ' ' + element.replaceFirst(R.constants.paymentPlan, "-");
    } else if (element.contains(R.constants.currentDate)) {
      formContext +=
          ' ' + element.replaceFirst(R.constants.currentDate, currentDate);
    } else if (element.contains(R.constants.packageName)) {
      formContext +=
          ' ' + element.replaceFirst(R.constants.packageName, packageName);
    } else if (element.contains(R.constants.expirationDate)) {
      formContext +=
          ' ' + element.replaceFirst(R.constants.expirationDate, "-");
    } else if (element.contains(R.constants.hospitalEmail)) {
      formContext += ' ' + element.replaceFirst(R.constants.hospitalEmail, "-");
    } else {
      formContext += ' ' + element;
    }
  }
  return formContext;
}

String getEnumValue(e) => e.toString().split('.').last;

Gradient appGradient() => LinearGradient(
      colors: [
        getIt<IAppConfig>().theme.mainColor,
        getIt<IAppConfig>().theme.mainColor,
      ],
    );

class GradientDialog extends StatefulWidget {
  final String? title;
  final String? text;

  const GradientDialog({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  _GradientDialogState createState() => _GradientDialogState();
}

class _GradientDialogState extends State<GradientDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      style: TextButton.styleFrom(primary: getIt<IAppConfig>().theme.textColor),
      child: Text(LocaleProvider.current.ok),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.title ?? '',
        style: context.xHeadline1.copyWith(
            fontWeight: FontWeight.w700,
            color: getIt<IAppConfig>().theme.textColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      actions: [
        okButton,
      ],
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.text ?? '',
              style: context.xHeadline3.copyWith(
                color: getIt<IAppConfig>().theme.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressDialog extends StatefulWidget {
  static late _ProgressDialogState state;

  const ProgressDialog({Key? key}) : super(key: key);

  bool isShowing() {
    return state.mounted;
  }

  @override
  _ProgressDialogState createState() => state = _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(10),
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: R.sizes.borderRadiusCircular,
              gradient: blueGradient(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                progress(),
                JumpingText((LocaleProvider.current.loading))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget progress({
    Key? key,
    double? value,
    Color? backgroundColor,
    Animation? valueColor,
    String? semanticsLabel,
    String? semanticsValue,
  }) =>
      ShakeAnimatedWidget(
        enabled: true,
        duration: const Duration(milliseconds: 1500),
        shakeAngle: Rotation.deg(z: 10),
        curve: Curves.linear,
        child: SizedBox(
          width: 80,
          height: 80,
          child: SvgPicture.asset(R.image.stethoscope),
        ),
      );

  Gradient blueGradient() => const LinearGradient(
        colors: [
          Colors.black12,
          Colors.black12,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
      );
}

extension SclaeToStringExtension on SelectedScaleType {
  String get toStr {
    switch (this) {
      case SelectedScaleType.bmi:
        return LocaleProvider.current.scale_data_bmi;

      case SelectedScaleType.weight:
        return LocaleProvider.current.weight;

      case SelectedScaleType.bodyFat:
        return LocaleProvider.current.scale_data_body_fat;

      case SelectedScaleType.boneMass:
        return LocaleProvider.current.scale_data_bone_mass;

      case SelectedScaleType.water:
        return LocaleProvider.current.scale_data_water;

      case SelectedScaleType.visceralFat:
        return LocaleProvider.current.scale_data_visceral_fat;

      case SelectedScaleType.muscle:
        return LocaleProvider.current.scale_data_muscle;

      default:
        return "";
    }
  }
}
