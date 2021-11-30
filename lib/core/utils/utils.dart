// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:onedosehealth/core/data/service/chronic_service/chronic_storage_service.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/models/ble_models/DeviceTypes.dart';
import 'package:onedosehealth/features/shared/do_not_show_again_dialog.dart';
import '../../model/model.dart';
import '../core.dart';
import '../data/repository/repository.dart';
import '../events/success_events.dart';
import '../locator.dart';
import '../manager/analytics_manager.dart';
import '../navigation/app_paths.dart';
import '../widgets/guven_alert.dart';
import '../widgets/warning_dialog.dart';

Gradient BlueGradient() => LinearGradient(
    colors: [R.color.dark_blue, R.color.defaultBlue],
    begin: Alignment.bottomLeft,
    end: Alignment.centerRight);

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

ListView guidePopUpContextWidget(List<String> currentDeviceInfos) {
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
                      )),
                ],
              ),
            ),
          ),
        );
      });
}

InputDecoration inputImageDecoration(
        {image: String,
        hintText: String,
        Function suffixIconClicked,
        Widget suffixIcon}) =>
    InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: SvgPicture.asset(
          image,
          fit: BoxFit.none,
        ),
        focusedBorder: _borderTextField(),
        border: _borderTextField(),
        focusColor: R.color.blue,
        suffixIcon: Visibility(
          visible: suffixIcon != null ? true : false,
          child: InkWell(
            onTap: () {
              suffixIconClicked();
            },
            child: suffixIcon ??
                SizedBox(
                  width: 0,
                ),
          ),
        ),
        enabledBorder: _borderTextField(),
        hintText: hintText,
        hintStyle: hintStyle());

InputDecoration inputImageDecorationRed({image: String, hintText: String}) =>
    InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: SvgPicture.asset(
          image,
          fit: BoxFit.none,
          color: R.color.light_blue,
        ),
        focusedBorder: _borderTextFieldRed(),
        border: _borderTextFieldRed(),
        enabledBorder: _borderTextFieldRed(),
        hintText: hintText,
        hintStyle: hintStyle());

InputBorder _borderTextField() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(200),
      borderSide: BorderSide(
          width: 0, style: BorderStyle.solid, color: R.color.dark_white),
    );

InputBorder _borderTextFieldForLogin() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
          width: 0, style: BorderStyle.solid, color: R.color.dark_white),
    );

InputBorder _borderTextFieldRed() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(200),
      borderSide: BorderSide(
          width: 0, style: BorderStyle.solid, color: R.color.light_blue),
    );

TextStyle inputTextStyle() =>
    TextStyle(fontSize: 16, color: R.color.dark_black);

TextStyle hintStyle() => TextStyle(fontSize: 16, color: R.color.gray);

GradientButton button({
  text: String,
  Function onPressed,
  double height = 16,
  double width = 200,
}) =>
    GradientButton(
      increaseHeightBy: height,
      increaseWidthBy: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: R.color.white),
      ),
      textStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: R.color.white),
      callback: onPressed,
      gradient: AppGradient(),
      shadowColor: Colors.black,
    );

GradientButton passiveButton(
        {text: String,
        Function onPressed,
        double height = 16,
        double width = 200}) =>
    GradientButton(
      increaseHeightBy: height,
      increaseWidthBy: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      textStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: R.color.grey),
      callback: onPressed,
      gradient: passiveBlueGradient(),
      shadowColor: Colors.black.withAlpha(50),
    );

InputDecoration inputDecoration({hintText: String}) => InputDecoration(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    focusedBorder: _borderTextField(),
    border: _borderTextField(),
    enabledBorder: _borderTextField(),
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 16, color: R.color.gray));

InputDecoration inputDecorationForLogin({hintText: String}) => InputDecoration(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    focusedBorder: _borderTextFieldForLogin(),
    border: _borderTextFieldForLogin(),
    enabledBorder: _borderTextFieldForLogin(),
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 16, color: R.color.gray));

Widget ButtonBackGrey(BuildContext context) => IconButton(
    icon: SvgPicture.asset(R.image.ic_back_grey),
    onPressed: () {
      Navigator.of(context).pop();
    });

