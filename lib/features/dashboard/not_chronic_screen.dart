import 'package:flutter/material.dart';

import '../../core/core.dart';

class NotChronicScreen extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState>? drawerKey;

  const NotChronicScreen({
    Key? key,
    required this.title,
    this.drawerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        leading:
            drawerKey != null ? RbioLeadingMenu(drawerKey: drawerKey) : null,
        title: RbioAppBar.textTitle(context, title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: R.sizes.bottomNavigationBarHeight),
          child: Text(
            LocaleProvider.current.not_chronic_warning,
            style: context.xHeadline3,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
