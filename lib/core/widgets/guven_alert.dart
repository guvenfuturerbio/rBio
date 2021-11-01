import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../constants/constants.dart';
import '../core.dart';

class GuvenAlert extends StatelessWidget {
  final Color backgroundColor;
  final EdgeInsetsGeometry contentPadding;
  final Widget title;
  final ShapeBorder shape;
  final List<Widget> actions;
  final Widget content;

  GuvenAlert({
    Key key,
    this.backgroundColor,
    this.contentPadding,
    this.title,
    this.shape,
    this.actions,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor ?? R.color.blue,
      contentPadding: contentPadding ?? const EdgeInsets.all(0.0),
      title: title,
      shape: shape ??
          RoundedRectangleBorder(
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
        color: Colors.black,
      ),
    );
  }

  static Widget buildDescription(String text, {Color color}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Roboto',
        color: color ?? Colors.black,
      ),
    );
  }

  static Widget buildSmallDescription(
    String text, {
    TextAlign textAlign,
    TextDecoration decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Roboto',
        color: Colors.black,
        decoration: decoration,
      ),
    );
  }

  static GradientButton buildWhiteAction({
    text: String,
    Function onPressed,
    double height,
    double width,
  }) =>
      GradientButton(
        increaseHeightBy: height ?? 16,
        increaseWidthBy: width ?? 50,
        shapeRadius: BorderRadius.all(Radius.zero),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: R.color.blue),
        ),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        callback: onPressed,
        gradient: LinearGradient(
            colors: [R.color.white, R.color.white],
            begin: Alignment.bottomLeft,
            end: Alignment.centerRight),
        shadowColor: Colors.black,
      );

  static Widget buildBigMaterialAction(
    String title,
    void Function() onPressed,
  ) {
    return buildMaterialAction(
      title,
      onPressed,
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 48,
      ),
    );
  }

  static Widget buildMaterialAction(
    String title,
    void Function() onPressed, {
    EdgeInsetsGeometry padding,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradient(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: FlatButton(
        color: Colors.transparent,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
