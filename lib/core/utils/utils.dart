// ignore_for_file: prefer_equal_for_default_values

import 'dart:convert';
import 'dart:io';

import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../features/shared/do_not_show_again_dialog.dart';
import '../../model/ble_models/DeviceTypes.dart';
import '../../model/model.dart';
import '../core.dart';

class Utils {
  Utils._();

  static late Utils _instance;

  static Utils get instance {
    return _instance;
  }

  String get getCurrentUserNameAndSurname =>
      '${getIt<UserNotifier>().getPatient().firstName} ${getIt<UserNotifier>().getPatient().lastName}';

  String? get getCacheProfileImageStr => getIt<ISharedPreferencesManager>()
      .getString(SharedPreferencesKeys.profileImage);
  ImageProvider<Object> get getCacheProfileImage {
    if (getCacheProfileImageStr != null) {
      return MemoryImage(base64.decode(getCacheProfileImageStr!));
    } else {
      return NetworkImage(R.image.circlevatar);
    }
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
    } catch (e) {
      final apiData = await apiCall();
      await localCacheService.write(
          cacheUrl, json.encode(apiData), cacheDuration);
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
    } catch (e) {
      final apiData = await apiCall();
      await localCacheService.write(
          cacheUrl, json.encode(apiData), cacheDuration);
      return apiData;
    }
  }
  // #endregion

  // chronic_tracking
  DeviceType getDeviceType(DiscoveredDevice device) {
    if (device.name == 'MIBFS' &&
        device.serviceData.length == 1 &&
        device.serviceData.values.first.length == 13) {
      return DeviceType.MI_SCALE;
    } else if (device.manufacturerData[0] == 112) {
      return DeviceType.ACCU_CHEK;
    } else if (device.manufacturerData[0] == 103) {
      return DeviceType.CONTOUR_PLUS_ONE;
    }

    throw Exception('Nondefined device');
  }

  Widget guidePopUpContextWidget(List<String> currentDeviceInfos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: currentDeviceInfos.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: Atom.width * .8,
            child: RichText(
              textScaleFactor: context.xMediaQuery.textScaleFactor,
              text: TextSpan(
                text: (index + 1).toString() + ".",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: R.color.dark_blue,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: currentDeviceInfos[index],
                    style: TextStyle(
                      color: R.color.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
        focusColor: getIt<ITheme>().mainColor,
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

  InputDecoration inputImageDecorationRed({image: String, hintText: String}) =>
      InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: SvgPicture.asset(
          image,
          fit: BoxFit.none,
          color: R.color.light_blue,
        ),
        focusedBorder: _borderTextFieldRed(),
        border: _borderTextFieldRed(),
        enabledBorder: _borderTextFieldRed(),
        hintText: hintText,
        hintStyle: hintStyle(),
      );

  TextStyle inputTextStyle() => TextStyle(
        fontSize: 16,
        color: R.color.dark_black,
      );

  TextStyle hintStyle() => TextStyle(fontSize: 16, color: R.color.gray);

  GradientButton button({
    text: String,
    required Function onPressed,
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
              fontSize: 16, fontWeight: FontWeight.w600, color: R.color.white),
        ),
        textStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: R.color.white),
        callback: onPressed(),
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
          color: R.color.grey,
        ),
        gradient: LinearGradient(
          colors: [
            getIt<ITheme>().mainColor.withAlpha(15),
            getIt<ITheme>().mainColor.withAlpha(15)
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
          color: getIt<ITheme>().textColorPassive,
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

  Widget forYouCategoryCard({
    required BuildContext context,
    final int? id,
    final String? title,
    final Image? icon,
    required final bool isSubCat,
  }) =>
      GestureDetector(
        onTap: () {
          id == -1
              ? Atom.to(PagePaths.covid19)
              : isSubCat
                  ? Atom.to(
                      PagePaths.forYouSubCategoriesDetail,
                      queryParameters: {
                        'title':
                            title != null ? Uri.encodeFull(title) : "No title",
                        'subCategoryId': id.toString()
                      },
                    )
                  : Atom.to(
                      PagePaths.forYouSubCategories,
                      queryParameters: {
                        'title':
                            title != null ? Uri.encodeFull(title) : "No title",
                        'categoryId': id.toString(),
                      },
                    );
        },
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            height: 300,
            width: 300,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                //
                FittedBox(
                  fit: BoxFit.fill,
                  child: icon,
                ),

                //
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          getIt<ITheme>().mainColor.withOpacity(0.8),
                          getIt<ITheme>().mainColor.withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: R.color.dark_black.withAlpha(50),
                          blurRadius: 15,
                          spreadRadius: 0,
                          offset: const Offset(5, 10),
                        ),
                      ],
                    ),
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            title ?? "No title",
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.xHeadline4.copyWith(
                              fontWeight: FontWeight.bold,
                              color: getIt<ITheme>().textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
      color = R.color.very_low;
    } else if (measurement > criticMin && measurement < targetMin) {
      color = R.color.low;
    } else if (measurement >= targetMin && measurement <= targetMax) {
      color = R.color.target;
    } else if (measurement > targetMax && measurement < criticMax) {
      color = R.color.high;
    } else if (measurement >= criticMax) {
      color = R.color.very_high;
    } else {
      color = Colors.white;
    }
    return color;
  }

  InputBorder _borderTextField() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(200),
        borderSide: BorderSide(
            width: 0, style: BorderStyle.solid, color: R.color.dark_white),
      );

  InputBorder _borderTextFieldRed() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(200),
        borderSide: BorderSide(
            width: 0, style: BorderStyle.solid, color: R.color.light_blue),
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

  void joinJitsiMeeting(JitsiMeetingOptions options) async {
    await getIt<Repository>().setJitsiWebConsultantId(options.roomNameOrUrl);

    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (message) {
          debugPrint(
              "${options.roomNameOrUrl} will join with message: $message");
        },
        onConferenceJoined: (message) {
          debugPrint("${options.roomNameOrUrl} joined with message: $message");
        },
        onConferenceTerminated: (message, _) {
          debugPrint(
              "${options.roomNameOrUrl} terminated with message: $message");
        },
      ),
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

    if (result < activeProfile.hypo) {
      return R.color.very_low;
    } else if (result >= activeProfile.hypo &&
        result < activeProfile.rangeMin) {
      return R.color.low;
    } else if (result >= activeProfile.rangeMin &&
        result < activeProfile.rangeMax) {
      return R.color.target;
    } else if (result >= activeProfile.rangeMax &&
        result < activeProfile.hyper) {
      return R.color.high;
    } else {
      return R.color.very_high;
    }
  }

  Widget? getDeviceImage(int deviceId) {
    switch (deviceId) {
      case 87:
        return Image.asset(R.image.mi_scale);
      case 103:
        return Image.asset(R.image.contour_png);
      case 112:
        return Image.asset(R.image.accu_check_png);
      default:
        return null;
    }
  }

  Widget? getDeviceImageFromType(DeviceType device) {
    switch (device) {
      case DeviceType.MI_SCALE:
        return Image.asset(R.image.mi_scale);
      case DeviceType.CONTOUR_PLUS_ONE:
        return Image.asset(R.image.contour_png);
      case DeviceType.ACCU_CHEK:
        return Image.asset(R.image.accu_check_png);
      default:
        return null;
    }
  }

  String? getDeviceImageStringFromType(DeviceType device) {
    switch (device) {
      case DeviceType.MI_SCALE:
        return R.image.mi_scale;
      case DeviceType.CONTOUR_PLUS_ONE:
        return R.image.contour_png;
      case DeviceType.ACCU_CHEK:
        return R.image.accu_check_png;
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
  if (data.type == R.dynamicVar.onlineAppointmentType) {
    return (LocaleProvider.current.online_appo);
  } else if (data.tenantId == R.dynamicVar.tenantAyranciId) {
    return (LocaleProvider.current.guven_hospital_ayranci);
  } else if (data.tenantId == R.dynamicVar.tenantCayyoluId) {
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
  required Function onPressed,
  context,
  String? message,
}) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      String title = LocaleProvider.of(context).app_update_available;
      String btnLabel = LocaleProvider.of(context).update_now;

      return GuvenAlert(
        backgroundColor: Colors.white,
        title: GuvenAlert.buildTitle(title),
        content: GuvenAlert.buildDescription(message ?? "No message"),
        actions: <Widget>[
          GuvenAlert.buildMaterialAction(btnLabel, onPressed()),
        ],
      );
    },
  );
}