Widget CallMeWidget({BuildContext context, Function onPressed}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            LocaleProvider.of(context).no_appo_call_us,
            textAlign: TextAlign.center,
            textScaleFactor: 1.3,
          ),
        ),
        InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              gradient: LinearGradient(
                  colors: [R.color.blue, R.color.light_blue],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight),
              border: Border.all(
                width: 1,
                color: R.color.blue,
              ),
            ),
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  R.image.ic_phone_call_grey,
                  color: R.color.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  LocaleProvider.of(context).call_me,
                  style: TextStyle(color: R.color.white),
                ),
              ],
            ),
          ),
        )
      ],
    );

Widget ButtonBackWhite(BuildContext context) => IconButton(
      icon: SvgPicture.asset(R.image.ic_back_white),
      padding: EdgeInsets.only(
        top: Atom.isWeb ? 8 : 4,
      ),
      onPressed: () {
        Atom.historyBack();
      },
    );

Widget TitleAppBarBlack({String title}) => Text(
      title,
      style: TextStyle(
        fontSize: 18,
        color: R.color.black,
        fontWeight: FontWeight.w600,
      ),
    );

Widget TitleAppBarWhite({String title}) => Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );

Widget InputWidget(
        {String hint,
        String text = '',
        double bottom = 0,
        double top = 0,
        Function onTap}) =>
    Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          child: Text(
            text.isEmpty ? hint : text,
            style: text.isEmpty ? hintStyle() : inputTextStyle(),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            border: Border.all(
              width: 1,
              color: R.color.dark_white,
            ),
          ),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        ),
      ),
    );

Widget MainAppBar({
  BuildContext context,
  Widget leading,
  Widget title,
  List<Widget> actions,
  Widget bottom,
}) =>
    PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: leading == null ? Container() : leading,
                left: 0,
              ),
              Center(
                child: title == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: title,
                      ),
              ),
              Positioned(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions == null ? [] : actions,
                ),
                right: 0,
              )
            ],
          ),
          decoration: BoxDecoration(gradient: AppGradient()),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 50.0));

Widget CustomCircleAvatar(
        {double size = 50, Widget child, BoxDecoration decoration}) =>
    Container(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: child,
      ),
      decoration: decoration,
    );

Widget categoryBox({
  BuildContext context,
  final int id,
  final String title,
  final Image icon,
  final bool isSubCat,
}) =>
    GestureDetector(
      onTap: () {
        id == -1
            ? Atom.to(PagePaths.COVID19)
            : isSubCat
                ? Atom.to(
                    PagePaths.FOR_YOU_SUB_CATEGORIES_DETAIL,
                    queryParameters: {
                      'title': Uri.encodeFull(title),
                      'subCategoryId': id.toString()
                    },
                  )
                : Atom.to(
                    PagePaths.FOR_YOU_SUB_CATEGORIES,
                    queryParameters: {
                      'title': Uri.encodeFull(title),
                      'categoryId': id.toString(),
                    },
                  );

        isSubCat
            ? AnalyticsManager()
                .sendEvent(new SubCategoryClicked(subCategoryName: title))
            : AnalyticsManager()
                .sendEvent(new CategoryClicked(categoryName: title));
      },
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: 300,
          width: 300,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              FittedBox(fit: BoxFit.fill, child: icon),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          title,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline3.copyWith(
                              fontWeight: FontWeight.bold,
                              color: getIt<ITheme>().textColor),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        getIt<ITheme>().mainColor.withOpacity(0.8),
                        getIt<ITheme>().mainColor.withOpacity(0.3),
                      ], begin: Alignment.topLeft, end: Alignment.topRight),
                      boxShadow: [
                        BoxShadow(
                            color: R.color.dark_black.withAlpha(50),
                            blurRadius: 15,
                            spreadRadius: 0,
                            offset: Offset(5, 10))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );

Widget getTitleBar(BuildContext context, String text) {
  return TitleAppBarWhite(title: text);
}

String getFormattedDate(String date) => DateTime.parse(date).xFormatTime2();

String getFormattedDateWithTime(String date) =>
    DateTime.parse(date).xFormatTime3();

