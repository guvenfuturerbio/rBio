import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../core/core.dart';
import '../../../../doctor/patient_detail/blood_glucose/model/model.dart';
import '../../viewmodel/bg_progress_vm.dart';

class BgBubbleChart extends StatefulWidget {
  const BgBubbleChart({Key? key}) : super(key: key);

  @override
  _BgBubbleChartState createState() => _BgBubbleChartState();
}

class _BgBubbleChartState extends State<BgBubbleChart> {
  List<ChartData>? _chartData;

  late int _minimum, _maximum, _targetMin, _targetMax;

  late TimePeriodFilter _selected;

  late DateTime _startDate, _endDate;

  late double markerSize = 10;

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

    return Consumer<BgProgressVm>(builder: (context, value, child) {
      _selected = value.selected;
      _chartData = value.chartData;
      _minimum = value.dailyLowestValue;
      _maximum = value.dailyHighestValue;
      _targetMin = value.targetMin;
      _targetMax = value.targetMax;
      _startDate = value.startDate;
      _endDate = value.endDate;
      _defaultScatterDataList = value.getDataScatterSeries(context);
      return _getAnimationScatterChart();
    });
  }

  /// Get the Scatter chart sample with dynamically updated data points.
  SfCartesianChart _getAnimationScatterChart() {
    return SfCartesianChart(
      backgroundColor: context.xCardColor,
      primaryXAxis: _selected == TimePeriodFilter.daily
          ? DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: const MajorGridLines(color: Colors.black12),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              enableAutoIntervalOnZooming: true,
              labelStyle: context.xHeadline3,
              interval: 6)
          : _selected == TimePeriodFilter.weekly
              ? DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  dateFormat: DateFormat("EEE"),
                  majorGridLines: const MajorGridLines(
                    color: Colors.white,
                  ),
                  intervalType: DateTimeIntervalType.days,
                  interval: 1,
                )
              : DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: const MajorGridLines(
                    color: Colors.black12,
                  ),
                ),
      primaryYAxis: NumericAxis(
        labelFormat: '{value}',
        title: AxisTitle(
          text: "mg/dL",
          textStyle: TextStyle(
            fontSize: 10,
            color: context.xMyCustomTheme.codGray,
          ),
        ),
        minimum: _minimum.toDouble(),
        maximum: _maximum.toDouble(),
        interval: 30,
        labelStyle: context.xHeadline5,
        plotBands: [
          PlotBand(
            isVisible: true,
            start: _targetMax,
            end: _targetMin,
            shouldRenderAboveSeries: false,
            color: context.xMyCustomTheme.skeptic,
          ),
        ],
        majorGridLines: const MajorGridLines(
          color: Colors.black12,
        ),
      ),
      enableAxisAnimation: true,
      zoomPanBehavior: _zoomingBehavior,
      series: getDefaultScatterSeries(),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: '',
        canShowMarker: true,
      ),
    );
  }

  /// It will return the scatter series with its functionality to chart.
  List<ScatterSeries<ChartData, DateTime>> getDefaultScatterSeries() {
    List<ScatterSeries<ChartData, DateTime>> list = [];
    list.addAll(_defaultScatterDataList);
    list.addAll(<ScatterSeries<ChartData, DateTime>>[]);
    _selected == TimePeriodFilter.daily ||
            _selected == TimePeriodFilter.spesific
        ? list.add(
            ScatterSeries<ChartData, DateTime>(
              dataSource: (_chartData != null && _chartData!.isNotEmpty)
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
              markerSettings: const MarkerSettings(
                height: 15,
                width: 15,
                isVisible: true,
              ),
            ),
          )
        : list.add(
            ScatterSeries<ChartData, DateTime>(
              dataSource: [
                ChartData(_startDate, -50, Colors.transparent),
                ChartData(_endDate, -50, Colors.transparent),
              ],
              xValueMapper: (ChartData sales, _) => sales.x,
              yValueMapper: (ChartData sales, _) => sales.y,
              color: Colors.red,
              xAxisName: "Time",
              markerSettings: MarkerSettings(
                height: markerSize,
                width: markerSize,
                isVisible: true,
              ),
            ),
          );
    return list;
  }
}
