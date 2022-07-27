import 'package:flutter/material.dart';

import '../../core/core.dart';

class DoNotAskAgainDialog extends StatefulWidget {
  final String title, subTitle, positiveButtonText, negativeButtonText;
  final Function()? onPositiveButtonClicked;
  final String doNotAskAgainText;

  const DoNotAskAgainDialog({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.positiveButtonText,
    required this.negativeButtonText,
    required this.onPositiveButtonClicked,
    this.doNotAskAgainText = 'Never ask again',
  }) : super(key: key);

  @override
  _DoNotAskAgainDialogState createState() => _DoNotAskAgainDialogState();
}

class _DoNotAskAgainDialogState extends State<DoNotAskAgainDialog> {
  bool doNotAskAgain = false;

  @override
  Widget build(BuildContext context) {
    return RbioBaseDialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                LocaleProvider.current.app_update_available,
                style: context.xDialogTheme.titleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),

            //
            R.widgets.hSizer24,

            //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  LocaleProvider.current.optional_update_message,
                  textAlign: TextAlign.center,
                  style: context.xDialogTheme.descriptionTextStyle,
                ),
              ),
            ),

            //
            R.widgets.hSizer16,

            //
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //

                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: SizedBox(
                      child: RbioCheckbox(
                        value: doNotAskAgain,
                        onChanged: (val) {
                          setState(() {
                            doNotAskAgain = val!;
                          });
                        },
                      ),
                    ),
                  ),

                  //
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        widget.doNotAskAgainText,
                        textAlign: TextAlign.start,
                        style: context.xDialogTheme.descriptionTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //
            R.widgets.hSizer16,

            //
            Center(
              child: RbioSmallDialogButton.main(
                context: context,
                title: LocaleProvider.current.update_now,
                onPressed: widget.onPositiveButtonClicked,
              ),
            ),
          ],
        ),

        //
      ),
    );
  }
}
