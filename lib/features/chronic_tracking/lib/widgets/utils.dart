import 'dart:math';

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../database/datamodels/glucose_data.dart';
import '../extension/size_extension.dart';
import '../generated/l10n.dart';
import '../helper/loading_dialog.dart';
import '../helper/resources.dart';
import '../models/ble_models/DeviceTypes.dart';
import '../models/user_profiles/person.dart';
import '../notifiers/user_profiles_notifier.dart';

final _random = new Random();

/**
 * Generates a positive random integer uniformly distributed on the range
 * from [min], inclusive, to [max], exclusive.
 */
int randomNext(int min, int max) => min + _random.nextInt(max - min);

InputDecoration inputImageDecoration({image: String, hintText: String}) =>
    InputDecoration(
        contentPadding: EdgeInsets.all(8),
        prefixIcon: SvgPicture.asset(
          image,
          fit: BoxFit.none,
        ),
        focusedBorder: _borderTextField(),
        border: _borderTextField(),
        enabledBorder: _borderTextField(),
        hintText: hintText,
        fillColor: Colors.white,
        hintStyle: hintStyle());

BoxDecoration inputBoxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(200)),
      gradient: LinearGradient(colors: [
        Colors.white,
        Colors.white,
      ], begin: Alignment.topLeft, end: Alignment.topRight),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(5, 10))
      ]);
}

Widget loginOptionButton({String icon, String text, Function onPressed}) {
  return Container(
    height: 50,
    width: 330,
    child: RaisedButton.icon(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      icon: SvgPicture.asset(
        icon,
        height: 25,
        width: 25,
        fit: BoxFit.fill,
      ),
      label: Text(text, style: TextStyle(color: R.color.border_color)),
      color: Colors.white,
      onPressed: () {
        onPressed();
      },
    ),
  );
}

InputBorder _borderTextField() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(200),
      borderSide: BorderSide(
          width: 1, style: BorderStyle.solid, color: R.color.dark_white),
    );

TextStyle inputTextStyle() =>
    TextStyle(fontSize: 16, color: R.color.dark_black);

TextStyle hintStyle() => TextStyle(fontSize: 16, color: R.color.gray);

CircularProgressIndicator progress({
  Key key,
  double value,
  Color backgroundColor,
  Animation valueColor,
  String semanticsLabel,
  String semanticsValue,
}) =>
    CircularProgressIndicator(
      backgroundColor: R.color.light_blue,
    );

GradientButton button(
        {text: String, Function onPressed, double height, double width}) =>
    GradientButton(
      increaseHeightBy: height ?? 16,
      increaseWidthBy: width ?? 200,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      callback: onPressed,
      gradient: BlueGradient(),
      shadowColor: Colors.black,
    );

GradientButton buttonDarkGradient(
        {text: String, Function onPressed, double height, double width}) =>
    GradientButton(
      increaseHeightBy: height ?? 16,
      increaseWidthBy: width ?? 200,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      callback: onPressed,
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: <Color>[R.btnLightBlue, R.btnDarkBlue],
      ),
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
            LocaleProvider.current.no_appo_call_us,
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
                  colors: [R.color.defaultBlue, R.color.light_blue],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight),
              border: Border.all(
                width: 1,
                color: R.color.defaultBlue,
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
                  LocaleProvider.current.call_me,
                  style: TextStyle(color: R.color.white),
                ),
              ],
            ),
          ),
        )
      ],
    );

Widget ButtonBackWhite(BuildContext context) => IconButton(
    icon: SvgPicture.asset(R.image.back_icon),
    onPressed: () {
      Navigator.of(context).pop();
    });

Widget TitleAppBarBlack({String title}) => Text(
      title,
      style: TextStyle(
          fontSize: 18, color: R.color.black, fontWeight: FontWeight.w600),
    );

Widget TitleAppBarWhite({String title}) => Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: AutoSizeText(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );

