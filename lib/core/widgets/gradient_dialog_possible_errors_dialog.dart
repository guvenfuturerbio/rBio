import 'package:flutter/material.dart';

import '../core.dart';

class DialogForPossibleErrorDialog extends StatefulWidget {
  final String title;
  final Widget body;

  const DialogForPossibleErrorDialog({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  _DialogForPossibleErrorDialogState createState() =>
      _DialogForPossibleErrorDialogState();
}

class _DialogForPossibleErrorDialogState
    extends State<DialogForPossibleErrorDialog> {
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
                LocaleProvider.current.warning,
                style: context.xDialogTheme.titleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),

            //
            R.widgets.hSizer32,

            //
            Center(
              child: Text(
                LocaleProvider.current.detailed_error_dialog_part1,
                style: context.xDialogTheme.descriptionTextStyle,
                textAlign: TextAlign.center,
              ),
            ),

            //
            Center(
              child: Text(
                LocaleProvider.current.detailed_error_dialog_part2,
                style: context.xDialogTheme.descriptionTextStyle,
                textAlign: TextAlign.center,
              ),
            ),

            //
            Center(
              child: Text(
                LocaleProvider.current.detailed_error_dialog_part3,
                style: context.xDialogTheme.descriptionTextStyle,
                textAlign: TextAlign.center,
              ),
            ),

            //
            R.widgets.hSizer32,

            //
            Center(
              child: RbioSmallDialogButton.main(
                context: context,
                title: LocaleProvider.current.Ok,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
