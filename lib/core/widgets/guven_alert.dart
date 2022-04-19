import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

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
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: elevation,
      insetPadding: insetPadding ??
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      backgroundColor: backgroundColor ?? getIt<IAppConfig>().theme.mainColor,
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
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
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

  static GradientButton buildWhiteAction({
    required String text,
    required void Function() onPressed,
    double? height,
    double? width,
  }) =>
      GradientButton(
        increaseHeightBy: height ?? 16,
        increaseWidthBy: width ?? 50,
        shapeRadius: const BorderRadius.all(Radius.zero),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: getIt<IAppConfig>().theme.mainColor),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        callback: onPressed,
        gradient: LinearGradient(colors: [
          getIt<IAppConfig>().theme.textColor,
          getIt<IAppConfig>().theme.textColor
        ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
        shadowColor: getIt<IAppConfig>().theme.textColorSecondary,
      );

  static Widget buildBigMaterialAction(
    String title,
    void Function() onPressed,
  ) {
    return buildMaterialAction(
      title,
      onPressed,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 48,
      ),
    );
  }

  static Widget buildMaterialAction(
    String title,
    void Function() onPressed, {
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: appGradient(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RbioTextButton(
        backgroundColor: Colors.transparent,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: getIt<IAppConfig>().theme.textColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
