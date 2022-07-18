part of 'resources.dart';

class _Widgets {
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

  Widget get defaultBottomPadding =>
      SizedBox(height: R.sizes.defaultBottomValue);
  Widget stackedTopPadding(BuildContext context) =>
      SizedBox(height: 54 + MediaQuery.of(context).viewPadding.top);

  Widget textScaleBuilder(
    BuildContext context, {
    required Widget smallWidget,
    required Widget largeWidget,
  }) =>
      context.xTextScaleType == TextScaleType.small ? smallWidget : largeWidget;
}
