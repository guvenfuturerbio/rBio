import 'package:flutter/material.dart';

import '../../core/core.dart';

class DoNotAskAgainDialog extends StatefulWidget {
  final String title, subTitle, positiveButtonText, negativeButtonText;
  final Function onPositiveButtonClicked;
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

  Future<void> _updateDoNotShowAgain() async {
    await getIt<ISharedPreferencesManager>().setBool(
      SharedPreferencesKeys.updateDialog,
      false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      backgroundColor: getIt<IAppConfig>().theme.cardBackgroundColor,
      title: GuvenAlert.buildTitle(widget.title),
      contentPadding: const EdgeInsets.all(8),
      content: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            GuvenAlert.buildDescription(
              widget.subTitle,
            ),

            //
            R.sizes.hSizer8,

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
                        doNotAskAgain = val!;
                      });
                    },
                    activeColor: getIt<IAppConfig>().theme.mainColor,
                  ),
                ),

                //
                const SizedBox(width: 8),

                //
                GestureDetector(
                  onTap: () {
                    setState(() {
                      doNotAskAgain = doNotAskAgain == false;
                    });
                  },
                  child: GuvenAlert.buildDescription(
                    widget.doNotAskAgainText,
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
