import 'package:flutter/material.dart';

import '../core.dart';
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
    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(
        widget.code == "13"
            ? LocaleProvider.of(context).info
            : LocaleProvider.of(context).warning,
      ),
      actions: [
        GuvenAlert.buildMaterialAction(
          LocaleProvider.of(context).Ok,
          () {
            if (widget.code == "13" || widget.code == "10") {
              Atom.to(PagePaths.MAIN, isReplacement: true);
            } else {
              Navigator.of(context).pop();
            }
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
            GuvenAlert.buildDescription(
              widget.code == "13"
                  ? LocaleProvider.of(context).payment_successfull
                  : widget.code == "10"
                      ? LocaleProvider.of(context).appointment_created_but_error
                      : widget.code == "9"
                          ? LocaleProvider.of(context)
                                  .appointment_could_not_create +
                              " " +
                              widget.errorText
                          : LocaleProvider.of(context).sorry_dont_transaction,
            ),
          ],
        ),
      ),
    );
  }
}
