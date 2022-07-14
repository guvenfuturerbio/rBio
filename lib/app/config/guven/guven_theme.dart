part of '../abstract/app_config.dart';

class GuvenTheme extends IAppTheme {
  GuvenTheme() {
    textTheme = TextTheme(
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
  }

  @override
  IAppDialogTheme dialogTheme = AppDialogThemeImpl();

  @override
  String fontFamily = R.constants.fontPoppins;

  @override
  String appLogo = R.constants.guvenAppLogo;

  @override
  String successAppointmentImage = R.constants.guvenSuccessAppointmentImage;

  @override
  double appBarLogoHeight = 40;

  @override
  Color mainColor = R.colors.burgundy;

  @override
  Color secondaryColor = R.colors.burgundy2;

  @override
  Color scaffoldBackgroundColor = const Color.fromARGB(255, 238, 238, 238);

  @override
  Color textColor = Colors.white;

  @override
  Color textColorSecondary = Colors.black;

  @override
  Color textColorPassive = const Color.fromARGB(255, 187, 186, 186);

  @override
  Color grey = Colors.grey;

  @override
  Color cardBackgroundColor = R.colors.white;

  @override
  Color blackForItem = Colors.black;

  @override
  Color iconColor = Colors.black;

  @override
  Color iconSecondaryColor = Colors.white;

  @override
  late TextTheme textTheme;

  double convertFontSize(double value) => value / 2.85;

  @override
  Color grayColor = const Color.fromARGB(255, 237, 237, 237);

  @override
  Color bgGray = const Color(0xFFF3F3F3);

  @override
  Color black = const Color(0xFF131313);

  @override
  Color chartGray = const Color(0xffDDDEDE);

  @override
  Color darkBlack = const Color(0xFF000000);

  @override
  Color darkRed = const Color.fromRGBO(219, 56, 50, 1);

  @override
  Color darkWhite = const Color(0xFFE5E5E5);

  @override
  Color graphPlotRange = const Color(0xFFCBEBD9);

  @override
  Color graphRangeColor = const Color(0xFFCBEBD9);

  @override
  Color gray = const Color(0xFF969696);

  @override
  Color high = const Color(0xFFf7ec57);

  @override
  Color low = const Color(0xFFe98884);

  @override
  Color stateColor = const Color(0xFF7a7a7a);

  @override
  Color target = const Color(0xFF66c791);

  @override
  Color veryHigh = const Color(0xFFf4bb44);

  @override
  Color veryLow = const Color(0xFFe2605b);

  @override
  Color white = const Color(0xFFFFFFFF);

  @override
  Color textContrastColor = Colors.white;

  @override
  Color danisma = const Color(0xff65c0b8);

  @override
  Color danismaLight = const Color(0xffafdfdb);

  @override
  Color red = const Color(0xFFC74852);

  @override
  Color lightRed = const Color(0xFFC74852);

  @override
  Color darkRedGuven = const Color(0xFF862634);

  @override
  Color onlineAppointment = const Color(0xFF100A9F);

  @override
  Color lightOnlineAppointment = const Color(0xFF648DE5);

  @override
  Color blue = const Color(0xFFBAECFF);

  @override
  Color yellow = const Color(0xFFFFE57B);

  @override
  Color pink = const Color(0xFFEBCAF3);
}
