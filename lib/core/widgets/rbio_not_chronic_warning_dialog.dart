import 'package:flutter/material.dart';

import '../core.dart';

class RbioNotChronicWarningDialog extends StatelessWidget {
  const RbioNotChronicWarningDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioMessageDialog(
      description: LocaleProvider.current.not_chronic_warning,
      buttonTitle: LocaleProvider.current.Ok,
      isAtom: true,
    );
  }
}
