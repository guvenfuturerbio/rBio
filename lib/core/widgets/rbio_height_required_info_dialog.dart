import 'package:flutter/material.dart';

import '../core.dart';

class RbioHeightRequiredInfoDialog extends StatelessWidget {
  final bool backRoute;
  const RbioHeightRequiredInfoDialog({
    Key? key,
    required this.backRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Atom.dismiss();

        if (backRoute) {
          Atom.historyBack();
        }
      },
      child: RbioBaseDialog(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          physics: context.xBouncingScroll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Text(
                LocaleProvider.current.warning,
                style: context.xDialogTheme.titleTextStyle,
              ),

              //
              RbioBaseDialog.verticalGap(),

              //
              Text(
                LocaleProvider.current.required_user_height_info_message,
                textAlign: TextAlign.center,
                style: context.xDialogTheme.descriptionTextStyle,
              ),

              //
              RbioBaseDialog.verticalGap(),

              //
              RbioSmallDialogButton.main(
                context: context,
                title: LocaleProvider.current.update,
                onPressed: () {
                  Atom.dismiss();
                  Atom.to(PagePaths.healthInformation);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
