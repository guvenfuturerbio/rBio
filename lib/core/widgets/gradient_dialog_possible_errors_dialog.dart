import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
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
    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(widget.title),
      actions: [
        GuvenAlert.buildMaterialAction(
          LocaleProvider.of(context).Ok,
          () {
            Navigator.of(context).pop();
          },
        ),
      ],
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: widget.body,
      ),
    );
  }
}
