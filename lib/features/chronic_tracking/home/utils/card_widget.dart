import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/extension/size_extension.dart';

class SectionCard extends StatelessWidget {
  const SectionCard(
      {Key key,
      this.isVisible = true,
      this.isActive = false,
      this.color,
      this.smallChild,
      this.largeChild,
      this.hasDivider})
      : super(key: key);
  final bool isVisible;
  final bool isActive;
  final Color color;
  final Widget smallChild;
  final Widget largeChild;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return isVisible || isActive
        ? Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeInOutBack,
                height: isActive
                    ? context.HEIGHT
                    : (context.HEIGHT * .12) *
                        (context.TEXTSCALE > 1 ? (context.TEXTSCALE / 2) : 1),
                width: context.WIDTH,
                onEnd: () => print('Done'),
                child: isActive ? largeChild : smallChild,
              ),
              if (hasDivider)
                Divider(
                  thickness: 1,
                )
            ],
          )
        : SizedBox();
  }
}
