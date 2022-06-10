import 'package:flutter/material.dart';

import '../core.dart';

class NotChronicWarning extends StatelessWidget {
  const NotChronicWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioMessageDialog(
      description: LocaleProvider.current.not_chronic_warning,
      buttonTitle: LocaleProvider.current.ok,
      isAtom: true,
    );
  }
}
