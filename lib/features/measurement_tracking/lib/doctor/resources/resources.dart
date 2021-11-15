import 'package:flutter/material.dart';

class R {
  static final image = _Images();
  static final color = _Color();
}

class _Images {
  final appbar = "assets/images/usttab.svg";
  final back_icon = 'assets/images/back_icon.svg';
  final beforeMeal = "assets/images/before_meal_black.svg";
  final afterMeal = "assets/images/after_meal_black.svg";
  final other = "assets/images/other_black.svg";
  final search = "assets/images/ic_search.svg";
  final back = "assets/images/back_icon.svg";
  final changeGraph = "assets/images/change_graph.svg";
  final oneDoseLogoAlpha5 = "assets/images/one_dose_logo_green_5.png";
  final stethoscope = "assets/images/stethoscope.svg";
  final largeGreenBar = "assets/images/blue_signin_topbar.svg";
  final oneDoseLogo = "assets/images/ods_logo.svg";
}

class _Color {
  final veryHigh = Color(0xFFFFB600);
  final high = Color(0xFFFFDC85);
  final target = Color(0xFF66C791);
  final low = Color(0xFFE8807C);
  final veryLow = Color(0xFFDB3832);
  final text = Color(0xFF333333);
  final title = Color(0xFFa5a5a5);
  final white = Colors.white;
  final mainColor = Color.fromRGBO(37, 48, 133, 1);
  final graphRangeColor = Color(0xFFCBEBD9);
  final stateColor = Color(0xFF7a7a7a);
  final black = Color(0xFF333333);
  final regularBlue = Color.fromRGBO(0, 104, 255, 1);
}

class Routes {
  static const HOME_PAGE = "home_page";
  static const PATIENT_DETAIL = "patient_detail";
}
