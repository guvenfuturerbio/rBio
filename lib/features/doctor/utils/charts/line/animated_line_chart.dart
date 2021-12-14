import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/doctor/blood_glucose_patient_detail/viewmodel/blood_glucose_patient_detail_vm.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../model/model.dart';
import '../../../../../core/core.dart';
import '../../sample_view.dart';

/// Renders the line sample with dynamically updated data points.
class AnimationLineDefault extends SampleView {
  /// Renders the line chart sample with dynamically upd
  @override
  _AnimationLineDefaultState createState() => _AnimationLineDefaultState();
}

class _AnimationLineDefaultState extends SampleViewState {
  List<ChartData> _chartData;

  int _targetMin, _targetMax, _maxValue, _minValue;

  DateTime _startDate, _endDate;

  double markerSize = 10;

  String _selected;

  ZoomMode _zoomModeType = ZoomMode.x;

  ZoomPanBehavior _zoomingBehavior;

  @override
  Widget build(BuildContext context) {
    _zoomingBehavior = ZoomPanBehavior(

        /// To enable the pinch zooming as true.
        enablePinching: true,
        zoomMode: _zoomModeType,
        enablePanning: true,
        enableMouseWheelZooming: model.isWeb ? true : false);
    return Consumer<BloodGlucosePatientDetailVm>(
        builder: (context, value, child) {
      _selected = value.selected;
      _startDate = value.startDate;
      _endDate = value.endDate;
      _chartData = value.chartData;
      _targetMax = value.targetMax;
      _targetMin = value.targetMin;
      _maxValue = value.dailyHighestValue;
      _minValue = value.dailyLowestValue;
      return _getAnimationLineChart();
    });
  }

  ///Get the cartesian chart with line series
  SfCartesianChart _getAnimationLineChart() {
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
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: MajorGridLines(color: Colors.black12),
                ),
      primaryYAxis: NumericAxis(
        majorTickLines: MajorTickLines(color: Colors.transparent),
        majorGridLines: MajorGridLines(color: Colors.black12),
        axisLine: AxisLine(width: 0),
        labelFormat: '{value}',
        title: AxisTitle(
            text: "mg/dL",
            textStyle: TextStyle(fontSize: 10, color: R.color.black)),
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
        minimum: _minValue.toDouble(),
        maximum: _maxValue.toDouble(),
        interval: 30,
      ),
      enableAxisAnimation: true,
      zoomPanBehavior: _zoomingBehavior,
      enableSideBySideSeriesPlacement: true,
      series: _getDefaultLineSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<ChartData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<ChartData, DateTime>>[
      LineSeries<ChartData, DateTime>(
          dataSource: _chartData,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.black,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 4,
              width: 4,
              isVisible: _chartData?.length == 1 ? true : false,
              color: Colors.black)),
      _selected == LocaleProvider.current.daily ||
              _selected == LocaleProvider.current.specific
          ? LineSeries<ChartData, DateTime>(
              dataSource: _chartData != null && _chartData.length > 0
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
          : LineSeries<ChartData, DateTime>(
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
