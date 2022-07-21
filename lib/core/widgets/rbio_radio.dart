import 'package:flutter/material.dart';

import '../core.dart';

class RbioRadio extends StatelessWidget {
  final dynamic value;
  final dynamic groupValue;
  final void Function(dynamic)? onChanged;

  const RbioRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Radio(
      groupValue: groupValue,
      onChanged: onChanged,
      value: value,
      activeColor: context.xPrimaryColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
