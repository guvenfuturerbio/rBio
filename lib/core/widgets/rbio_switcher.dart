import 'package:flutter/material.dart';

class RbioSwitcher extends StatelessWidget {
  final bool showFirstChild;
  final Widget child1;
  final Widget child2;

  const RbioSwitcher({
    Key key,
    @required this.showFirstChild,
    @required this.child1,
    @required this.child2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kTabScrollDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: showFirstChild ? child1 : child2,
    );
  }
}
