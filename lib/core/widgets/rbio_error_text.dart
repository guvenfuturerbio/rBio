import 'package:flutter/material.dart';

import '../core.dart';

class RbioErrorText extends StatelessWidget {
  final String title;
  const RbioErrorText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.xBodyText1Error,
    );
  }
}
