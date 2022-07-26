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
  BottomNavigationBarThemeData get bottomNavigationBarTheme;
  // * IconTheme
  IconThemeData get iconTheme;
  // * FloatingActionButtonTheme
  FloatingActionButtonThemeData get floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      );
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
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: textTheme.headline2,
        ),
      );
  // * Selected Theme
  AppSelectionTheme get selectionTheme;
  // * MyCustomTheme
  MyCustomTheme xMyCustomTheme = MyCustomTheme(
    iron: R.colors.iron,
    grey: R.colors.grey,
    white: R.colors.white,
    black: R.colors.black,
    punch: R.colors.punch,
    roman: R.colors.roman,
    malibu: R.colors.malibu,
    deYork: R.colors.deYork,
    skeptic: R.colors.skeptic,
    boulder: R.colors.boulder,
    mercury: R.colors.mercury,
    codGray: R.colors.codGray,
    gallery: R.colors.gallery,
    concrete: R.colors.concrete,
    supernova: R.colors.supernova,
    tonysPink: R.colors.tonysPink,
    dustyGray: R.colors.dustyGray,
    greenHaze: R.colors.greenHaze,
    casablanca: R.colors.casablanca,
    frenchPass: R.colors.frenchPass,
    kournikova: R.colors.kournikova,
    ultramarine: R.colors.ultramarine,
    frenchLilac: R.colors.frenchLilac,
    textDisabledColor: R.colors.silver,
    energyYellow: R.colors.energyYellow,
    cornflowerBlue: R.colors.cornflowerBlue,
    fuzzyWuzzyBrown: R.colors.fuzzyWuzzyBrown,
  );

  double convertFontSize(double value) => value / 2.85;
}

// ! ------------------ ------------------ IAppDialogTheme ------------------ ------------------

abstract class IAppDialogTheme {
  TextStyle title(BuildContext context);
  TextStyle description(BuildContext context);
  TextStyle subTitle(BuildContext context);
  TextStyle button(BuildContext context);
}

class AppDialogThemeImpl extends IAppDialogTheme {
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

// ! ------------------ ------------------ AppSelectionTheme ------------------ ------------------

abstract class AppSelectionTheme {
  Color get unSelectedBackColor;
  Color get unSelectedIconColor;
  Color get unSelectedTextColor;
  Color get selectedBackColor;
  Color get selectedIconColor;
  Color get selectedTextColor;
}

// ! ------------------ ------------------ MyCustomTheme ------------------ ------------------

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