Future<void> showOptionalUpdateDialog({
  required Function onPressed,
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
        dialogKeyName: "kUpdateDialogKeyName",
        title: title,
        subTitle: message ?? "No message",
        positiveButtonText: btnLabel,
        negativeButtonText: btnLabelCancel,
        onPositiveButtonClicked: () {
          onPressed();
        },
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
    if (element.contains(R.dynamicVar.userName)) {
      formContext +=
          ' ' + element.replaceFirst(R.dynamicVar.userName, userName);
    } else if (element.contains(R.dynamicVar.adress)) {
      formContext += ' ' + element.replaceFirst(R.dynamicVar.adress, "-");
    } else if (element.contains(R.dynamicVar.phoneNumber)) {
      formContext +=
          ' ' + element.replaceFirst(R.dynamicVar.phoneNumber, phoneNumber);
    } else if (element.contains(R.dynamicVar.email)) {
      formContext += ' ' + element.replaceFirst(R.dynamicVar.email, email);
    } else if (element.contains(R.dynamicVar.paymentPlan)) {
      formContext += ' ' + element.replaceFirst(R.dynamicVar.paymentPlan, "-");
    } else if (element.contains(R.dynamicVar.currentDate)) {
      formContext +=
          ' ' + element.replaceFirst(R.dynamicVar.currentDate, currentDate);
    } else if (element.contains(R.dynamicVar.packageName)) {
      formContext +=
          ' ' + element.replaceFirst(R.dynamicVar.packageName, packageName);
    } else if (element.contains(R.dynamicVar.expirationDate)) {
      formContext +=
          ' ' + element.replaceFirst(R.dynamicVar.expirationDate, "-");
    } else if (element.contains(R.dynamicVar.hospitalEmail)) {
      formContext +=
          ' ' + element.replaceFirst(R.dynamicVar.hospitalEmail, "-");
    } else {
      formContext += ' ' + element;
    }
  }
  return formContext;
}

