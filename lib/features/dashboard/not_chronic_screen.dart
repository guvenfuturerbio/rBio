import 'package:flutter/material.dart';

import '../../core/core.dart';

class NotChronicScreen extends StatelessWidget {
  final String title;

  const NotChronicScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        leading: const SizedBox(
          width: 0,
          height: 0,
        ),
        leadingWidth: 0,
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
