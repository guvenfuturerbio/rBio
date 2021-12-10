import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:onedosehealth/features/doctor/resources/resources.dart';
import 'package:onedosehealth/features/doctor/notifiers/patient_notifiers.dart';
import 'package:onedosehealth/features/doctor/utils/sliders/range_setter_slider_view_model.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';

class RangeSetterSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RangeSetterSliderState();
}

class _RangeSetterSliderState extends State<RangeSetterSlider> {
  double _lowerValue = 50;
  double _upperValue = 180;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RangeSetterSliderViewModel(context: context),
      child: Consumer<RangeSetterSliderViewModel>(
        builder: (context, value, child) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: FlutterSlider(
                    lockDistance: value.lowerValue,
                    values: [value.hypoValue],
                    max: value.MAX_RANGE.toDouble(),
                    min: 0,
                    ignoreSteps: [
                      FlutterSliderIgnoreSteps(
                          from: value.lowerValue - value.MIN_DISTANCE, to: 350),
                    ],
                    tooltip: FlutterSliderTooltip(
                        boxStyle: FlutterSliderTooltipBox(
                            decoration: BoxDecoration(
                                color: R.color.veryLow,
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
                        color: Colors.white,
                        border: Border.all(width: 3, color: R.color.veryLow),
                      ),
                      activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: R.color.veryLow),
                    ),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      _lowerValue = lowerValue;
                      value.setHypoValue(lowerValue);
                    },
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: FlutterSlider(
                      values: [value.lowerValue, value.higherValue],
                      ignoreSteps: [
                        FlutterSliderIgnoreSteps(from: -1, to: 30),
                        FlutterSliderIgnoreSteps(from: 270, to: 350),
                      ],
                      rangeSlider: true,
                      max: value.MAX_RANGE.toDouble(),
                      min: 0,
                      tooltip: FlutterSliderTooltip(
                          boxStyle: FlutterSliderTooltipBox(
                              decoration: BoxDecoration(
                                  color: R.color.mainColor,
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
                          color: Colors.white,
                          border: Border.all(width: 3, color: R.color.target),
                        ),
                        activeTrackBar: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: R.color.mainColor),
                      ),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        _lowerValue = lowerValue;
                        _upperValue = upperValue;
                        value.setTargetRange(lowerValue, upperValue);
                      },
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: FlutterSlider(
                    values: [value.hyperValue],
                    max: value.MAX_RANGE.toDouble(),
                    min: 0,
                    ignoreSteps: [
                      FlutterSliderIgnoreSteps(
                          from: -value.MIN_DISTANCE.toDouble(),
                          to: value.higherValue + value.MIN_DISTANCE)
                    ],
                    tooltip: FlutterSliderTooltip(
                        boxStyle: FlutterSliderTooltipBox(
                            decoration: BoxDecoration(
                                color: R.color.veryHigh,
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
                          color: R.color.veryHigh),
                      activeTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(width: 1, color: R.color.veryHigh),
                      ),
                    ),
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      _lowerValue = lowerValue;
                      _upperValue = upperValue;
                      value.setHyperValue(lowerValue);
                    },
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: R.color.mainColor,
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
                    value.updatePatientLimit(
                        startValue: _lowerValue.toInt(),
                        endValue: _upperValue.toInt(),
                        id: Provider.of<PatientNotifiers>(context,
                                listen: false)
                            .patientDetail
                            .id);
                  },
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.all(12.0),
          );
        },
      ),
    );
  }
}
