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
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      backgroundColor: getIt<IAppConfig>().theme.white,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Container(
        width: context.width - 50,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Center(
                  child: Text(
                    LocaleProvider.current.info,
                    style: getIt<IAppConfig>().theme.dialogTheme.title(context),
                  ),
                ),

                //
                R.sizes.hSizer32,

                Center(
                  child: Text(
                    LocaleProvider.current.succefully_created_account,
                    style: getIt<IAppConfig>()
                        .theme
                        .dialogTheme
                        .description(context),
                  ),
                ),

                //
                R.sizes.hSizer32,

                Center(
                  child: RbioSmallDialogButton.green(
                      title: LocaleProvider.current.ok,
                      onPressed: () {
                        Atom.dismiss(true);
                      }),
                ),
              ]),
        ),
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
    return _actionButton(
      title,
      getIt<IAppConfig>().theme.mainColor,
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
    String title,
    void Function() onPressed, {
    EdgeInsetsGeometry? padding,
  }) {
    return _actionButton(
      title,
      getIt<IAppConfig>().theme.cardBackgroundColor,
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
        shape:
            RoundedRectangleBorder(borderRadius: R.sizes.borderRadiusCircular),
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
