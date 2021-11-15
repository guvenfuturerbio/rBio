/// Package import
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/doctor/pages/patient_detail_page/patient_detail_page_view_model.dart';
import 'package:onedosehealth/doctor/resources/resources.dart';
import 'package:onedosehealth/doctor/models/chart_data.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../sample_view.dart';

/// Local import

/// Renders the Scatter chart sample with dynamically updated data points.
class AnimationScatterDefault extends SampleView {
  /// Creates the Scatter chart sample with dynamically updated data points.
  @override
  _AnimationScatterDefaultState createState() =>
      _AnimationScatterDefaultState();
}

class _AnimationScatterDefaultState extends SampleViewState {
  List<ChartData> _chartData;

  int _minimum, _maximum, _targetMin, _targetMax;

  Map<int, List<ChartData>> _chartVeryLowTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartLowTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartTargetTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartHighTagged = Map<int, List<ChartData>>();

  Map<int, List<ChartData>> _chartVeryHighTagged = Map<int, List<ChartData>>();

  DateTime _startDate, _endDate;

  double markerSize = 10;

  String _selected;

  ZoomMode _zoomModeType = ZoomMode.x;

  ZoomPanBehavior _zoomingBehavior;

  _AnimationScatterDefaultState();
  @override
  Widget build(BuildContext context) {
    _zoomingBehavior = ZoomPanBehavior(
        enablePinching: true,
        zoomMode: _zoomModeType,
        enablePanning: true,
        enableMouseWheelZooming: model.isWeb ? true : false);
    return Consumer<PatientDetailPageViewModel>(
        builder: (context, value, child) {
      _selected = value.selected;
      _startDate = value.startDate;
      _endDate = value.endDate;
      _chartVeryLowTagged = value.chartVeryLowTagged;
      _chartLowTagged = value.chartLowTagged;
      _chartTargetTagged = value.chartTargetTagged;
      _chartHighTagged = value.chartHighTagged;
      _chartVeryHighTagged = value.chartVeryHighTagged;
      _chartData = value.chartData;
      _minimum = value.dailyLowestValue;
      _maximum = value.dailyHighestValue;
      _targetMin = value.targetMin;
      _targetMax = value.targetMax;
      return _getAnimationScatterChart();
    });
  }

  SfCartesianChart _getAnimationScatterChart() {
    return SfCartesianChart(
      onActualRangeChanged: (ActualRangeChangedArgs args) {},
      onZoomEnd: (ZoomPanArgs args) {
        if (args.currentZoomFactor < 1) {
          // setState(() {
          //   _visible = true;

          //   refreshSetState(() {});
          // });
        }
      },
      plotAreaBorderWidth: 0,
      primaryXAxis: _selected == LocaleProvider.current.daily ||
              _selected == LocaleProvider.current.specific
          ? DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: MajorGridLines(color: Colors.black12),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              enableAutoIntervalOnZooming: true,
              labelStyle: TextStyle(color: R.color.black),
              interval: 6)
          : _selected == LocaleProvider.current.weekly
              ? DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: MajorGridLines(color: Colors.black12),
                  dateFormat: DateFormat("EEE"),
                  intervalType: DateTimeIntervalType.days,
                  interval: 1,
                )
              : DateTimeAxis(
                  majorGridLines: MajorGridLines(color: Colors.black12),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          title: AxisTitle(
              text: "mg/dL",
              textStyle: TextStyle(fontSize: 10, color: R.color.black)),
          minimum: _minimum.toDouble(),
          maximum: _maximum.toDouble(),
          interval: 30,
          labelStyle: TextStyle(color: R.color.black),
          plotBands: [
            PlotBand(
                isVisible: true,
                start: _targetMax,
                end: _targetMin,
                shouldRenderAboveSeries: false,
                textStyle: const TextStyle(color: Colors.black, fontSize: 13),
                color: R.color.graphRangeColor),
          ],
          majorGridLines: MajorGridLines(color: Colors.black12)),
      enableAxisAnimation: true,
      zoomPanBehavior: _zoomingBehavior,
      series: getDefaultScatterSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }

  /// It will return the scatter series with its functionality to chart.
  List<ScatterSeries<ChartData, DateTime>> getDefaultScatterSeries() {
    return <ScatterSeries<ChartData, DateTime>>[
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderWidth: 5,
              borderColor: R.color.veryHigh,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.veryHigh,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize, width: markerSize, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryHighTagged[3],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.veryHigh,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderColor: R.color.veryHigh,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderWidth: 2,
              borderColor: R.color.high,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.high,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize, width: markerSize, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartHighTagged[3],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.high,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderColor: R.color.high,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderWidth: 2,
              borderColor: R.color.target,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.target,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize, width: markerSize, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartTargetTagged[3],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.target,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderColor: R.color.target,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderWidth: 2,
              borderColor: R.color.low,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.low,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize, width: markerSize, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartLowTagged[3],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.low,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderColor: R.color.low,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[1],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.white,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderWidth: 2,
              borderColor: R.color.veryLow,
              isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[2],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.veryLow,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize, width: markerSize, isVisible: true)),
      ScatterSeries<ChartData, DateTime>(
          dataSource: _chartVeryLowTagged[3],
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: R.color.veryLow,
          borderWidth: 3,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: markerSize,
              width: markerSize,
              borderColor: R.color.veryLow,
              shape: DataMarkerType.rectangle,
              isVisible: true)),
      _selected == LocaleProvider.current.daily ||
              _selected == LocaleProvider.current.specific
          ? ScatterSeries<ChartData, DateTime>(
              dataSource: (_chartData != null && _chartData.length > 0)
                  ? [
                      ChartData(
                          DateTime(_chartData[0].x.year, _chartData[0].x.month,
                              _chartData[0].x.day, 24, 00),
                          -50,
                          Colors.transparent),
                      ChartData(
                          DateTime(_chartData[0].x.year, _chartData[0].x.month,
                              _chartData[0].x.day, 00, 00),
                          -50,
                          Colors.transparent),
                    ]
                  : [
                      ChartData(DateTime(1995, 20, 02, 24, 00), -50,
                          Colors.transparent),
                      ChartData(DateTime(1995, 20, 02, 00, 00), -50,
                          Colors.transparent),
                    ],
              xValueMapper: (ChartData sales, _) => sales.x,
              yValueMapper: (ChartData sales, _) => sales.y,
              color: Colors.red,
              xAxisName: "Time",
              markerSettings:
                  MarkerSettings(height: 15, width: 15, isVisible: true))
          : ScatterSeries<ChartData, DateTime>(
              dataSource: [
                  ChartData(_startDate, -50, Colors.transparent),
                  ChartData(_endDate, -50, Colors.transparent),
                ],
              xValueMapper: (ChartData sales, _) => sales.x,
              yValueMapper: (ChartData sales, _) => sales.y,
              color: Colors.red,
              xAxisName: "Time",
              markerSettings: MarkerSettings(
                  height: markerSize, width: markerSize, isVisible: true)),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
