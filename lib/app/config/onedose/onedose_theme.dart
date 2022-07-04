part of '../abstract/app_config.dart';

class OneDoseTheme extends IAppTheme {
  @override
  ThemeType get type => ThemeType.green;

  @override
  IAppDialogTheme get dialogTheme => AppDialogThemeImpl();

  @override
  String get fontFamily => 'SourceSans';

  @override
  String get appLogo => 'assets/images/oneDose/onedose_logo.svg';

  @override
  String get successAppointmentImage => 'assets/images/oneDose/success_appointment.svg';

  @override
  double get appBarLogoHeight => 50;

  @override
  Color get mainColor => GuvenColors.green;

  @override
  Color get secondaryColor => GuvenColors.green2;

  @override
  Color get scaffoldBackgroundColor => const Color.fromARGB(255, 238, 238, 238);

  @override
  Color get textColor => Colors.white;

  @override
  Color get textColorSecondary => Colors.black;

  @override
  Color get textColorPassive => const Color.fromARGB(255, 187, 186, 186);

  @override
  Color get grey => Colors.grey;

  @override
  Color get cardBackgroundColor => GuvenColors.white;

  @override
  Color get blackForItem => Colors.black;

  @override
  Color get iconColor => Colors.black;

  @override
  Color get iconSecondaryColor => Colors.white;

  @override
  TextTheme get textTheme => TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(60),
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(55),
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headline3: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(50),
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(45),
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(40),
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(35),
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(30),
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        caption: TextStyle(
          color: Colors.black,
          fontSize: convertFontSize(25),
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
      );

  double convertFontSize(double value) => value / 2.85;

  @override
  Color get grayColor => const Color.fromARGB(255, 237, 237, 237);

  @override
  Color get bgGray => const Color(0xFFF3F3F3);

  @override
  Color get black => const Color(0xFF131313);

  @override
  Color get chartGray => const Color(0xffDDDEDE);

  @override
  Color get darkBlack => const Color(0xFF000000);

  @override
  Color get darkRed => const Color.fromRGBO(219, 56, 50, 1);

  @override
  Color get darkWhite => const Color(0xFFE5E5E5);

  @override
  Color get graphPlotRange => const Color(0xFFCBEBD9);

  @override
  Color get graphRangeColor => const Color(0xFFCBEBD9);

  @override
  Color get gray => const Color(0xFF969696);

  @override
  Color get high => const Color(0xFFf7ec57);

  @override
  Color get low => const Color(0xFFe98884);

  @override
  Color get stateColor => const Color(0xFF7a7a7a);

  @override
  Color get target => const Color(0xFF66c791);

  @override
  Color get veryHigh => const Color(0xFFf4bb44);

  @override
  Color get veryLow => const Color(0xFFe2605b);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get textContrastColor => Colors.black;

  @override
  Color get danisma => const Color(0xff65c0b8);

  @override
  Color get danismaLight => const Color(0xffafdfdb);

  @override
  Color get red => const Color(0xFFC74852);

  @override
  Color get lightRed => const Color(0xFFC74852);

  @override
  Color get darkRedGuven => const Color(0xFF862634);

  @override
  Color get onlineAppointment => const Color(0xFF100A9F);

  @override
  Color get lightOnlineAppointment => const Color(0xFF648DE5);

  @override
  Color get blue => const Color(0xFFBAECFF);

  @override
  Color get yellow => const Color(0xFFFFE57B);

  @override
  Color get pink => const Color(0xFFEBCAF3);

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
  int get eCouncilReportCardTitleBackground => 0xFFCAEAD8;
  @override
  Color get eCouncilScafoldBackground => const Color(0xFFEDEDED);

  // E-Konsey
}
