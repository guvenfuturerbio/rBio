import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import '../core.dart';

class RbioDeviceRegisterDialog extends StatelessWidget {
  final VRedirector vRedirector;
  const RbioDeviceRegisterDialog({
    Key? key,
    required this.vRedirector,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioMessageDialog(
      title: LocaleProvider.current.info,
      description: LocaleProvider.current.device_register,
      isAtom: true,
    );
  }
}
