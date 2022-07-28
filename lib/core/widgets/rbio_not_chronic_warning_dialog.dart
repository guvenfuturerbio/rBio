import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    var linkText = TextStyle(color: context.xPrimaryColor);
    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
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
                recognizer: TapGestureRecognizer()..onTap = () {}),
            TextSpan(
                style: context.xHeadline3,
                text: LocaleProvider.current.not_chronic_warning_2),
          ])),
        ),
      ),
    );
  }
}