Gradient passiveBlueGradient() => LinearGradient(colors: [
      getIt<ITheme>().mainColor.withAlpha(15),
      getIt<ITheme>().mainColor.withAlpha(15)
    ], begin: Alignment.bottomLeft, end: Alignment.centerRight);

BoxDecoration ShadowDecorationWhite() => BoxDecoration(
      color: R.color.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
            color: Color(0xFF000000).withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 1))
      ],
    );

/// Page Irrelevant operations
class UtilityManager {
  static final UtilityManager _instance = UtilityManager._internal();

  factory UtilityManager() {
    return _instance;
  }

  UtilityManager._internal() {}

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
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
            style: TextStyle(
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
                  style: new TextStyle(
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

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }

  void joinJitsiMeeting(JitsiMeetingOptions options) async {
    await getIt<Repository>().setJitsiWebConsultantId(options.room);

    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (message) {
          debugPrint("${options.room} will join with message: $message");
        },
        onConferenceJoined: (message) {
          debugPrint("${options.room} joined with message: $message");
        },
        onConferenceTerminated: (message) {
          debugPrint("${options.room} terminated with message: $message");
        },
      ),
    );
  }

  Future<void> setTokenToServer(String token) async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) async {
      AddFirebaseTokenRequest addFirebaseToken = AddFirebaseTokenRequest();
      addFirebaseToken.firebaseId = token;
      if (!kIsWeb) addFirebaseToken.phoneInfo = await getDeviceInformation();
      await getIt<Repository>().addFirebaseTokenUi(addFirebaseToken);
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
    }

    return "";
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

  Widget getDeviceImage(int deviceId) {
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

  Widget getDeviceImageFromType(DeviceType device) {
    print(device);
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
  FocusNode toFN;

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
  Function onPressed,
  context,
  String message,
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
        content: GuvenAlert.buildDescription(message),
        actions: <Widget>[
          GuvenAlert.buildMaterialAction(btnLabel, onPressed),
        ],
      );
    },
  );
}

Future<void> showOptionalUpdateDialog({
  Function onPressed,
  context,
  String message,
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
        subTitle: message,
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

String clearDoctorTitle(String text) {
  if (text.contains('dr.')) {
    return text.split('dr.')[1];
  } else {
    return text;
  }
}

String fillAllFields(String formContext, String userName, String email,
    String phoneNumber, String currentDate, String packageName) {
  List<String> formTmpList = formContext.split(' ').toList();
  formContext = "";
  formTmpList.forEach((element) {
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
  });
  return formContext;
}

String GetEnumValue(e) => e.toString().split('.').last;

Gradient AppGradient() => LinearGradient(
      colors: [
        getIt<ITheme>().mainColor,
        getIt<ITheme>().mainColor,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight,
    );

class Utils {
  Utils._();

  static Utils _instance;

  static Utils get instance {
    _instance ??= Utils._();
    return _instance;
  }

  Future<List<T>> getCacheApiCallList<T extends IBaseModel>(
    String url,
    Future<List<T>> Function() apiCall,
    Duration cacheDuration,
    T model,
    LocalCacheService localCacheService,
  ) async {
    final localData = await localCacheService.get(url);
    if (localData == null) {
      final apiData = await apiCall();
      await localCacheService.write(url, json.encode(apiData), cacheDuration);
      return apiData;
    } else {
      final localModel = json.decode(localData);
      if (localModel is List) {
        return localModel.map((e) => model.fromJson(e)).cast<T>().toList();
      }
      return [];
    }
  }

  Future<T> getCacheApiCallModel<T extends IBaseModel>(
    String url,
    Future<T> Function() apiCall,
    Duration cacheDuration,
    T model,
    LocalCacheService localCacheService,
  ) async {
    final localData = await localCacheService.get(url);
    if (localData == null) {
      final apiData = await apiCall();
      await localCacheService.write(url, json.encode(apiData), cacheDuration);
      return apiData;
    } else {
      final localModel = json.decode(localData);
      if (localModel is Map) {
        return model.fromJson(localModel);
      }

      throw Exception('getCacheApiCallModel : ${model.runtimeType}');
    }
  }
}
