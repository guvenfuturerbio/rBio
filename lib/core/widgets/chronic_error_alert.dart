import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core.dart';

class NotChronicWarningDialog extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState>? drawerKey;

  const NotChronicWarningDialog({
    Key? key,
    required this.title,
    this.drawerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var linkText = TextStyle(color: getIt<IAppConfig>().theme.mainColor);
    return RbioScaffold(
      appbar: RbioAppBar(
        leading:
            drawerKey != null ? RbioLeadingMenu(drawerKey: drawerKey) : null,
        title: RbioAppBar.textTitle(context, title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: R.sizes.bottomNavigationBarHeight),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                style: context.xHeadline3,
                text: LocaleProvider.current.not_chronic_warning_1),
            TextSpan(
                style: linkText,
                text: LocaleProvider.current.not_chronic_warning_url,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _callHealthTracker();
                  }),
            TextSpan(
                style: context.xHeadline3,
                text: LocaleProvider.current.not_chronic_warning_2),
          ])),
        ),
      ),
    );
  }

  _callHealthTracker() async {
    var url = Uri.parse("tel:4449494");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
