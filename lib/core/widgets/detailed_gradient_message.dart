import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core.dart';

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
        //
        GuvenAlert.buildSmallDescription(
          LocaleProvider.current.detailed_error_dialog_part1,
        ),

        //
        GuvenAlert.buildSmallDescription(
          LocaleProvider.current.detailed_error_dialog_part2,
        ),

        //
        GuvenAlert.buildSmallDescription(
          LocaleProvider.current.detailed_error_dialog_part3,
        ),

        //
        GestureDetector(
          onTap: () {
            launch("tel://4449494");
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                LocaleProvider.current.phone_guven,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
