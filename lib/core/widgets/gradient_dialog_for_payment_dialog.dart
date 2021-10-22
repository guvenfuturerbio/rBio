import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../constants/constants.dart';
import '../core.dart';
import '../navigation/app_paths.dart';
import 'guven_alert.dart';

class GradientDialogForPaymentDialog extends StatefulWidget {
  final String errorText;
  final String videoId;
  final String code;
  final String name;

  GradientDialogForPaymentDialog(
    this.errorText,
    this.videoId,
    this.code,
    this.name,
  );

  @override
  _GradientDialogForPaymentDialogState createState() =>
      _GradientDialogForPaymentDialogState();
}

class _GradientDialogForPaymentDialogState
    extends State<GradientDialogForPaymentDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.of(context).Ok),
      textColor: Colors.white,
      onPressed: () {
        if (widget.code == "13" || widget.code == "10") {
          Atom.to(PagePaths.MAIN, isReplacement: true);
        } else {
          Navigator.of(context).pop();
        }
      },
    );

    return GuvenAlert(
      title: Text(
        widget.code == "13"
            ? LocaleProvider.of(context).info
            : LocaleProvider.of(context).warning,
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
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
                widget.code == "13"
                    ? LocaleProvider.of(context).payment_successfull
                    : widget.code == "10"
                        ? LocaleProvider.of(context)
                            .appointment_created_but_error
                        : widget.code == "9"
                            ? LocaleProvider.of(context)
                                    .appointment_could_not_create +
                                " " +
                                widget.errorText
                            : LocaleProvider.of(context).sorry_dont_transaction,
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
