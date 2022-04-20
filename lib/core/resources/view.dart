// ignore_for_file: non_constant_identifier_names

part of 'resources.dart';

class GuvenColors {
  GuvenColors._();

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color green = Color.fromARGB(255, 0, 158, 71);
  static const Color green2 = Color.fromARGB(255, 202, 234, 216);
  static const Color grey = Color.fromARGB(255, 238, 238, 238);
  static const Color burgundy = Color.fromARGB(255, 134, 39, 52);
  static const Color burgundy2 = Color(0xffaa6871);
}

// class _Color {
//   final gray = const Color(0xFF969696);
//   final grey = const Color(0xFF696969);
//   final black = const Color(0xFF131313);
//   final white = const Color(0xFFFFFFFF);
//   final dark_black = const Color(0xFF000000);
//   final dark_white = const Color(0xFFE5E5E5);

//   final very_high = const Color(0xFFf4bb44);
//   final high = const Color(0xFFf7ec57);
//   final target = const Color(0xFF66c791);
//   final low = const Color(0xFFe98884);
//   final very_low = const Color(0xFFe2605b);
//   final graph_plot_range = const Color(0xFFCBEBD9);
//   final state_color = const Color(0xFF7a7a7a);
//   final bg_gray = const Color(0xFFF3F3F3);
//   final chart_gray = const Color(0xffDDDEDE);
//   final darkRed = const Color.fromRGBO(219, 56, 50, 1);
//   final graphRangeColor = const Color(0xFFCBEBD9);

//   final warning = const Color.fromARGB(255, 244, 183, 63);
// }

class _Sizes {
  final double _mobilePadding = 12;
  final double _tabletPadding = 24;
  final double _desktopPadding = 48;

  T screenHandler<T>(
    BuildContext context, {
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < 576) {
      return mobile;
    } else if (width >= 576 && width < 850) {
      return tablet;
    } else {
      return desktop;
    }
  }

  T textScaleHandler<T>(
    BuildContext context, {
    required T small,
    required T medium,
    required T large,
  }) {
    final textScale = context.xTextScaleType;
    switch (textScale) {
      case TextScaleType.small:
        return small;

      case TextScaleType.medium:
        return medium;

      case TextScaleType.large:
        return large;
      default:
        return small;
    }
  }

  Widget textScaleBuilder(
    BuildContext context, {
    required Widget smallWidget,
    required Widget largeWidget,
  }) =>
      context.xTextScaleType == TextScaleType.small ? smallWidget : largeWidget;

  EdgeInsets screenPadding(BuildContext context) {
    return screenHandler<EdgeInsets>(
      context,
      mobile: EdgeInsets.only(
        left: _mobilePadding,
        right: _mobilePadding,
        top: 12,
      ),
      tablet: EdgeInsets.only(
        left: _tabletPadding,
        right: _tabletPadding,
        top: 12,
      ),
      desktop: EdgeInsets.only(
        left: _desktopPadding,
        right: _desktopPadding,
        top: 12,
      ),
    );
  }

  EdgeInsets screenPaddingOnlyHorizontal(BuildContext context) {
    return screenHandler<EdgeInsets>(
      context,
      mobile: EdgeInsets.only(
        left: _mobilePadding,
        right: _mobilePadding,
      ),
      tablet: EdgeInsets.only(
        left: _tabletPadding,
        right: _tabletPadding,
      ),
      desktop: EdgeInsets.only(
        left: _desktopPadding,
        right: _desktopPadding,
      ),
    );
  }

  double get defaultBottomValue => Atom.safeBottom + 12;
  Widget get defaultBottomPadding => SizedBox(height: defaultBottomValue);
  double stackedTopPaddingValue(BuildContext context) =>
      54 + MediaQuery.of(context).viewPadding.top;
  Widget stackedTopPadding(BuildContext context) =>
      SizedBox(height: 54 + MediaQuery.of(context).viewPadding.top);
  double get bottomNavigationBarHeight => Atom.safeBottom + 65;

  final double defaultElevation = 0.0;

  final Widget hSizer4 = const SizedBox(height: 4);
  final Widget hSizer8 = const SizedBox(height: 8);
  final Widget hSizer12 = const SizedBox(height: 12);
  final Widget hSizer16 = const SizedBox(height: 16);
  final Widget hSizer20 = const SizedBox(height: 20);
  final Widget hSizer24 = const SizedBox(height: 24);
  final Widget hSizer28 = const SizedBox(height: 28);
  final Widget hSizer32 = const SizedBox(height: 32);
  final Widget hSizer36 = const SizedBox(height: 36);
  final Widget hSizer40 = const SizedBox(height: 40);

  final Widget wSizer4 = const SizedBox(width: 4);
  final Widget wSizer8 = const SizedBox(width: 8);
  final Widget wSizer12 = const SizedBox(width: 12);
  final Widget wSizer16 = const SizedBox(width: 16);
  final Widget wSizer20 = const SizedBox(width: 20);
  final Widget wSizer24 = const SizedBox(width: 24);
  final Widget wSizer28 = const SizedBox(width: 28);
  final Widget wSizer32 = const SizedBox(width: 32);
  final Widget wSizer36 = const SizedBox(width: 36);
  final Widget wSizer40 = const SizedBox(width: 40);

  // BorderRadius
  final BorderRadius borderRadiusCircular = BorderRadius.circular(12);

  // Icons
  final double iconSize = 30;
  final double iconSize2 = 24;
  final double iconSize3 = 18;
  final double iconSize4 = 14;
  final double iconSize5 = 10;
}
