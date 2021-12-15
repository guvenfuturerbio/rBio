import 'package:flutter/material.dart';

import '../core.dart';

class NotChronicWarning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      backgroundColor: getIt<ITheme>().cardBackgroundColor,
      title: GuvenAlert.buildTitle(
          "Kronik takip özelliğini kullanmak için lütfen ${LocaleProvider.current.phone_guven} numarasını arayınız"),
      actions: [
        GuvenAlert.buildMaterialAction(LocaleProvider.current.ok, () {
          Atom.dismiss();
        })
      ],
    );
  }
}
