import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../../generated/l10n.dart';
import '../models/person_model.dart';

export 'package:onedosehealth/core/enums/shared_preferences_keys.dart';
export 'package:onedosehealth/core/locator.dart';
export 'package:onedosehealth/core/manager/shared_preferences_manager.dart';
export 'package:onedosehealth/generated/l10n.dart';
export 'package:onedosehealth/core/core.dart';

export '../common/mediminder_common.dart';
export '../common/timezone.dart';
export '../enum/medicine_period.dart';
export '../enum/remindable.dart';
export '../enum/unit.dart';
export '../enum/usage_type.dart';
export '../managers/local_notifications_manager.dart';
export '../models/drug_result_model.dart';
export '../models/hba1c_for_schedule_model.dart';
export '../models/medicine_for_schedule_model.dart';
export '../models/person_model.dart';
export '../models/selectable_day.dart';
export '../models/strip_detail_model.dart';
export '../ui/hba1c/hba1c_reminder_add_screen.dart';
export '../ui/hba1c/hba1c_reminder_add_vm.dart';
export '../ui/hba1c/hba1c_reminderlist_screen.dart';
export '../ui/hba1c/hba1c_reminderlist_vm.dart';
export '../ui/home_mediminder_screen.dart';
export '../ui/medication/medication_date_screen.dart';
export '../ui/medication/medication_date_vm.dart';
export '../ui/medication/medication_period_selection_screen.dart';
export '../ui/medication/medication_screen.dart';
export '../ui/medication/medication_vm.dart';
export '../ui/strip/strip_counter_dialog.dart';
export '../ui/strip/strip_screen.dart';
export '../ui/strip/strip_vm.dart';
export '../widget/keyboard_dismiss_on_tap.dart';

class Mediminder {
  Mediminder._();

  static Mediminder _instance;

  static Mediminder get instance {
    _instance ??= Mediminder._();
    return _instance;
  }

  PersonModel selection = PersonModel(
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

  final MY_MEDICINES_PAGE = "my_medicines";

  final gray = Color(0xFF969696);
  final grey = Color(0xFF696969);
  final black = Color(0xFF333333);
  final white = Color(0xFFFFFFFF);
  final dark_black = Color(0xFF000000);
  final defaultBlue = Color.fromRGBO(0, 104, 255, 1);
  final dark_white = Color(0xFFE5E5E5);
  final bg_gray = Color(0xFFF3F3F3);
  final btnDarkBlue = Color.fromRGBO(37, 48, 133, 1);
  final btnLightBlue = Color.fromRGBO(0, 0, 255, 1);
  final mainColor = Color.fromRGBO(37, 48, 133, 1);

  final back_icon = 'assets/images/back_icon.svg';
  final done_icon = 'assets/images/done_icon.svg';
  final add_icon = 'assets/images/add_icon.svg';
  final delete_white_garbage = "assets/images/delete_white_garbage.svg";
  final ic_user = 'assets/images/ic_user.svg';
  final mark_icon = 'assets/images/mark_icon.svg';
  final blood_icon_black = "assets/images/blood_icon_black.svg";
  final strip_icon_black = "assets/images/strip_icon_black.svg";
  final medicine_icon_black = "assets/images/medicine_icon_black.svg";
  final hba1c_icon_black = "assets/images/hba1c_icon_black.svg";
  final stethoscope = "assets/images/stethoscope.svg";

  GradientButton buttonDarkGradient({
    text: String,
    Function onPressed,
    double height,
    double width,
  }) =>
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
          colors: <Color>[
            btnLightBlue,
            btnDarkBlue,
          ],
        ),
        shadowColor: Colors.black,
      );

  TextStyle inputTextStyle() => TextStyle(
        fontSize: 16,
        color: Mediminder.instance.dark_black,
      );

  InputDecoration inputImageDecoration({
    image: String,
    hintText: String,
  }) =>
      InputDecoration(
        contentPadding: EdgeInsets.all(8),
        prefixIcon: SvgPicture.asset(
          image,
          fit: BoxFit.none,
        ),
        focusedBorder: borderTextField(),
        border: borderTextField(),
        enabledBorder: borderTextField(),
        hintText: hintText,
        fillColor: Colors.white,
        hintStyle: hintStyle(),
      );

  InputBorder borderTextField() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(200),
        borderSide: BorderSide(
          width: 1,
          style: BorderStyle.solid,
          color: Mediminder.instance.dark_white,
        ),
      );

  TextStyle hintStyle() => TextStyle(
        fontSize: 16,
        color: Mediminder.instance.gray,
      );
}

extension StringExtension on String {
  String format(List<String> params) => interpolate(this, params);
}

String interpolate(String string, List<String> params) {
  String result = string;
  for (int i = 1; i < params.length + 1; i++) {
    result = result.replaceAll('%${i}\$', params[i - 1]);
  }

  return result;
}

class GradientDialog extends StatefulWidget {
  final String title;
  final String text;

  GradientDialog(this.title, this.text);

  @override
  _GradientDialogState createState() => _GradientDialogState();
}

class _GradientDialogState extends State<GradientDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      style: TextButton.styleFrom(primary: Mediminder.instance.white),
      child: Text(LocaleProvider.current.ok),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: Mediminder.instance.mainColor,
      contentPadding: EdgeInsets.all(0.0),
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
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
            Text(
              widget.text,
              style: new TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressDialog extends StatefulWidget {
  static _ProgressDialogState state;

  bool isShowing() {
    return state != null && state.mounted;
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
      insetPadding: EdgeInsets.all(10),
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
    Key key,
    double value,
    Color backgroundColor,
    Animation valueColor,
    String semanticsLabel,
    String semanticsValue,
  }) =>
      ShakeAnimatedWidget(
        enabled: true,
        duration: Duration(milliseconds: 1500),
        shakeAngle: Rotation.deg(z: 10),
        curve: Curves.linear,
        child: Container(
          width: 80,
          height: 80,
          child: SvgPicture.asset(Mediminder.instance.stethoscope),
        ),
      );

  Gradient blueGradient() => LinearGradient(
        colors: [
          Colors.black12,
          Colors.black12,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
      );
}
