import 'package:flutter/material.dart';

import '../core.dart';

class RbioLoading extends StatelessWidget {
  final Color? color;

  const RbioLoading({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? getIt<ITheme>().mainColor),
      ),
    );
  }

  static Widget progressIndicator() => const Scaffold(
        backgroundColor: Colors.black38,
        body: Center(child: RbioLoading()),
      );
}