Widget MeasurementCircle({GlucoseData glucoseData, bool isFill}) => Center(
      child: Stack(
        children: [
          Center(
            child: CircleAvatar(
              radius: 65,
              backgroundColor: UtilityManager()
                  .getGlucoseMeasurementColor(int.parse(glucoseData.level)),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: isFill
                    ? UtilityManager().getGlucoseMeasurementColor(
                        int.parse(glucoseData.level))
                    : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.black),
                        child: TextFormField(
                            enabled: glucoseData.manual ?? true,
                            initialValue:
                                int.parse(glucoseData.level).toString(),
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 3,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
/*if (value.length > 1)
                                                      sugarVM.changeResult(
                                                          int.parse(value));*/
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              errorStyle: TextStyle(height: 0),
                            ),
                            validator: (input) {
                              if (input.isNotEmpty)
                                return null;
                              else
                                return "";
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      "mg/dL",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget MeasurementCircleSmall({String level, bool isFill}) => Center(
      child: Stack(
        children: [
          Center(
            child: CircleAvatar(
              radius: 22,
              backgroundColor:
                  UtilityManager().getGlucoseMeasurementColor(int.parse(level)),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: isFill
                    ? UtilityManager()
                        .getGlucoseMeasurementColor(int.parse(level))
                    : Colors.white,
                child: Center(
                  child: Text(
                    level,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget MeasurementContainer({GlucoseData glucoseData}) => Container(
      alignment: Alignment.center,
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: glucoseData.tag == 3 ? BoxShape.rectangle : BoxShape.circle,
        color: glucoseData.tag == 1 || glucoseData.tag == 3
            ? UtilityManager()
                .getGlucoseMeasurementColor(int.parse(glucoseData.level))
            : UtilityManager()
                .getGlucoseMeasurementColor(int.parse(glucoseData.level)),
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(int.parse(
              glucoseData.level)), //                   <--- border color
          width: 5.0,
        ),
      ), //             <--- BoxDecoration here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            glucoseData.level,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );

Widget MeasurementSquare({GlucoseData glucoseData, bool isFill}) => Container(
      alignment: Alignment.center,
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: UtilityManager()
            .getGlucoseMeasurementColor(int.parse(glucoseData.level)),
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(int.parse(
              glucoseData.level)), //                   <--- border color
          width: 5.0,
        ),
      ), //             <--- BoxDecoration here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            child: Theme(
              data: ThemeData(primaryColor: Colors.black),
              child: TextFormField(
                  enabled: glucoseData.manual ?? true,
                  initialValue: glucoseData.level,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 3,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    glucoseData.level = value;
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    errorStyle: TextStyle(height: 0),
                  ),
                  validator: (input) {
                    if (input.isNotEmpty)
                      return null;
                    else
                      return "";
                  }),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            "mg/dL",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );

Widget ButtonSkip({BuildContext context, Function onPressed}) => Center(
      child: IconButton(
          icon: Text(
            LocaleProvider.current.btn_navigation_skip,
            style: TextStyle(fontSize: 16, color: R.color.defaultBlue),
          ),
          onPressed: onPressed),
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

Widget MainAppBar(
        {BuildContext context,
        Widget leading,
        Widget title,
        List<Widget> actions,
        Widget bottom}) =>
    PreferredSize(
      preferredSize: Size(context.WIDTH, context.HEIGHT * 0.18),
      child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Stack(
            children: [
              SvgPicture.asset(
                R.image.topTab,
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.WIDTH * .05,
                    vertical: context.HEIGHT * .02),
                child: SizedBox(
                  height: context.HEIGHT * .1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        leading == null
                            ? Container()
                            : SizedBox(
                                height: context.HEIGHT * .04,
                                width: context.HEIGHT * .04,
                                child: leading),
                        Expanded(
                          child: Center(
                              child: title == null ? Container() : title),
                        ),
                        actions == null
                            ? Opacity(
                                opacity: 0,
                                child: leading == null
                                    ? Container()
                                    : SizedBox(
                                        height: context.HEIGHT * .04,
                                        width: context.HEIGHT * .04,
                                        child: leading),
                              )
                            : Row(
                                children: actions
                                    .map(
                                      (action) => SizedBox(
                                          height: context.HEIGHT * .04,
                                          width: context.HEIGHT * .04,
                                          child: action),
                                    )
                                    .toList())
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
          /* Center(
            child: Stack(
              children: <Widget>[
                Center(
                  child: SvgPicture.asset(
                    R.image.topTab,
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  child: leading == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: leading,
                        ),
                  left: 16,
                  top: (MediaQuery.of(context).size.height * 0.025),
                ),
                Center(
                    child: title == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: (MediaQuery.of(context).size.height *
                                        0.15) /
                                    2,
                                top: MediaQuery.of(context).padding.top),
                            child: title,
                          )),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 0, top: MediaQuery.of(context).padding.top),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions == null ? [] : actions,
                    ),
                  ),
                  right: 8,
                  top: (MediaQuery.of(context).size.height * 0.025),
                ),
              ],
            ),
          ), */
          /*decoration: BoxDecoration(
              gradient: appBarGradient()),*/
          ),
    );

Widget MainAppBarHome(
        {BuildContext context,
        Widget leading,
        Widget title,
        List<Widget> actions,
        Widget bottom}) =>
    PreferredSize(
        child: Container(
          //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          width: double.infinity,
          child: Center(
            child: Stack(
              children: <Widget>[
                Stack(children: <Widget>[
                  Center(
                    child: SvgPicture.asset(
                      R.image.banner_steteskoplu,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: SvgPicture.asset(
                              R.image.dashboard_steteskop,
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                            ))
                      ])
                ]),
                Positioned(
                  child: leading == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: leading,
                        ),
                  left: 16,
                  top: (MediaQuery.of(context).size.height * 0.025),
                ),
                Center(
                    child: title == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: (MediaQuery.of(context).size.height *
                                        0.15) /
                                    2,
                                top: MediaQuery.of(context).padding.top),
                            child: title,
                          )),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 0, top: MediaQuery.of(context).padding.top),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions == null ? [] : actions,
                    ),
                  ),
                  right: 8,
                  top: (MediaQuery.of(context).size.height * 0.025),
                ),
              ],
            ),
          ),
          /*decoration: BoxDecoration(
              gradient: appBarGradient()),*/
        ),
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.15));

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

Gradient BlueGradient() => LinearGradient(
    colors: [R.color.dark_blue, R.color.defaultBlue],
    begin: Alignment.bottomLeft,
    end: Alignment.centerRight);

Gradient appBarGradient() => LinearGradient(colors: [
      R.color.defaultBlue,
      R.color.defaultBlue,
      R.color.defaultBlue,
      Colors.transparent,
      Colors.transparent
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

Gradient passiveBlueGradient() => LinearGradient(colors: [
      R.color.defaultBlue.withAlpha(50),
      R.color.light_blue.withAlpha(50)
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
    Person activeProfile =
        UserProfilesNotifier().selection ?? Person().fromDefault();

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

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus == null) {
      return;
    } else {
      FocusScope.of(context).requestFocus(nextFocus);
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

  showAlertDialog(
      BuildContext context, String text, LoadingDialog loadingDialog) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('$text'),
            actions: [
              FlatButton(
                child: Text(LocaleProvider.current.ok),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (loadingDialog != null) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }

  showConfirmationAlertDialog(
      BuildContext context, String title, String text, Widget okButton) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: R.color.defaultBlue,
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            actions: [
              okButton,
            ],
            content: Container(
              padding: const EdgeInsets.all(16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(text,
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
          );
        });
  }

  Widget getSquareBg(
      GlucoseData glucoseData, TextEditingController onChangedController) {
    return Container(
      alignment: Alignment.center,
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: UtilityManager()
            .getGlucoseMeasurementColor(int.parse(glucoseData.level)),
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(int.parse(
              glucoseData.level)), //                   <--- border color
          width: 5.0,
        ),
      ), //             <--- BoxDecoration here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            child: Theme(
              data: ThemeData(primaryColor: Colors.black),
              child: TextFormField(
                  controller: onChangedController,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  maxLength: 3,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    glucoseData.level = value;
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    errorStyle: TextStyle(height: 0),
                  ),
                  validator: (input) {
                    if (input.isNotEmpty)
                      return null;
                    else
                      return "";
                  }),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            "mg/dL",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }

  void showLoadingDialog(
      BuildContext context, LoadingDialog loadingDialog) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    return;
  }

  void hideLoadingDialog(BuildContext context, LoadingDialog loadingDialog) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
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

Widget closestAppointment(
    {BuildContext context, String date, Function selected}) {
  return Center(
    child: InkWell(
        child: Container(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                date,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: R.color.dark_black.withAlpha(25),
                    offset: Offset(2, 2))
              ],
              gradient: LinearGradient(
                  colors: [R.btnLightBlue, R.btnDarkBlue],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft)),
        ),
        onTap: () {
          selected(date);
        }),
  );
}

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
            width: context.WIDTH * .8,
            child: RichText(
              textScaleFactor: context.TEXTSCALE,
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