String getEnumValue(e) => e.toString().split('.').last;

Gradient appGradient() => LinearGradient(
      colors: [
        getIt<ITheme>().mainColor,
        getIt<ITheme>().mainColor,
      ],
    );

// MEDIMINDER WIDGETS AND RESOURCES
class Mediminder {
  Mediminder._();

  static late Mediminder _instance;

  static Mediminder get instance {
    return _instance;
  }

  Person selection = Person(
    userId: 56265,
    id: 1627287863112,
    imageURL:
        'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png',
    name: 'Mustafa TÜRKMEN',
    birthDate: '09.11.1997',
    gender: 'Male',
    height: '170',
    weight: '50',
    diabetesType: 'Type 1',
    hypo: 36,
    rangeMin: 76,
    target: 120,
    rangeMax: 151,
    hyper: 301,
    deviceUUID: "",
    manufacturerId: 0,
    yearOfDiagnosis: 2021,
    smoker: true,
    isFirstUser: false,
  );
}

class GradientDialog extends StatefulWidget {
  final String title;
  final String text;

  const GradientDialog(Key? key, this.title, this.text) : super(key: key);

  @override
  _GradientDialogState createState() => _GradientDialogState();
}

class _GradientDialogState extends State<GradientDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      style: TextButton.styleFrom(primary: getIt<ITheme>().textColor),
      child: Text(LocaleProvider.current.ok),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: getIt<ITheme>().mainColor,
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.title,
        style: context.xHeadline1.copyWith(
            fontWeight: FontWeight.w700, color: getIt<ITheme>().textColor),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
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
            Text(widget.text,
                style: context.xHeadline3
                    .copyWith(color: getIt<ITheme>().textColor)),
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
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
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
