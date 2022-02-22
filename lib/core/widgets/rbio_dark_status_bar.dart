import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RbioDarkStatusBar extends StatelessWidget {
  final Widget child;

  const RbioDarkStatusBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: child,
    );
  }
}
