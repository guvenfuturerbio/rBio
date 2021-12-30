import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../../../core/core.dart';

class LoadingPage extends StatefulWidget {
  _ProgressDialogState state;
  String title;

  LoadingPage(this.title);

  bool isShowing() {
    return state != null && state.mounted;
  }

  @override
  _ProgressDialogState createState() => state = _ProgressDialogState();
}

class _ProgressDialogState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          //    alignment: Alignment.center,
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
      ),
    );
  }

  Gradient blueGradient() => LinearGradient(
      colors: [Colors.black12, Colors.black12],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
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
        child: SvgPicture.asset(
          R.image.stethoscope,
        ),
      ),
    );
