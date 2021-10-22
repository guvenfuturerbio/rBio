import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../constants/constants.dart';
import 'guven_alert.dart';

class DialogForPossibleErrorDialog extends StatefulWidget {
  final String title;
  final Widget body;

  DialogForPossibleErrorDialog({this.title, this.body});

  @override
  _DialogForPossibleErrorDialogState createState() =>
      _DialogForPossibleErrorDialogState();
}

class _DialogForPossibleErrorDialogState
    extends State<DialogForPossibleErrorDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.of(context).Ok),
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return GuvenAlert(
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      actions: [
        okButton,
      ],
      content: Container(
        padding: const EdgeInsets.all(16.0),
        /*decoration: new BoxDecoration(
            gradient: BlueGradient()),*/
        child: widget.body,
      ),
    );
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.blue, R.color.light_blue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
