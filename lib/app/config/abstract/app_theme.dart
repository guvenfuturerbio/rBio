part of 'app_config.dart';

abstract class IAppTheme {
  IAppTheme() {
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

  late TextTheme textTheme;
  IAppDialogTheme dialogTheme = AppDialogThemeImpl();
  String get fontFamily;
  String get appLogo;
  String get successAppointmentImage;
  double get appBarLogoHeight;
  Color get mainColor;
  Color get secondaryColor;
  Color get textContrastColor;

  // ! --------- --------- Common --------- ---------
  Color grey = R.colors.grey;
  Color blue = R.colors.frenchPass;
  Color yellow = R.colors.kournikova;
  Color pink = R.colors.frenchLilac;
  Color scaffoldBackgroundColor = R.colors.gallery;
  Color textColor = R.colors.white;
  Color textColorSecondary = R.colors.black;
  Color textColorPassive = R.colors.silver;
  Color cardBackgroundColor = R.colors.white;
  Color blackForItem = R.colors.black;
  Color iconColor = R.colors.black;
  Color iconSecondaryColor = R.colors.white;
  Color grayColor = R.colors.gallery;
  Color danisma = R.colors.fountainBlue;
  Color danismaLight = R.colors.aquaIsland;
  Color red = R.colors.fuzzyWuzzyBrown;
  Color lightRed = R.colors.fuzzyWuzzyBrown;
  Color darkRedGuven = R.colors.burntUmber;
  Color onlineAppointment = R.colors.ultramarine;
  Color lightOnlineAppointment = R.colors.cornflowerBlue;
  Color darkBlack = R.colors.black;
  Color darkRed = R.colors.punch;
  Color darkWhite = R.colors.mercury;
  Color black = R.colors.codGray;
  Color gray = R.colors.dustyGray;
  Color white = R.colors.white;
  Color high = R.colors.energyYellow;
  Color veryHigh = R.colors.casablanca;
  Color target = R.colors.deYork;
  Color low = R.colors.tonysPink;
  Color veryLow = R.colors.roman;
  Color stateColor = R.colors.boulder;
  Color bgGray = R.colors.concrete;
  Color chartGray = R.colors.iron;
  Color graphPlotRange = R.colors.skeptic;
  Color graphRangeColor = R.colors.skeptic;
  double convertFontSize(double value) => value / 2.85;
}

abstract class IAppDialogTheme {
  Color get backgroundColor;
  TextStyle title(BuildContext context);
  TextStyle description(BuildContext context);
  TextStyle subTitle(BuildContext context);
  TextStyle button(BuildContext context);
}

class AppDialogThemeImpl extends IAppDialogTheme {
  @override
  Color get backgroundColor => getIt<IAppConfig>().theme.cardBackgroundColor;

  @override
  TextStyle button(BuildContext context) => context.xHeadline4;

  @override
  TextStyle description(BuildContext context) => context.xHeadline3;

  @override
  TextStyle subTitle(BuildContext context) => context.xHeadline4;

  @override
  TextStyle title(BuildContext context) => context.xHeadline2.copyWith(
        fontWeight: FontWeight.bold,
      );
}
