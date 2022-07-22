// ignore_for_file: prefer_equal_for_default_values

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

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
    if (height != null) {
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

  Gradient appGradient(BuildContext context) => LinearGradient(
        colors: [
          context.xPrimaryColor,
          context.xPrimaryColor,
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
                  color: context.xTextColor,
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
      backColor: context.xPrimaryColor,
      trailing: SvgPicture.asset(
        R.image.done,
        height: R.sizes.iconSize2,
        color: context.xAppColors.white,
      ),
    );
  }
  // #endregion

  // #region showErrorSnackbar
  void showErrorSnackbar(BuildContext context, String text) {
    showSnackbar(
      context,
      text,
      backColor: context.xAppColors.punch,
      trailing: SvgPicture.asset(
        R.image.error,
        height: R.sizes.iconSize2,
        color: context.xAppColors.white,
      ),
    );
  }
  // #endregion

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

    try {
      var localData = await localCacheService.get(cacheUrl);
      if (localData.isEmpty) {
        final apiData = await apiCall();
        await localCacheService.write(
          cacheUrl,
          json.encode(apiData),
          cacheDuration,
        );
        return apiData;
      } else {
        final localModel = json.decode(localData);
        if (localModel is List) {
          return localModel.map((e) => model.fromJson(e)).cast<T>().toList();
        }
      }

      return [];
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      rethrow;
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
    required BuildContext context,
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
                color: context.xIconColor,
              )
            : const Icon(Icons.close),
        focusedBorder: _borderTextField(),
        border: _borderTextField(),
        focusColor: context.xPrimaryColor,
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
        hintStyle: hintStyle(context),
      );

  TextStyle inputTextStyle(BuildContext context, [Color? textColor]) =>
      TextStyle(
        fontSize: 16,
        color: textColor ?? context.xTextInverseColor,
      );

  TextStyle hintStyle(BuildContext context) => TextStyle(
        fontSize: 16,
        color: context.xAppColors.dustyGray,
      );

  GradientButton button({
    required BuildContext context,
    required String text,
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
            color: context.xAppColors.white,
          ),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: getIt<IAppConfig>().theme.white,
        ),
        callback: onPressed,
        gradient: appGradient(context),
        shadowColor: Colors.black,
      );

  InputDecoration inputDecorationForLogin(
    BuildContext context, {
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
          color: context.xAppColors.textDisabledColor,
        ),
      );

  String clearDoctorTitle(String text) {
    var result = text;
    for (var title in R.constants.drTitles) {
      result = result.replaceAll(title, "");
    }
    result = result.trim();
    if (result[0] == '.') {
      result = result.substring(2, result.length);
    }
    return result;
    // if (text.contains('dr.')) {
    //   return text.split('dr.')[1];
    // } else {
    //   return text;
    // }
  }

  Color fetchMeasurementColor(
    BuildContext context, {
    required int measurement,
    required int criticMin,
    required int criticMax,
    required int targetMax,
    required int targetMin,
  }) {
    Color color;
    if (measurement <= criticMin) {
      color = context.xAppColors.roman;
    } else if (measurement > criticMin && measurement < targetMin) {
      color = context.xAppColors.tonysPink;
    } else if (measurement >= targetMin && measurement <= targetMax) {
      color = context.xAppColors.deYork;
    } else if (measurement > targetMax && measurement < criticMax) {
      color = context.xAppColors.energyYellow;
    } else if (measurement >= criticMax) {
      color = context.xAppColors.casablanca;
    } else {
      color = Colors.white;
    }
    return color;
  }

  InputBorder _borderTextField() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(200),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.solid,
          color: Colors.transparent,
        ),
      );

  void fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode? nextFocus,
  ) {
    currentFocus.unfocus();
    if (nextFocus == null) {
      return;
    } else {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  /// MG14
  Color getGlucoseMeasurementColor(
    BuildContext context,
    int result,
  ) {
    Person activeProfile = getIt<ProfileStorageImpl>().getFirst();

    if (result < activeProfile.hypo!) {
      return context.xAppColors.roman;
    } else if (result >= activeProfile.hypo! &&
        result < activeProfile.rangeMin!) {
      return context.xAppColors.tonysPink;
    } else if (result >= activeProfile.rangeMin! &&
        result < activeProfile.rangeMax!) {
      return context.xAppColors.deYork;
    } else if (result >= activeProfile.rangeMax! &&
        result < activeProfile.hyper!) {
      return context.xAppColors.energyYellow;
    } else {
      return context.xAppColors.casablanca;
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

  String fillAllFields(String formContext, String userName, String email,
      String phoneNumber, String currentDate, String packageName) {
    List<String> formTmpList = formContext.split(' ').toList();
    formContext = "";
    for (var element in formTmpList) {
      if (element.contains(R.constants.userName)) {
        formContext +=
            ' ' + element.replaceFirst(R.constants.userName, userName);
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
        formContext +=
            ' ' + element.replaceFirst(R.constants.hospitalEmail, "-");
      } else {
        formContext += ' ' + element;
      }
    }
    return formContext;
  }

  String getEnumValue(e) => e.toString().split('.').last;
}
