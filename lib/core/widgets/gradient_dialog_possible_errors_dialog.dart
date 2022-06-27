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
    return RbioBaseGreyDialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                LocaleProvider.current.warning,
                style: getIt<IAppConfig>().theme.dialogTheme.title(context),
                textAlign: TextAlign.center,
              ),
            ),
            R.sizes.hSizer32,
            Center(
              child: Text(
                LocaleProvider.current.detailed_error_dialog_part1,
                style:
                    getIt<IAppConfig>().theme.dialogTheme.description(context),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                LocaleProvider.current.detailed_error_dialog_part2,
                style:
                    getIt<IAppConfig>().theme.dialogTheme.description(context),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                LocaleProvider.current.detailed_error_dialog_part3,
                style:
                    getIt<IAppConfig>().theme.dialogTheme.description(context),
                textAlign: TextAlign.center,
              ),
            ),
            R.sizes.hSizer32,
            Center(
              child: RbioSmallDialogButton.green(
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
