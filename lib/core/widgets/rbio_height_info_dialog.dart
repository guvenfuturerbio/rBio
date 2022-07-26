import 'package:flutter/material.dart';

import '../core.dart';

class RbioHeightInfoDialog extends StatelessWidget {
  final bool backRoute;
  const RbioHeightInfoDialog({
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
          physics: context.xBouncingScroll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Center(
                child: Text(
                  LocaleProvider.current.warning,
                  style: context.xCurrentTheme.dialogTheme.title(Atom.context),
                  textAlign: TextAlign.center,
                ),
              ),

              //
              R.widgets.hSizer32,

              //
              Center(
                child: Text(
                  LocaleProvider.current.required_user_height_info_message,
                  style: context.xCurrentTheme.dialogTheme
                      .description(Atom.context),
                  textAlign: TextAlign.center,
                ),
              ),

              //
              R.widgets.hSizer32,

              //
              Center(
                child: RbioSmallDialogButton.main(
                  context: context,
                  title: LocaleProvider.current.update,
                  onPressed: () {
                    Atom.dismiss();
                    Atom.to(PagePaths.healthInformation);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
