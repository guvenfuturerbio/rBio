import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../constants/constants.dart';

class DetailedGradientMessageWidget extends StatelessWidget {
  final String currentLocale;

  const DetailedGradientMessageWidget({
    Key key,
    this.currentLocale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(LocaleProvider.current.detailed_error_dialog_part1,
            style: new TextStyle(
              fontSize: 14.0,
              fontFamily: 'Roboto',
              color: R.color.white,
            )),
        Text(LocaleProvider.current.detailed_error_dialog_part2,
            style: new TextStyle(
              fontSize: 14.0,
              fontFamily: 'Roboto',
              color: R.color.white,
            )),
        Text(LocaleProvider.current.detailed_error_dialog_part3,
            style: new TextStyle(
              fontSize: 14.0,
              fontFamily: 'Roboto',
              color: R.color.white,
            )),
        GestureDetector(
          onTap: () {
            launch("tel://4449494");
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(LocaleProvider.current.phone_guven,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: R.color.white)),
            ),
          ),
        ),
      ],
    );
  }
}
