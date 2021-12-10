import 'package:flutter/material.dart';
import 'package:onedosehealth/generated/l10n.dart';

import '../resources/resources.dart';

class GradientDialog extends StatefulWidget {
  final String title;
  final String text;

  GradientDialog(this.title, this.text);

  @override
  _GradientDialogState createState() => _GradientDialogState();
}

class _GradientDialogState extends State<GradientDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      style: TextButton.styleFrom(primary: R.color.white),
      child: Text(LocaleProvider.current.ok),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: R.color.mainColor,
      contentPadding: EdgeInsets.all(0.0),
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      actions: [
        okButton,
      ],
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.text,
              style: new TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
