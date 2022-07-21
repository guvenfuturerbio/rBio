part of 'app_config.dart';

abstract class IAppTheme {
  TextTheme get textTheme;
  IAppDialogTheme dialogTheme = AppDialogThemeImpl();
  String get fontFamily;
  String get appLogo;
  String get successAppointmentImage;
  double get appBarLogoHeight;
  Color get appbarColor; // appBarTheme-backgroundColor
  Color get primaryColor; // primaryColor
  Color get secondaryColor;
  Color get textContrastColor;
  Color get checkboxBorderColor;
  Color get bottomMenuColor;
  Color get secondaryBackColor;
  Color get mainOverColor;

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

  // #region eCouncil
  Color eCouncilPendingApproval = R.colors.boulder;
  Color eCouncilPendingPayment = R.colors.supernova;
  Color eCouncilPendingInspection = R.colors.malibu;
  Color eCouncilRejected = R.colors.punch;
  Color eCouncilAppointmentReady = R.colors.greenHaze;
  Color eCouncilReportCardTitleBackground = R.colors.skeptic;
  Color eCouncilScafoldBackground = R.colors.gallery;
  // #endregion
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
