part of 'atom.dart';

extension UIExtensions on Atom {
  bool get isWeb => kIsWeb;
  bool get isDebugMode => kDebugMode;
  bool get isProfileMode => kProfileMode;
  bool get isReleaseMode => kReleaseMode;

  bool get isAndroid => Platform.isAndroid;
  bool get isFuchsia => Platform.isFuchsia;
  bool get isIOS => Platform.isIOS;
  bool get isLinux => Platform.isLinux;
  bool get isMacOS => Platform.isMacOS;
  bool get isWindows => Platform.isWindows;

  /// The window to which this binding is bound.
  ui.SingletonFlutterWindow get window => ui.window;

  Locale get deviceLocale => ui.window.locale;

  ///The number of device pixels for each logical pixel.
  double get pixelRatio => ui.window.devicePixelRatio;

  Size get size => ui.window.physicalSize / pixelRatio;

  ///The horizontal extent of this size.
  double get width => size.width;

  ///The vertical extent of this size
  double get height => size.height;

  ///The distance from the top edge to the first unpadded pixel,
  ///in physical pixels.
  double get statusBarHeight => ui.window.padding.top;

  ///The distance from the bottom edge to the first unpadded pixel,
  ///in physical pixels.
  double get bottomBarHeight => ui.window.padding.bottom;

  ///The system-reported text scale.
  double get textScaleFactor => ui.window.textScaleFactor;

  ThemeData get theme => Theme.of(this.ctx);

  /// give access to TextTheme.of(context)
  TextTheme get textTheme => theme.textTheme;

  /// give access to Mediaquery.of(context)
  MediaQueryData get mediaQuery => MediaQuery.of(this.ctx);

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);

  /// Check if dark mode theme is enable on platform on android Q+
  bool get isPlatformDarkMode =>
      (ui.window.platformBrightness == Brightness.dark);

  /// give access to Theme.of(context).iconTheme.color
  Color get iconColor => theme.iconTheme.color;

  /// give access to FocusScope.of(context)
  FocusNode get focusScope => FocusManager.instance.primaryFocus;

  // /// give access to Immutable MediaQuery.of(context).size.height
  // double get height => MediaQuery.of(context).size.height;

  // /// give access to Immutable MediaQuery.of(context).size.width
  // double get width => MediaQuery.of(context).size.width;
}
