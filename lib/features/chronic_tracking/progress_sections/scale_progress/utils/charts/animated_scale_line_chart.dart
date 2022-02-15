import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../core/core.dart';
import '../../view_model/scale_progress_page_view_model.dart';

/// Renders the line sample with dynamically updated data points.
class AnimationScaleLineDefault extends StatefulWidget {
  const AnimationScaleLineDefault({Key? key}) : super(key: key);

  /// Renders the line chart sample with dynamically upd
  @override
  _AnimationScaleLineDefaultState createState() =>
      _AnimationScaleLineDefaultState();
}

class _AnimationScaleLineDefaultState extends State<AnimationScaleLineDefault> {
  List<ChartData>? _chartData;

  late int _targetMin, _targetMax, _maxValue, _minValue;

  late DateTime _startDate, _endDate;

  double markerSize = 10;

  TimePeriodFilter? _selected;

  late ZoomPanBehavior _zoomingBehavior;

  final ZoomMode _zoomModeType = ZoomMode.x;

  @override
  Widget build(BuildContext context) {
    _zoomingBehavior = ZoomPanBehavior(
        enablePinching: true,
        zoomMode: _zoomModeType,
        enablePanning: true,
        enableMouseWheelZooming: Atom.isWeb ? true : false);
    return Consumer<ScaleProgressPageViewModel>(
        builder: (context, value, child) {
      _selected = value.selected;
      _startDate = value.startDate;
      _endDate = value.endDate;
      _chartData = value.chartData;
      _targetMax = value.targetMax!;
      _targetMin = value.targetMin!;
      _maxValue = value.dailyHighestValue;
      _minValue = value.dailyLowestValue;

      return _getAnimationLineChart();
    });
  }

  ///Get the cartesian chart with line series
  SfCartesianChart _getAnimationLineChart() {
    return SfCartesianChart(
      onActualRangeChanged: (ActualRangeChangedArgs args) {},
      plotAreaBorderWidth: 0,
      primaryXAxis: _selected == TimePeriodFilter.daily
          ? DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: const MajorGridLines(color: Colors.black12),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              enableAutoIntervalOnZooming: true,
              labelStyle: TextStyle(color: R.color.black),
              interval: 6)
          : _selected == TimePeriodFilter.weekly
              ? DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  dateFormat: DateFormat("EEE"),
                  intervalType: DateTimeIntervalType.days,
                  majorGridLines: const MajorGridLines(color: Colors.black12),
                  interval: 1,
                )
              : DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: const MajorGridLines(color: Colors.black12),
                ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(color: Colors.black12),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
        axisLine: const AxisLine(width: 0),
        labelFormat: '{value}',
        labelStyle: TextStyle(color: R.color.black),
        plotBands: [
          PlotBand(
              isVisible: true,
              start: _targetMax,
              end: _targetMin,
              shouldRenderAboveSeries: false,
              textStyle: const TextStyle(color: Colors.black, fontSize: 13),
              color: R.color.graph_plot_range),
        ],
        minimum: _minValue.toDouble(),
        maximum: _maxValue.toDouble(),
        interval: 30,
      ),
      zoomPanBehavior: _zoomingBehavior,
      enableAxisAnimation: true,
      enableSideBySideSeriesPlacement: true,
      series: _chartData != null ? _getDefaultLineSeries() : [],
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<ChartData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<ChartData, DateTime>>[
      LineSeries<ChartData, DateTime>(
          dataSource: _chartData!,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          color: Colors.black,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 4,
              width: 4,
              isVisible: _chartData!.length == 1 ? true : false,
              color: Colors.black)),
      _selected == TimePeriodFilter.daily ||
              _selected == TimePeriodFilter.spesific
          ? LineSeries<ChartData, DateTime>(
              dataSource: _chartData != null && _chartData!.isNotEmpty
                  ? [
                      ChartData(
                          DateTime(
                              _chartData![0].x.year,
                              _chartData![0].x.month,
                              _chartData![0].x.day,
                              24,
                              00),
                          -50,
                          Colors.transparent),
                      ChartData(
                          DateTime(
                              _chartData![0].x.year,
                              _chartData![0].x.month,
                              _chartData![0].x.day,
                              00,
                              00),
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
                  const MarkerSettings(height: 15, width: 15, isVisible: true))
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
                  height: markerSize, width: markerSize, isVisible: true))
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
