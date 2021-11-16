import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/database/repository/profile_repository.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';

class RangeSelectionSlider extends StatelessWidget {
  RangeSelectionSlider(this.id);
  final id;
  double _lowerValue = ProfileRepository().activeProfile.rangeMin.toDouble();
  double _upperValue = ProfileRepository().activeProfile.rangeMax.toDouble();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              child: FlutterSlider(
                step: FlutterSliderStep(step: 10),
                handlerWidth: 32,
                handlerHeight: 32,
                values: [_lowerValue, _upperValue],
                rangeSlider: true,
                max: ProfileRepository().activeProfile.hyper.toDouble(),
                min: ProfileRepository().activeProfile.hypo.toDouble(),
                tooltip: FlutterSliderTooltip(
                    boxStyle: FlutterSliderTooltipBox(
                        decoration: BoxDecoration(
                            color: R.regularBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    alwaysShowTooltip: true,
                    textStyle: TextStyle(
                      color: Colors.white,
                    )),
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBarHeight: 14,
                  activeTrackBarHeight: 10,
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                    border: Border.all(width: 3, color: R.color.target),
                  ),
                  activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: R.color.dark_blue),
                ),
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  _lowerValue = lowerValue;
                  _upperValue = upperValue;
                },
              ),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: R.regularBlue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0)),
              ),
              child: Text(
                LocaleProvider.current.save,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              ProfileRepository().updateMinAndMax(
                  id, _lowerValue.toInt(), _upperValue.toInt());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.all(12.0),
    );
  }
}
