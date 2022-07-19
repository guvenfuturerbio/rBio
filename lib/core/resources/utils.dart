part of 'resources.dart';

class _Utils {
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

  EdgeInsets screenPadding(BuildContext context) {
    return screenHandler<EdgeInsets>(
      context,
      mobile: EdgeInsets.only(
        left: R.sizes.mobilePadding,
        right: R.sizes.mobilePadding,
        top: 12,
      ),
      tablet: EdgeInsets.only(
        left: R.sizes.tabletPadding,
        right: R.sizes.tabletPadding,
        top: 12,
      ),
      desktop: EdgeInsets.only(
        left: R.sizes.desktopPadding,
        right: R.sizes.desktopPadding,
        top: 12,
      ),
    );
  }

  EdgeInsets screenPaddingOnlyHorizontal(BuildContext context) {
    return screenHandler<EdgeInsets>(
      context,
      mobile: EdgeInsets.only(
        left: R.sizes.mobilePadding,
        right: R.sizes.mobilePadding,
      ),
      tablet: EdgeInsets.only(
        left: R.sizes.tabletPadding,
        right: R.sizes.tabletPadding,
      ),
      desktop: EdgeInsets.only(
        left: R.sizes.desktopPadding,
        right: R.sizes.desktopPadding,
      ),
    );
  }
}
