import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../helper/resources.dart';

class GradientDialog extends StatefulWidget {
  GradientDialog(this.title, this.text);
  final String title;
  final String text;
  @override
  State<StatefulWidget> createState() {
    return new _GradientDialogState();
  }
}

class _GradientDialogState extends State<GradientDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.current.Ok),
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: R.btnDarkBlue,
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: [
        okButton,
      ],
      content: Container(
        padding: const EdgeInsets.all(16.0),
        /*decoration: new BoxDecoration(
            gradient: BlueGradient()),*/
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(widget.text,
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(0.0),
    );
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [R.btnLightBlue, R.btnDarkBlue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
