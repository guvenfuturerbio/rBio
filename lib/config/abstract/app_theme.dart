part of 'app_config.dart';

abstract class IAppTheme {
  TextTheme get textTheme;
  String get fontFamily;
  String get appLogo;
  String get successAppointmentImage;
  double get appBarLogoHeight;
  IAppDialogTheme dialogTheme = AppDialogThemeImpl();

  // ! ThemeData
  // * Main
  Brightness get brightness; // brightness
  Color get primaryColor; // primaryColor
  Color get scaffoldBackgroundColor;
  // * ColorScheme
  Color get secondaryColor; // colorScheme-secondary
  Color get textColor; // colorScheme-primary
  Color get inverseTextColor; // colorScheme-inversePrimary
  Color get onPrimaryTextColor; // colorScheme-onPrimary
  Color get secondaryContainerColor; // colorScheme-secondaryContainer
  // * CardTheme
  Color get cardBackgroundColor; // cardTheme-color
  // * AppBarTheme
  Color get appbarColor; // appBarTheme-backgroundColor
  Color get appbarTextColor; // appBarTheme-titleTextStyle-color
  Color get appbarIconColor; // appBarTheme-iconTheme-color
  // * BottomNavigationBarTheme
  Color get bottomMenuColor; // bottomNavigationBarTheme-backgroundColor
  // * IconTheme
  Color get iconColor; // iconTheme-color
  // * FloatingActionButtonTheme
  Color get fabBackgroundColor =>
      primaryColor; // floatingActionButtonTheme-backgroundColor
  // * TextSelectionTheme
  TextSelectionThemeData get textSelectionTheme => TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: primaryColor,
        selectionHandleColor: primaryColor,
      );
  // * CupertinoTheme
  CupertinoThemeData get cupertinoTheme => CupertinoThemeData(
        primaryColor: primaryColor,
        brightness: brightness,
      );
  // * MyCustomTheme
  Color iron = R.colors.iron;
  Color grey = R.colors.grey;
  Color white = R.colors.white;
  Color black = R.colors.black;
  Color punch = R.colors.punch;
  Color roman = R.colors.roman;
  Color malibu = R.colors.malibu;
  Color deYork = R.colors.deYork;
  Color skeptic = R.colors.skeptic;
  Color boulder = R.colors.boulder;
  Color mercury = R.colors.mercury;
  Color codGray = R.colors.codGray;
  Color gallery = R.colors.gallery;
  Color concrete = R.colors.concrete;
  Color supernova = R.colors.supernova;
  Color tonysPink = R.colors.tonysPink;
  Color dustyGray = R.colors.dustyGray;
  Color greenHaze = R.colors.greenHaze;
  Color casablanca = R.colors.casablanca;
  Color frenchPass = R.colors.frenchPass;
  Color kournikova = R.colors.kournikova;
  Color ultramarine = R.colors.ultramarine;
  Color frenchLilac = R.colors.frenchLilac;
  Color textDisabledColor = R.colors.silver;
  Color energyYellow = R.colors.energyYellow;
  Color cornflowerBlue = R.colors.cornflowerBlue;
  Color fuzzyWuzzyBrown = R.colors.fuzzyWuzzyBrown;

  double convertFontSize(double value) => value / 2.85;
}

abstract class IAppDialogTheme {
  Color backgroundColor(BuildContext context);
  TextStyle title(BuildContext context);
  TextStyle description(BuildContext context);
  TextStyle subTitle(BuildContext context);
  TextStyle button(BuildContext context);
}

class AppDialogThemeImpl extends IAppDialogTheme {
  @override
  Color backgroundColor(BuildContext context) => context.xCardColor;

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

@immutable
class MyCustomTheme {
  final Color iron;
  final Color grey;
  final Color white;
  final Color black;
  final Color punch;
  final Color roman;
  final Color malibu;
  final Color deYork;
  final Color skeptic;
  final Color boulder;
  final Color mercury;
  final Color codGray;
  final Color gallery;
  final Color concrete;
  final Color supernova;
  final Color tonysPink;
  final Color dustyGray;
  final Color greenHaze;
  final Color casablanca;
  final Color frenchPass;
  final Color kournikova;
  final Color ultramarine;
  final Color frenchLilac;
  final Color textDisabledColor;
  final Color energyYellow;
  final Color cornflowerBlue;
  final Color fuzzyWuzzyBrown;

  const MyCustomTheme({
    required this.iron,
    required this.grey,
    required this.white,
    required this.black,
    required this.punch,
    required this.roman,
    required this.malibu,
    required this.deYork,
    required this.skeptic,
    required this.boulder,
    required this.mercury,
    required this.codGray,
    required this.gallery,
    required this.concrete,
    required this.supernova,
    required this.tonysPink,
    required this.dustyGray,
    required this.greenHaze,
    required this.casablanca,
    required this.frenchPass,
    required this.kournikova,
    required this.ultramarine,
    required this.frenchLilac,
    required this.textDisabledColor,
    required this.energyYellow,
    required this.cornflowerBlue,
    required this.fuzzyWuzzyBrown,
  });

  static MyCustomTheme of(BuildContext context) {
    return Theme.of(context).own();
  }
}

extension MyCustomThemeExtensions on ThemeData {
  static late MyCustomTheme _customTheme;

  void addCustomTheme(MyCustomTheme own) {
    _customTheme = own;
  }

  MyCustomTheme own() {
    return _customTheme;
  }
}

enum AppThemeTypes {
  oneDoseLight,
  oneDoseDark,
  guvenLight,
}

extension AppThemeTypesStringExt on String {
  AppThemeTypes? get xThemeKeys => AppThemeTypes.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension AppThemeTypesExt on AppThemeTypes {
  String get xRawValue => toString().split('.').last;
}
