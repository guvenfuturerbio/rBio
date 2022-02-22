import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class SectionCard extends StatelessWidget {
  const SectionCard(
      {Key? key,
      this.isVisible = true,
      this.isActive = false,
      required this.smallChild,
      required this.largeChild,
      this.hasDivider = false})
      : super(key: key);
  final bool isVisible;
  final bool isActive;
  final Widget smallChild;
  final Widget largeChild;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return isVisible || isActive
        ? Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOutBack,
                height: isActive
                    ? context.height * .9
                    : (context.height * .12) *
                        (context.textScale > 1 ? (context.textScale / 2) : 1),
                width: context.width,
                child: isActive ? largeChild : smallChild,
              ),
              if (hasDivider)
                const Divider(
                  thickness: 1,
                )
            ],
          )
        : const SizedBox();
  }
}
