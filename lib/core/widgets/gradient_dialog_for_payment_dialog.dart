import 'package:flutter/material.dart';

import '../core.dart';

class GradientDialogForPaymentDialog extends StatefulWidget {
  final String errorText;
  final String code;
  final String name;

  const GradientDialogForPaymentDialog({
    Key? key,
    required this.errorText,
    required this.code,
    required this.name,
  }) : super(key: key);

  @override
  _GradientDialogForPaymentDialogState createState() =>
      _GradientDialogForPaymentDialogState();
}

class _GradientDialogForPaymentDialogState
    extends State<GradientDialogForPaymentDialog> {
  @override
  Widget build(BuildContext context) {
    return RbioBaseDialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Center(
              child: Text(
                widget.code == "13"
                    ? LocaleProvider.of(context).info
                    : LocaleProvider.of(context).warning,
                style: context.xCurrentTheme.dialogTheme.title(context),
              ),
            ),

            //
            R.widgets.hSizer32,

            //
            Text(
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
              style: context.xCurrentTheme.dialogTheme.description(context),
              textAlign: TextAlign.center,
            ),

            //
            R.widgets.hSizer32,

            //
            Center(
              child: RbioSmallDialogButton.main(
                context: context,
                title: LocaleProvider.current.Ok,
                onPressed: () {
                  if (widget.code == "13" || widget.code == "10") {
                    Atom.dismiss();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
