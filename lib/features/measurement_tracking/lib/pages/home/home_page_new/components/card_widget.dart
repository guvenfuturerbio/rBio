import 'package:flutter/material.dart';
import 'package:onedosehealth/extension/size_extension.dart';

class SectionCard extends StatelessWidget {
  const SectionCard(
      {Key key,
      this.isVisible = true,
      this.isActive = false,
      this.color,
      this.smallChild,
      this.largeChild})
      : super(key: key);
  final bool isVisible;
  final bool isActive;
  final Color color;
  final Widget smallChild;
  final Widget largeChild;

  @override
  Widget build(BuildContext context) {
    return isVisible || isActive
        ? AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOutBack,
            height: isActive
                ? context.HEIGHT
                : (context.HEIGHT * .2) *
                    (context.TEXTSCALE > 1 ? (context.TEXTSCALE / 2) : 1),
            width: context.WIDTH,
            onEnd: () => print('Done'),
            child: isActive ? largeChild : smallChild,
          )
        : SizedBox();
  }
}
