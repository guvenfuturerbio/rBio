import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class QuestionDialog extends StatefulWidget {
  const QuestionDialog({
    Key? key,
  }) : super(key: key);

  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  @override
  Widget build(BuildContext context) {
    return RbioBaseGreyDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleProvider.current.warning,
            style: getIt<IAppConfig>().theme.dialogTheme.title(context),
          ),
          R.sizes.hSizer32,
          Center(
            child: Text(
              LocaleProvider.current.cancel_appo_question,
              style: getIt<IAppConfig>().theme.dialogTheme.description(context),
              textAlign: TextAlign.center,
            ),
          ),
          R.sizes.hSizer32,
          Row(
            children: [
              Expanded(
                child: RbioSmallDialogButton.red(
                    title: LocaleProvider.current.no,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
              ),
              R.sizes.wSizer8,
              Expanded(
                child: RbioSmallDialogButton.green(
                    title: LocaleProvider.current.yes,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
