import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class Stepper extends StatelessWidget {
  const Stepper(
      {Key? key,
      required this.length,
      required this.currentIndex,
      this.activeColor,
      this.deactiveColor})
      : super(key: key);
  final int length;
  final int currentIndex;
  final Color? activeColor;
  final Color? deactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            length,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * .008,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: context.height * .017,
                    width: currentIndex == index
                        ? (context.height * .017) * 2
                        : context.height * .017,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(context.aspectRatio * 45),
                        color: currentIndex == index
                            ? activeColor ?? getIt<IAppConfig>().theme.grey
                            : deactiveColor ?? getIt<IAppConfig>().theme.grey.withOpacity(.3)),
                  ),
                ))
      ],
    );
  }
}
