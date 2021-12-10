import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../../../generated/l10n.dart';
import '../widgets.dart';

class ProgressDialog extends StatefulWidget {
  static _ProgressDialogState state;

  bool isShowing() {
    return state != null && state.mounted;
  }

  @override
  _ProgressDialogState createState() => state = _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.all(10),
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              gradient: blueGradient(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                progress(),
                JumpingText((LocaleProvider.current.loading))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Gradient blueGradient() => LinearGradient(
        colors: [
          Colors.black12,
          Colors.black12,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
      );
}
