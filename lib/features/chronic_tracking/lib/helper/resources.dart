import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

class Res {
  static final color = _Color();
  static final guide = _DeviceGuides();
  static final darkBlue = Color.fromRGBO(37, 48, 133, 1);
  static final backgroundColor = Color.fromRGBO(240, 240, 240, 1);
  static final grey = Color.fromRGBO(165, 165, 165, 1);
  static final darkYellow = Color.fromRGBO(255, 182, 0, 1);
  static final lightYellow = Color.fromRGBO(255, 220, 133, 1);
  static final circleBlue = Color.fromRGBO(133, 214, 255, 1);
  static final darkRed = Color.fromRGBO(219, 56, 50, 1);
  static final lightRed = Color.fromRGBO(232, 128, 124, 1);
  static final btnDarkBlue = Color.fromRGBO(37, 48, 133, 1);
  static final btnLightBlue = Color.fromRGBO(0, 0, 255, 1);
  static final drawerBgLightBlue = Color.fromRGBO(133, 214, 255, 1);
  static final regularBlue = Color.fromRGBO(0, 104, 255, 1);
}

class _Color {
  final very_high = Color(0xFFf4bb44);
  final high = Color(0xFFf7ec57);
  final target = Color(0xFF66c791);
  final low = Color(0xFFe98884);
  final very_low = Color(0xFFe2605b);
  final graph_plot_range = Color(0xFFCBEBD9);
  final gray = Color(0xFF969696);
  final grey = Color(0xFF696969);
  final state_color = Color(0xFF7a7a7a);
  final black = Color(0xFF333333);
  final white = Color(0xFFFFFFFF);
  final dark_black = Color(0xFF000000);
  final defaultBlue = Color.fromRGBO(0, 104, 255, 1);
  final light_blue = Color.fromRGBO(133, 214, 255, 1);
  final dark_blue = Color.fromRGBO(37, 48, 133, 1);
  final blue = Color.fromRGBO(0, 104, 255, 1);
  final light_dark_blue = Color.fromRGBO(0, 0, 255, 1);
  final dark_white = Color(0xFFE5E5E5);
  final background = Color(0xFFF0F0F0);
  final green_dashboard = Color(0xFFc2e9d1);
  final color = Color.fromRGBO(51, 51, 51, 1);
  final main_color = Color.fromRGBO(37, 48, 133, 1);
  final border_color = Color.fromRGBO(51, 51, 51, 1);
  final bg_gray = Color(0xFFF3F3F3);
  final chart_gray = Color(0xffDDDEDE);
}

class Routes {
  static const DOCTOR_HOME_PAGE = "doctor_home_page";
  static const ROOT_PAGE = "/";
  static const CHAT_WINDOW = "chat_window";
  static const PATIENT_DETAIL = "patient_detail";
  static const HOME_PAGE = "home_page";
  static const LOGIN_PAGE = "login_page";
  static const BG_PROGRESS_PAGE = "BG_PROGRESS_PAGE";
  static const SCALE_PROGRESS_PAGE = "SCALE_PROGRESS_PAGE";
  static const EMAIL_LOGIN_PAGE = "email_login_page";
  static const SIGN_UP_PAGE = "sign_up_page";
  static const PROFILES_PAGE = "profile_page";
  static const EDIT_PROFILE_PAGE = "edit_profile_page";
  static const MY_MEDICINES_PAGE = "my_medicines";
  static const BLE_SCANNER_PAGE = "ble_scanner";
  static const DEVICE_CONNECTIONS_PAGE = "device_connections";
  static const BLE_READING_TAGGER = "ble_reading_tagger";
  static const SETTINGS_PAGE = "settings";
  static const DOCTOR_DM_CHAT_PAGE = "doctor_dm_chat";
  static const PREMIUM_STORE_PAGE = "premium_store";
  static const MANUAL_ADD = "manual_add";
  static const BLE_TAGGER_LIST = "ble_tagger_list";
  static const CHAT_PAGE = "chat_page";
  static const DEPARTMENTS = "department_page";
  static const DOCTORS = "doctors_page";
  static const DOCTOR_DETAIL = "doctor_detail";
  static const APPOINTMENT = "appointment_page";
  static const APPOINTMENT_SUMMARY = "appointment_summary";
  static const PATIENT_APPOINTMENT = "patient_appointment";
  static const CREDIT_CARD = "credit_card_page";
  static const PAYMENT_RESPONSE = "payment_response";
  static const CONSULTATION_PAGE = "consultation_page";
  static const BLE_ACCU_CHEK_SCANNER_PAGE = "ble_scanner_accu_chek";
  static const ADDITIONAL_INFO = "additional_info";
  static const FILES = "files_page";
  static const FILE_VIEWER = "file_viewer";
  static const PAIRED_DEVICES = "paired_devices";
}

class _DeviceGuides {
  List<String> accu_check = [
    LocaleProvider.current.accu_check_step1,
    LocaleProvider.current.accu_check_step2,
    LocaleProvider.current.accu_check_step3,
    LocaleProvider.current.accu_check_step4,
  ];
  List<String> contour_plus_blood = [
    LocaleProvider.current.contour_plus_blood_step1,
    LocaleProvider.current.contour_plus_blood_step2,
    LocaleProvider.current.contour_plus_blood_step3,
    LocaleProvider.current.contour_plus_blood_step4,
  ];
  List<String> omron_arm = [
    LocaleProvider.current.omron_arm_step1,
    LocaleProvider.current.omron_arm_step2,
    LocaleProvider.current.omron_arm_step3,
    LocaleProvider.current.omron_arm_step4,
    LocaleProvider.current.omron_arm_step5,
  ];
  List<String> omron_wrist = [
    LocaleProvider.current.omron_wrist_step1,
    LocaleProvider.current.omron_wrist_step2,
    LocaleProvider.current.omron_wrist_step3,
    LocaleProvider.current.omron_wrist_step4,
    LocaleProvider.current.omron_wrist_step5,
  ];
  List<String> omron_scale = [
    LocaleProvider.current.omron_scale_step1,
    LocaleProvider.current.omron_scale_step2,
    LocaleProvider.current.omron_scale_step3,
    LocaleProvider.current.omron_scale_step4,
    LocaleProvider.current.omron_scale_step5,
  ];
  List<String> mi_scale = [
    LocaleProvider.current.mi_scale_step1,
    LocaleProvider.current.mi_scale_step2,
    LocaleProvider.current.mi_scale_step3,
    LocaleProvider.current.mi_scale_step4,
    LocaleProvider.current.mi_scale_step5,
  ];
}
