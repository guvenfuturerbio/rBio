import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../generated/l10n.dart';
import '../../database/repository/glucose_repository.dart';
import '../../helper/resources.dart';
import '../../notifiers/user_profiles_notifier.dart';
import '../utils.dart';
import 'sample_view.dart';

/// Renders the gauge multiple axis sample
class CustomScaleGaguge extends SampleView {
  /// Creates the gauge multiple axis sampl

  @override
  _CustomScaleGagugeState createState() => _CustomScaleGagugeState();
}

class _CustomScaleGagugeState extends SampleViewState {
  _CustomScaleGagugeState();

  @override
  Widget build(BuildContext context) {
    return _getRadialGauge(context);
  }

  /// Returns the default axis gauge
  Widget _getRadialGauge(BuildContext context) {
    return Consumer<GlucoseRepository>(
      builder: (context, value, child) {
        return SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              startAngle: 180,
              endAngle: 360,
              minimum: 0,
              maximum: 400,
              centerY: 0.6,
              interval: 80,
              ticksPosition: ElementsPosition.outside,
              labelsPosition: ElementsPosition.outside,
              minorTicksPerInterval: 5,
              radiusFactor: 1.2,
              labelOffset: 15,
              minorTickStyle: MinorTickStyle(
                  thickness: 1.5,
                  length: 0.03,
                  lengthUnit: GaugeSizeUnit.factor),
              majorTickStyle: MinorTickStyle(
                thickness: 1.5,
                length: 0.06,
                lengthUnit: GaugeSizeUnit.factor,
              ),
              axisLineStyle: AxisLineStyle(
                thickness: 3,
              ),
              axisLabelStyle: GaugeTextStyle(fontSize: 12),
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.3,
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            child: Text(
                          LocaleProvider.current.last_measurement,
                          style: TextStyle(color: Colors.black),
                        )),
                        Container(
                            child: Text(
                          (value?.lastMeasurement?.level ?? "0") + " mg/dL",
                          style: TextStyle(
                              fontSize: 20,
                              color: UtilityManager()
                                  .getGlucoseMeasurementColor(int.parse(
                                      value?.lastMeasurement?.level ?? "0"))),
                        ))
                      ],
                    ))
              ],
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: UserProfilesNotifier().selection.hypo.toDouble(),
                    startWidth: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.1,
                    color: R.color.very_low),
                GaugeRange(
                    startValue:
                        UserProfilesNotifier().selection.hypo.toDouble(),
                    endValue:
                        UserProfilesNotifier().selection.rangeMin.toDouble(),
                    startWidth: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.1,
                    color: R.color.low),
                GaugeRange(
                    startValue:
                        UserProfilesNotifier().selection.rangeMin.toDouble(),
                    endValue:
                        UserProfilesNotifier().selection.rangeMax.toDouble(),
                    startWidth: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.1,
                    color: R.color.target),
                GaugeRange(
                    startValue:
                        UserProfilesNotifier().selection.rangeMax.toDouble(),
                    endValue: UserProfilesNotifier().selection.hyper.toDouble(),
                    startWidth: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.1,
                    color: R.color.high),
                GaugeRange(
                    startValue:
                        UserProfilesNotifier().selection.hyper.toDouble(),
                    endValue: 400,
                    startWidth: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.1,
                    color: R.color.very_high),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  needleLength: 0.68,
                  lengthUnit: GaugeSizeUnit.factor,
                  needleStartWidth: 0,
                  needleEndWidth: 3,
                  value: double.parse(value?.lastMeasurement?.level ?? "0"),
                  enableAnimation: true,
                  needleColor: UtilityManager().getGlucoseMeasurementColor(
                      int.parse(value?.lastMeasurement?.level ?? "0")),
                  knobStyle: KnobStyle(
                    knobRadius: 6.5,
                    sizeUnit: GaugeSizeUnit.logicalPixel,
                    color: UtilityManager().getGlucoseMeasurementColor(
                        int.parse(value?.lastMeasurement?.level ?? "0")),
                  ),
                )
              ]),
        ]);
      },
    );
  }
}
