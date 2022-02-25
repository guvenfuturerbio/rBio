import 'package:flutter/material.dart';

class StackOfCards extends StatelessWidget {
  final List<Widget> children;
  final double offset;

  const StackOfCards({
    Key? key,
    required this.children,
    this.offset = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: List<Widget>.generate(
            children.length,
            (val) => Positioned(
                left: (children.length - val - 1) * offset,
                right: val * offset,
                child: children[val])).toList(),
      );
}
