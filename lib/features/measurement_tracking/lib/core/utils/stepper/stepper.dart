import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';

class Stepper extends StatelessWidget {
  const Stepper(
      {Key key,
      this.length,
      this.currentIndex,
      this.activeColor,
      this.deactiveColor})
      : super(key: key);
  final int length;
  final int currentIndex;
  final Color activeColor;
  final Color deactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            length,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.WIDTH * .008,
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    height: context.HEIGHT * .017,
                    width: currentIndex == index
                        ? (context.HEIGHT * .017) * 2
                        : context.HEIGHT * .017,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(context.ASPECTRATIO * 45),
                        color: currentIndex == index
                            ? activeColor ?? R.color.grey
                            : deactiveColor ?? R.color.grey.withOpacity(.3)),
                  ),
                ))
      ],
    );
  }
}
