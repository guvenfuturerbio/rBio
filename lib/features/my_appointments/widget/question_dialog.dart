import 'package:flutter/material.dart';

import '../../../../core/core.dart';

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
    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(widget.title),
      actions: [
        GuvenAlert.buildMaterialAction(
          LocaleProvider.of(context).yes,
          () {
            Navigator.of(context).pop(true);
          },
        ),

        //
        GuvenAlert.buildMaterialAction(
          LocaleProvider.of(context).no,
          () {
            Navigator.of(context).pop(false);
          },
        ),
      ],

      //
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GuvenAlert.buildDescription(widget.text),
          ],
        ),
      ),
    );
  }
}
