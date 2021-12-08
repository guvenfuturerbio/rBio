import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../../../core/core.dart';

class RangeSelectionSlider extends StatefulWidget {
  final int id;
  final double lowerValue;
  final double upperValue;

  RangeSelectionSlider({
    Key key,
    @required this.id,
    @required this.lowerValue,
    @required this.upperValue,
  }) : super(key: key);

  @override
  State<RangeSelectionSlider> createState() => _RangeSelectionSliderState();
}

class _RangeSelectionSliderState extends State<RangeSelectionSlider> {
  double lowerValue;
  double upperValue;

  @override
  void initState() {
    lowerValue = widget.lowerValue;
    upperValue = widget.upperValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: getIt<ITheme>().cardBackgroundColor,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      content: SizedBox(
        height: Atom.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            SizedBox(height: 12),

            //
            Expanded(
              child: Container(
                width: Atom.width * 0.9,
                child: FlutterSlider(
                  step: FlutterSliderStep(step: 10),
                  handlerWidth: 32,
                  handlerHeight: 32,
                  values: [
                    lowerValue,
                    upperValue,
                  ],
                  rangeSlider: true,
                  max: getIt<ProfileStorageImpl>().getFirst().hyper.toDouble(),
                  min: getIt<ProfileStorageImpl>().getFirst().hypo.toDouble(),
                  tooltip: FlutterSliderTooltip(
                    boxStyle: FlutterSliderTooltipBox(
                      decoration: BoxDecoration(
                        color: getIt<ITheme>().mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    alwaysShowTooltip: true,
                    textStyle: context.xHeadline4.copyWith(
                      color: getIt<ITheme>().textColor,
                    ),
                  ),
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBarHeight: 14,
                    activeTrackBarHeight: 10,
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12,
                      border: Border.all(
                        width: 3,
                        color: getIt<ITheme>().secondaryColor,
                      ),
                    ),
                    activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: getIt<ITheme>().mainColor,
                    ),
                  ),
                  onDragging: (handlerIndex, lower, upper) {
                    lowerValue = lower;
                    upperValue = upper;
                  },
                ),
              ),
            ),

            //
            InkWell(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: getIt<ITheme>().mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                child: Text(
                  LocaleProvider.current.save,
                  textAlign: TextAlign.center,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Atom.dismiss({
                  'min': lowerValue.toInt(),
                  'max': upperValue.toInt(),
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
