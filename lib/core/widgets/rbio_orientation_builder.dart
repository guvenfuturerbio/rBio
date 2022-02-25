import 'package:flutter/material.dart';

import '../core.dart';

class RbioOrientationBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<Orientation>) builder;

  const RbioOrientationBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Orientation>(
      initialData: Orientation.portrait,
      stream: AppInheritedWidget.of(context)?.orientationController.stream,
      builder: builder,
    );
  }
}
