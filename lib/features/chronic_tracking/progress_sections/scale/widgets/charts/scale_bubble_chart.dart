import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../core/core.dart';
import '../../viewmodel/scale_progress_vm.dart';

class ScaleBubbleChart extends StatefulWidget {
  const ScaleBubbleChart({Key? key}) : super(key: key);

  @override
  _ScaleBubbleChartState createState() => _ScaleBubbleChartState();
}

class _ScaleBubbleChartState extends State<ScaleBubbleChart> {
  List<ChartData>? _chartData;

  late int _minimum, _maximum, _targetMin, _targetMax;

  late TimePeriodFilter _selected;

  late DateTime _startDate, _endDate;

  double markerSize = 10;

  final ZoomMode _zoomModeType = ZoomMode.x;

  late ZoomPanBehavior _zoomingBehavior;

  late List<ScatterSeries<ChartData, DateTime>> _defaultScatterDataList;
  @override
  Widget build(BuildContext context) {
    _zoomingBehavior = ZoomPanBehavior(
      /// To enable the pinch zooming as true.
      enablePinching: true,
      zoomMode: _zoomModeType,
      enablePanning: true,
      enableMouseWheelZooming: Atom.isWeb ? true : false,
    );

    return Consumer<ScaleProgressVm>(
      builder: (context, value, child) {
        _selected = value.selected;
        _chartData = value.chartData;
        _minimum = value.dailyLowestValue;
        _maximum = value.dailyHighestValue;
        _targetMin = value.targetMin!;
        _targetMax = value.targetMax!;
        _startDate = value.startDate;
        _endDate = value.endDate;
        _defaultScatterDataList = value.getDataScatterSeries();

        return _getAnimationScatterChart();
      },
    );
  }

  /// Get the Scatter chart sample with dynamically updated data points.
  SfCartesianChart _getAnimationScatterChart() {
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
                  majorGridLines: const MajorGridLines(color: Colors.black12),
                  intervalType: DateTimeIntervalType.days,
                  interval: 1,
                )
              : DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: const MajorGridLines(color: Colors.black12),
                ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          title: AxisTitle(
              text: "KG",
              textStyle: TextStyle(fontSize: 10, color: R.color.black)),
          minimum: _minimum.toDouble(),
          maximum: _maximum.toDouble(),
          interval: 5,
          labelStyle: TextStyle(color: R.color.black),
          plotBands: [
            PlotBand(
                isVisible: true,
                start: _targetMax,
                end: _targetMin,
                shouldRenderAboveSeries: false,
                color: R.color.graph_plot_range),
          ],
          majorGridLines: const MajorGridLines(color: Colors.black12)),
      enableAxisAnimation: true,
      zoomPanBehavior: _zoomingBehavior,
      series: getDefaultScatterSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }

  /// It will return the scatter series with its functionality to chart.
  List<ScatterSeries<ChartData, DateTime>> getDefaultScatterSeries() {
    List<ScatterSeries<ChartData, DateTime>> list = [];
    list.addAll(_defaultScatterDataList);
    list.addAll(<ScatterSeries<ChartData, DateTime>>[]);
    _selected == TimePeriodFilter.daily ||
            _selected == TimePeriodFilter.spesific
        ? list.add(ScatterSeries<ChartData, DateTime>(
            dataSource: (_chartData != null && _chartData!.isNotEmpty)
                ? [
                    ChartData(
                        DateTime(_chartData![0].x.year, _chartData![0].x.month,
                            _chartData![0].x.day, 24, 00),
                        -50,
                        Colors.transparent),
                    ChartData(
                        DateTime(_chartData![0].x.year, _chartData![0].x.month,
                            _chartData![0].x.day, 00, 00),
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
                const MarkerSettings(height: 15, width: 15, isVisible: true)))
        : list.add(ScatterSeries<ChartData, DateTime>(
            dataSource: [
                ChartData(_startDate, -50, Colors.transparent),
                ChartData(_endDate, -50, Colors.transparent),
              ],
            xValueMapper: (ChartData sales, _) => sales.x,
            yValueMapper: (ChartData sales, _) => sales.y,
            color: Colors.red,
            xAxisName: "Time",
            markerSettings: MarkerSettings(
                height: markerSize, width: markerSize, isVisible: true)));
    return list;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
