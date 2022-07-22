import 'package:flutter/material.dart';

import '../core.dart';

class DetailedGradientMessageWidget extends StatelessWidget {
  final String currentLocale;

  const DetailedGradientMessageWidget({
    Key? key,
    required this.currentLocale,
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
          context,
          LocaleProvider.current.detailed_error_dialog_part1,
        ),

        //
        GuvenAlert.buildSmallDescription(
          context,
          LocaleProvider.current.detailed_error_dialog_part2,
        ),

        //
        GuvenAlert.buildSmallDescription(
          context,
          LocaleProvider.current.detailed_error_dialog_part3,
        ),

        //
        GestureDetector(
          onTap: () {
            getIt<UrlLauncherManager>().launch(R.constants.guvenTel);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                LocaleProvider.current.phone_guven,
                style: const TextStyle(
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
