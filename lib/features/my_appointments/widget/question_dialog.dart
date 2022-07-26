import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class QuestionDialog extends StatelessWidget {
  const QuestionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioBaseDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Text(
            LocaleProvider.current.warning,
            style: context.xCurrentTheme.dialogTheme.title(context),
          ),

          //
          R.widgets.hSizer32,

          //
          Center(
            child: Text(
              LocaleProvider.current.cancel_appo_question,
              style: context.xCurrentTheme.dialogTheme.description(context),
              textAlign: TextAlign.center,
            ),
          ),

          //
          R.widgets.hSizer32,

          //
          Row(
            children: [
              //
              Expanded(
                child: RbioSmallDialogButton.red(
                  context,
                  title: LocaleProvider.current.no,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ),

              //
              R.widgets.wSizer8,

              //
              Expanded(
                child: RbioSmallDialogButton.main(
                  context: context,
                  title: LocaleProvider.current.yes,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
