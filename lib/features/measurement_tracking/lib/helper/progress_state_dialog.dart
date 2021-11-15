import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../doctor/utils/widgets.dart';
import '../generated/l10n.dart';
import 'resources.dart';

// ignore: must_be_immutable
class ProgressStateDialog extends StatefulWidget {
  _ProgressStateDialogState state;
  final String image;
  final String text;
  bool isShowing() {
    return state != null && state.mounted;
  }

  ProgressStateDialog({this.text, this.image});
  @override
  createState() => state = _ProgressStateDialogState();
}

class _ProgressStateDialogState extends State<ProgressStateDialog> {
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
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: blueGradient()),
            child: SingleChildScrollView(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: ShakeAnimatedWidget(
                      enabled: true,
                      duration: Duration(milliseconds: 1500),
                      shakeAngle: Rotation.deg(z: 10),
                      curve: Curves.linear,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: SvgPicture.asset(
                          widget.image,
                          color: R.color.dark_blue,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: R.color.main_color, width: 10),
                        borderRadius: BorderRadius.all(Radius.circular(200))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(color: R.color.black, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  button(
                      text: LocaleProvider.current.done,
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.HOME_PAGE, (Route<dynamic> route) => false);
                      },
                      width: MediaQuery.of(context).size.width * 0.2)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Gradient blueGradient() => LinearGradient(
      colors: [Colors.white, Colors.white],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
