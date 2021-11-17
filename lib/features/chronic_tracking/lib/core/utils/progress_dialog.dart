import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../../../../core/constants/constants.dart';
import '../../generated/l10n.dart';

class ProgressDialog extends StatefulWidget {
  static _ProgressDialogState state;
  bool isShowing() {
    return state != null && state.mounted;
  }

  @override
  createState() => state = _ProgressDialogState();
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
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: blueGradient()),
            child: new Column(
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

  Widget progress({
    Key key,
    double value,
    Color backgroundColor,
    Animation valueColor,
    String semanticsLabel,
    String semanticsValue,
  }) =>
      ShakeAnimatedWidget(
        enabled: true,
        duration: Duration(milliseconds: 1500),
        shakeAngle: Rotation.deg(z: 10),
        curve: Curves.linear,
        child: Container(
          width: 80,
          height: 80,
          child: SvgPicture.asset(R.image.guven_logo),
        ),
      );

  Gradient blueGradient() => LinearGradient(
      colors: [Colors.black12, Colors.black12],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
