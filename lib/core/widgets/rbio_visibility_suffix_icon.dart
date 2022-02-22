import 'package:flutter/material.dart';

import '../core.dart';

class RbioVisibilitySuffixIcon extends StatelessWidget {
  final bool eyesOpen;
  final VoidCallback onTap;

  const RbioVisibilitySuffixIcon({
    Key? key,
    required this.eyesOpen,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        eyesOpen ? Icons.visibility : Icons.visibility_off,
        color: getIt<ITheme>().mainColor,
      ),
    );
  }
}
