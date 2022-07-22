import 'package:flutter/material.dart';

import '../core.dart';

class RbioCheckbox extends StatelessWidget {
  final bool? value;
  final void Function(bool?)? onChanged;
  final MaterialTapTargetSize? materialTapTargetSize;

  const RbioCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.materialTapTargetSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: context.xPrimaryColor,
      ),
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        hoverColor: Colors.transparent,
        activeColor: context.xPrimaryColor,
      ),
    );
  }
}
