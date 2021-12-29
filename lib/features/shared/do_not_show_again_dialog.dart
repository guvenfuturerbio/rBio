import 'package:flutter/material.dart';

import '../../core/core.dart';

class DoNotAskAgainDialog extends StatefulWidget {
  final String title, subTitle, positiveButtonText, negativeButtonText;
  final Function onPositiveButtonClicked;
  final String doNotAskAgainText;
  final String dialogKeyName;

  DoNotAskAgainDialog({
    this.dialogKeyName,
    this.title,
    this.subTitle,
    this.positiveButtonText,
    this.negativeButtonText,
    this.onPositiveButtonClicked,
    this.doNotAskAgainText = 'Never ask again',
  });

  @override
  _DoNotAskAgainDialogState createState() => _DoNotAskAgainDialogState();
}

class _DoNotAskAgainDialogState extends State<DoNotAskAgainDialog> {
  bool doNotAskAgain = false;

  Future<void> _updateDoNotShowAgain() async {
    await getIt<ISharedPreferencesManager>()
        .setBool(SharedPreferencesKeys.UPDATE_DIALOG, false);
  }

  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(widget.title),
      content: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            GuvenAlert.buildDescription(
              widget.subTitle,
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: doNotAskAgain,
                    onChanged: (val) {
                      setState(() {
                        doNotAskAgain = val;
                      });
                    },
                    activeColor: getIt<ITheme>().mainColor,
                  ),
                ),

                //
                SizedBox(width: 8),

                //
                GestureDetector(
                  onTap: () {
                    setState(() {
                      doNotAskAgain = doNotAskAgain == false;
                    });
                  },
                  child: GuvenAlert.buildDescription(
                    widget.doNotAskAgainText,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),

      //
      actions: <Widget>[
        GuvenAlert.buildMaterialAction(
          widget.positiveButtonText,
          () {
            widget.onPositiveButtonClicked();
          },
        ),

        //
        GuvenAlert.buildMaterialAction(
          widget.negativeButtonText,
          () {
            Navigator.pop(context);
            if (doNotAskAgain) {
              _updateDoNotShowAgain();
            }
          },
        ),
      ],
    );
  }
}
