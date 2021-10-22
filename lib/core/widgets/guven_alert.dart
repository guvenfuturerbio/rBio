import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

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
      content: content,
    );

    // if (Platform.isIOS) {
    //   return Material(
    //     color: Colors.transparent,
    //     child: CupertinoAlertDialog(
    //       title: title,
    //       actions: actions ?? [],
    //       content: content,
    //     ),
    //   );
    // }
  }
}
