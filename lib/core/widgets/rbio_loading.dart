import 'package:flutter/material.dart';

import '../core.dart';

class RbioLoading extends StatelessWidget {
  const RbioLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(getIt<ITheme>().mainColor),
      ),
    );
  }

  static Widget progressIndicator() => const Scaffold(
        backgroundColor: Colors.black12,
        body: Center(child: RbioLoading()),
      );
}
