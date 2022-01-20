part of 'constants.dart';

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

class _Sizes {
  double _mobilePadding = 12;
  double _tabletPadding = 24;
  double _desktopPadding = 48;

  T screenHandler<T>(
    BuildContext context, {
    @required T mobile,
    @required T tablet,
    @required T desktop,
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
    @required T small,
    @required T medium,
    @required T large,
  }) {
    final textScale = context.xTextScaleType;
    switch (textScale) {
      case TextScaleType.Small:
        return small;

      case TextScaleType.Medium:
        return medium;

      case TextScaleType.Large:
        return large;
    }

    return small;
  }

  Widget textScaleBuilder(
    BuildContext context, {
    @required Widget smallWidget,
    @required Widget largeWidget,
  }) =>
      context.xTextScaleType == TextScaleType.Small ? smallWidget : largeWidget;

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

  double get defaultBottomValue => Atom.safeBottom + 12;
  Widget get defaultBottomPadding => SizedBox(height: defaultBottomValue);
  Widget stackedTopPadding(BuildContext context) =>
      SizedBox(height: 54 + MediaQuery.of(context).viewPadding.top);

  final Widget hSizer4 = SizedBox(height: 4);
  final Widget hSizer8 = SizedBox(height: 8);
  final Widget hSizer12 = SizedBox(height: 12);
  final Widget hSizer16 = SizedBox(height: 16);
  final Widget hSizer20 = SizedBox(height: 20);
  final Widget hSizer24 = SizedBox(height: 24);
  final Widget hSizer28 = SizedBox(height: 28);
  final Widget hSizer32 = SizedBox(height: 32);
  final Widget hSizer36 = SizedBox(height: 36);
  final Widget hSizer40 = SizedBox(height: 40);

  final Widget wSizer4 = SizedBox(width: 4);
  final Widget wSizer8 = SizedBox(width: 8);
  final Widget wSizer12 = SizedBox(width: 12);
  final Widget wSizer16 = SizedBox(width: 16);
  final Widget wSizer20 = SizedBox(width: 20);
  final Widget wSizer24 = SizedBox(width: 24);
  final Widget wSizer28 = SizedBox(width: 28);
  final Widget wSizer32 = SizedBox(width: 32);
  final Widget wSizer36 = SizedBox(width: 36);
  final Widget wSizer40 = SizedBox(width: 40);

  // BorderRadius
  final BorderRadiusGeometry borderRadiusCircular = BorderRadius.circular(12);

  // Icons
  final double iconSize = 30;
  final double iconSize2 = 24;
  final double iconSize3 = 18;
  final double iconSize4 = 14;
  final double iconSize5 = 10;
}

class _Color {
  final gray = Color(0xFF969696);
  final grey = Color(0xFF696969);
  final black = Color(0xFF131313);
  final white = Color(0xFFFFFFFF);
  final dark_black = Color(0xFF000000);
  final blue = getIt<ITheme>().mainColor; // Color(0xFFC74852);
  final light_blue = Color(0xFFE18B94);
  final dark_blue = Color(0xFF862634);
  final dark_white = Color(0xFFE5E5E5);
  final online_appointment = Color(0xFF100A9F);
  final light_online_appointment = Color(0xFF648DE5);
  final online_appointment_text = Color(0xFFFFFFFF);
  final ayranci = Color(0xFF63C1B8);
  final light_ayranci = Color(0xFFB7DBD8);
  final ayranci_text = Color(0xFF000000);
  final cayyolu = Color(0xFFFF6F59);
  final light_cayyolu = Color(0xFFF0B7AB);
  final cayyolu_text = Color(0xFFFFFFFF);
  final danisma = Color(0xff65c0b8);
  final danisma_light = Color(0xffafdfdb);

  final text = Color(0xFF333333);
  final title = Color(0xFFa5a5a5);
  final mainColor = Color.fromRGBO(37, 48, 133, 1);
  final graphRangeColor = Color(0xFFCBEBD9);
  final btnDarkBlue = Color.fromRGBO(37, 48, 133, 1);
  final btnLightBlue = Color.fromRGBO(0, 0, 255, 1);

  // from OneDoseRepo
  final very_high = Color(0xFFf4bb44);
  final high = Color(0xFFf7ec57);
  final target = Color(0xFF66c791);
  final low = Color(0xFFe98884);
  final very_low = Color(0xFFe2605b);
  final graph_plot_range = Color(0xFFCBEBD9);
  final state_color = Color(0xFF7a7a7a);
  final defaultBlue = Color.fromRGBO(0, 104, 255, 1);
  final light_dark_blue = Color.fromRGBO(0, 0, 255, 1);
  final background = Color(0xFFF0F0F0);
  final green_dashboard = Color(0xFFc2e9d1);
  final color = Color.fromRGBO(51, 51, 51, 1);
  final main_color = Color.fromRGBO(37, 48, 133, 1);
  final border_color = Color.fromRGBO(51, 51, 51, 1);
  final bg_gray = Color(0xFFF3F3F3);
  final chart_gray = Color(0xffDDDEDE);
  final darkBlue = Color.fromRGBO(37, 48, 133, 1);
  final backgroundColor = Color.fromRGBO(240, 240, 240, 1);
  final darkYellow = Color.fromRGBO(255, 182, 0, 1);
  final lightYellow = Color.fromRGBO(255, 220, 133, 1);
  final circleBlue = Color.fromRGBO(133, 214, 255, 1);
  final darkRed = Color.fromRGBO(219, 56, 50, 1);
  final lightRed = Color.fromRGBO(232, 128, 124, 1);
  final drawerBgLightBlue = Color.fromRGBO(133, 214, 255, 1);
  final regularBlue = Color.fromRGBO(0, 104, 255, 1);

  final darkGreen = Color.fromRGBO(255, 102, 198, 143);
}
