import 'package:flutter/material.dart';

import '../core.dart';

class RbioLogOutConfirmationDialog extends StatelessWidget {
  const RbioLogOutConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioBaseDialog(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: context.xBouncingScroll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleProvider.current.warning,
              style: context.xDialogTheme.titleTextStyle,
            ),

            //
            R.widgets.hSizer32,

            //
            Center(
              child: Text(
                LocaleProvider.current.logout_confirmation_description,
                textAlign: TextAlign.center,
                style: context.xDialogTheme.descriptionTextStyle,
              ),
            ),

            //
            R.widgets.hSizer32,

            //
            Row(
              children: [
                //
                R.widgets.wSizer12,

                //
                Expanded(
                  child: RbioSmallDialogButton.red(
                    context,
                    title: LocaleProvider.current.btn_cancel,
                    onPressed: () {
                      Atom.dismiss(false);
                    },
                  ),
                ),

                //
                R.widgets.wSizer8,

                //
                Expanded(
                  child: RbioSmallDialogButton.main(
                    context: context,
                    title: LocaleProvider.current.Ok,
                    onPressed: () {
                      Atom.dismiss(true);
                    },
                  ),
                ),
                R.widgets.wSizer12,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
