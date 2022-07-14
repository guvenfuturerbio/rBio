part of '../abstract/app_config.dart';

class GuvenTheme extends IAppTheme {
  @override
  String fontFamily = R.constants.fontPoppins;

  @override
  String appLogo = R.constants.guvenAppLogo;

  @override
  String successAppointmentImage = R.constants.guvenSuccessAppointmentImage;

  @override
  double appBarLogoHeight = 40;

  @override
  Color mainColor = R.colors.burntUmber;

  @override
  Color secondaryColor = R.colors.coralTree;

  @override
  Color textContrastColor = R.colors.white;

  // E-Konsey
  @override
  Color get eCouncilPendingApproval => const Color(0xFF787878);
  @override
  Color get eCouncilPendingPayment => const Color(0xFFFFCD00);
  @override
  Color get eCouncilPendingInspection => const Color(0xFF5CD2FF);
  @override
  Color get eCouncilRejected => const Color(0xFFD93832);
  @override
  Color get eCouncilAppointmentReady => const Color(0xFF00A147);
  @override
  Color get eCouncilReportCardTitleBackground => const Color(0xFFCAEAD8);
  @override
  Color get eCouncilScafoldBackground => const Color(0xFFEDEDED);

  // E-Konsey
}
