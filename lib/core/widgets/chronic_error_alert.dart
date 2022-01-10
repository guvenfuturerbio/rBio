import 'package:flutter/material.dart';

import '../core.dart';

class NotChronicWarning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      backgroundColor: getIt<ITheme>().cardBackgroundColor,
      title: GuvenAlert.buildTitle(
        LocaleProvider.current.not_chronic_warning
          ),
      actions: [
        GuvenAlert.buildMaterialAction(LocaleProvider.current.ok, () {
          Atom.dismiss();
        })
      ],
    );
  }
}
