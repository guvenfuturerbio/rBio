// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../core.dart';

class WarningDialog extends StatefulWidget {
  final String title;
  final String text;
  final bool hasScrollable;

  const WarningDialog(
    this.title,
    this.text, {
    this.hasScrollable = false,
  });

  @override
  _WarningDialogState createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = GuvenAlert.buildMaterialAction(
      LocaleProvider.of(context).Ok,
      () {
        widget.text == LocaleProvider.of(context).succefully_created_pass
            ? Atom.to(PagePaths.main)
            : Atom.pop();
      },
    );

    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(widget.title),

      //
      actions: [
        okButton,
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
                  GuvenAlert.buildDescription(widget.text),
                ],
              )
            : SingleChildScrollView(
                child: GuvenAlert.buildDescription(widget.text),
              ),
      ),
    );
  }
}
