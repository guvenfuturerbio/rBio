import 'package:flutter/material.dart';

import '../core.dart';

class GuvenAlert extends StatelessWidget {
  final Color? backgroundColor;
  final EdgeInsets? insetPadding;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? title;
  final ShapeBorder? shape;
  final List<Widget>? actions;
  final Widget? content;
  final double? elevation;

  const GuvenAlert({
    Key? key,
    this.backgroundColor,
    this.insetPadding,
    this.contentPadding,
    this.title,
    this.shape,
    this.actions,
    this.content,
    this.elevation,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: elevation,
      insetPadding: insetPadding ??
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      backgroundColor: backgroundColor ?? context.xPrimaryColor,
      contentPadding: contentPadding ?? const EdgeInsets.all(0.0),
      title: context.xTextScaleType == TextScaleType.large
          ? Container(
              constraints: BoxConstraints(
                maxHeight: Atom.height * 0.4,
              ),
              child: SingleChildScrollView(
                child: title,
              ),
            )
          : title,
      shape: shape ?? R.sizes.defaultShape,
      actions: actions,
      content: !Atom.isWeb
          ? content
          : Container(
              constraints: BoxConstraints(
                maxWidth: Atom.width * 0.50,
              ),
              child: content,
            ),
    );
  }

  static Widget buildTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: getIt<IAppConfig>().theme.textColorSecondary,
      ),
    );
  }

  static Widget buildDescription(String text, {Color? color}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Roboto',
        color: color ?? getIt<IAppConfig>().theme.textColorSecondary,
      ),
    );
  }

  static Widget buildSmallDescription(
    String text, {
    TextAlign? textAlign,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Roboto',
        color: getIt<IAppConfig>().theme.textColorSecondary,
        decoration: decoration,
      ),
    );
  }

  static Widget buildBigMaterialAction(
    BuildContext context,
    String title,
    void Function() onPressed,
  ) {
    return buildMaterialAction(
      context,
      title,
      onPressed,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 48,
      ),
    );
  }

  static Widget buildMaterialAction(
    BuildContext context,
    String title,
    void Function() onPressed, {
    EdgeInsetsGeometry? padding,
  }) {
    return _actionButton(
      title,
      context.xPrimaryColor,
      getIt<IAppConfig>().theme.textColor,
      onPressed,
      padding: padding,
    );
  }

  static Widget buildMaterialRedAction(
    String title,
    void Function() onPressed, {
    EdgeInsetsGeometry? padding,
  }) {
    return _actionButton(
      title,
      getIt<IAppConfig>().theme.darkRed,
      getIt<IAppConfig>().theme.textColor,
      onPressed,
      padding: padding,
    );
  }

  static Widget buildMaterialWhiteAction(
    BuildContext context,
    String title,
    void Function() onPressed, {
    EdgeInsetsGeometry? padding,
  }) {
    return _actionButton(
      title,
      context.xCardColor,
      getIt<IAppConfig>().theme.textColorSecondary,
      onPressed,
      padding: padding,
    );
  }

  static Widget _actionButton(
    String title,
    Color backColor,
    Color textColor,
    void Function() onPressed, {
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: RbioTextButton(
        backgroundColor: Colors.transparent,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: R.sizes.defaultShape,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
