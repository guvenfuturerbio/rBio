import 'package:flutter/material.dart';

import '../core.dart';

/// Bu widget sadece 'context' ile görüntülenmelidir.
class RbioContextInfoDialog extends StatefulWidget {
  final String title;
  final String text;
  final bool hasScrollable;

  const RbioContextInfoDialog({
    Key? key,
    required this.title,
    required this.text,
    this.hasScrollable = false,
  }) : super(key: key);

  @override
  _RbioContextInfoDialogState createState() => _RbioContextInfoDialogState();
}

class _RbioContextInfoDialogState extends State<RbioContextInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      title: GuvenAlert.buildTitle(context, widget.title),

      //
      actions: [
        GuvenAlert.buildMaterialAction(
          context,
          LocaleProvider.of(context).Ok,
          () {
            Navigator.pop(context);
          },
        ),
      ],

      //
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: !widget.hasScrollable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GuvenAlert.buildDescription(context, widget.text),
                ],
              )
            : SingleChildScrollView(
                child: GuvenAlert.buildDescription(context, widget.text),
              ),
      ),
    );
  }
}
