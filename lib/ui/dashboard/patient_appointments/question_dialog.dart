import 'package:flutter/material.dart';

import '../../../core/core.dart';

class QuestionDialog extends StatefulWidget {
  final String title;
  final String text;

  QuestionDialog(
    this.title,
    this.text,
  );

  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.of(context).yes),
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text(LocaleProvider.of(context).no),
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );

    return GuvenAlert(
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      actions: [okButton, cancelButton],
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
                  fontFamily: 'Roboto',
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.blue, R.color.light_blue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
