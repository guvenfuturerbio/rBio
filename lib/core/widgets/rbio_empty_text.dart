import 'package:flutter/material.dart';

import '../extension/build_context_extension.dart';

class RbioEmptyText extends StatelessWidget {
  final String title;
  final Color? textColor;

  const RbioEmptyText({
    Key? key,
    required this.title,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 5,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: context.xHeadline3.copyWith(
          color: textColor ?? context.xHeadline3.color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
