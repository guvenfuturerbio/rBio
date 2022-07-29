part of 'resources.dart';

class _Sizes {
  // * Padding
  final double mobilePadding = 12;
  final double tabletPadding = 24;
  final double desktopPadding = 48;

  // * BorderRadius
  final radiusValue = 12;
  final BorderRadius borderRadiusCircular = BorderRadius.circular(12);
  final Radius radiusCircular = const Radius.circular(12);

  // * Icons
  final double iconSize = 30;
  final double iconSize2 = 24;
  final double iconSize3 = 18;
  final double iconSize4 = 14;
  final double iconSize5 = 10;

  double stackedTopPaddingValue(BuildContext context) =>
      54 + MediaQuery.of(context).viewPadding.top;
  double get defaultBottomValue => Atom.safeBottom + 12;
  double get bottomNavigationBarHeight => Atom.safeBottom + 65;
  final double defaultElevation = 0.0;
}