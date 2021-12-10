import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../notifiers/patient_notifiers.dart';
import 'bgpicker_vm.dart';

class TargetPicker extends StatelessWidget {
  Widget build(BuildContext context) {
    var mintarget;
    var maxtarget;
    return ChangeNotifierProvider(
        create: (context) => BloodGlucosePickerVM(context),
        child: Consumer<BloodGlucosePickerVM>(builder: (context, value, child) {
          return Container(
            height: 340,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(LocaleProvider.current.cancel)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                              onTap: () {
                                print("Selected min target is $mintarget");
                                print("Selected max target is $maxtarget");

                                value.setTargetRange(mintarget.hypoValue,
                                    maxtarget + value.hypoValue);
                                Navigator.pop(context);
                              },
                              child: Text(LocaleProvider.current.pick)),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 300,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem:
                                      value.min.indexOf(value.lowerValue)),
                              backgroundColor: Colors.grey[400],
                              onSelectedItemChanged: (selection) {
                                value.setTargetRange(
                                    value.min[selection], value.higherValue);
                              },
                              itemExtent: 50.0,
                              children: value.minWidget),
                        ),
                        Flexible(
                          child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem:
                                      value.max.indexOf(value.higherValue)),
                              backgroundColor: Colors.grey[400],
                              onSelectedItemChanged: (selection) {
                                value.setTargetRange(
                                    value.lowerValue, value.max[selection]);
                              },
                              itemExtent: 50.0,
                              children: value.maxWidget),
                        ),
                      ],
                    )),
              ],
            ),
          );
        }));
  }
}

class RangeSelectionSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BloodGlucosePickerVM(context),
        child: Consumer<BloodGlucosePickerVM>(builder: (context, value, child) {
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
                      values: [
                        value.lowerValue.toDouble(),
                        value.higherValue.toDouble()
                      ],
                      rangeSlider: true,
                      max: value.hyperValue.toDouble(),
                      min: value.hypoValue.toDouble(),
                      tooltip: FlutterSliderTooltip(
                          boxStyle: FlutterSliderTooltipBox(
                              decoration: BoxDecoration(
                                  color: R.color.defaultBlue,
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
                        value.setTargetRange(
                            lowerValue.toDouble(), upperValue.toDouble());
                      },
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: R.color.defaultBlue,
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
        }));
  }
}

class HyperPicker extends StatelessWidget {
  Widget build(BuildContext context) {
    var hyper;

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: ChangeNotifierProvider(
          create: (context) => BloodGlucosePickerVM(context),
          child:
              Consumer<BloodGlucosePickerVM>(builder: (context, value, child) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 300,
                      child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                              initialItem:
                                  ((value.hyperValue - value.higherValue) / 10)
                                      .toInt()),
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (value) {
                            hyper = value * 10;
                          },
                          itemExtent: 50.0,
                          children: value.hyperRangeWidget)),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: R.color.defaultBlue,
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
                      print(
                          "Selected number is ${(value.higherValue + hyper)}");
                      value.setHyperValue((value.higherValue + hyper));
                      value.updatePatientLimit(
                          id: Provider.of<PatientNotifiers>(context,
                                  listen: false)
                              .patientDetail
                              .id);
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          })),
    );
  }
}

class HypoPicker extends StatelessWidget {
  Widget build(BuildContext context) {
    var hypo;

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: ChangeNotifierProvider(
          create: (context) => BloodGlucosePickerVM(context),
          child:
              Consumer<BloodGlucosePickerVM>(builder: (context, value, child) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 300,
                      child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                              initialItem: (value.hypoValue / 10).toInt()),
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (value) {
                            hypo = value * 10;
                          },
                          itemExtent: 50.0,
                          children: value.hypoRangeWidget)),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: R.color.defaultBlue,
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
                      print("Selected number is ${hypo}");
                      value.setHypoValue(hypo);
                      value.updatePatientLimit(
                          id: Provider.of<PatientNotifiers>(context,
                                  listen: false)
                              .patientDetail
                              .id);
                    },
                  ),
                ],
              ),
            );
          })),
    );
  }
}
