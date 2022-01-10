import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/widgets/utils/time_period_filters.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/utils/charts/sample_view.dart';
import 'package:onedosehealth/features/doctor/bmi_patient_detail/viewmodel/bmi_patient_detail_vm.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../core/core.dart';

/// Renders the Scatter chart sample with dynamically updated data points.
class AnimationPatientScaleScatterDefault extends SampleView {
  /// Creates the Scatter chart sample with dynamically updated data points.
  @override
  _AnimationPatientScaleScatterDefaultState createState() =>
      _AnimationPatientScaleScatterDefaultState();
}

class _AnimationPatientScaleScatterDefaultState extends SampleViewState {
  List<ChartData> _chartData;

  int _minimum, _maximum, _targetMin, _targetMax;

  TimePeriodFilter _selected;

  DateTime _startDate, _endDate;

  double markerSize = 10;

  ZoomMode _zoomModeType = ZoomMode.x;

  ZoomPanBehavior _zoomingBehavior;

  String _unit;

  List<ScatterSeries<ChartData, DateTime>> _defaultScatterDataList;
  _AnimationPatientScaleScatterDefaultState();
  @override
  Widget build(BuildContext context) {
    _zoomingBehavior = ZoomPanBehavior(

        /// To enable the pinch zooming as true.
        enablePinching: true,
        zoomMode: _zoomModeType,
        enablePanning: true,
        enableMouseWheelZooming: model.isWeb ? true : false);
    return Consumer<BmiPatientDetailVm>(builder: (context, value, child) {
      _selected = value.selected;
      _chartData = value.chartData;
      _minimum = value.dailyLowestValue;
      _maximum = value.dailyHighestValue;
      _targetMin = value.targetMin;
      _targetMax = value.targetMax;
      _startDate = value.startDate;
      _endDate = value.endDate;
      _defaultScatterDataList = value.getDataScatterSeries();
      try {
        _unit = value?.bmiMeasurementsDailyData?.elementAt(0)?.unit?.toStr;
      } catch (_) {
        _unit = ScaleUnit.KG.toStr;
      }

      return _getAnimationScatterChart();
    });
  }

  /// Get the Scatter chart sample with dynamically updated data points.
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
      primaryXAxis: _selected == TimePeriodFilter.DAILY
          ? DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: MajorGridLines(color: Colors.black12),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              enableAutoIntervalOnZooming: true,
              labelStyle: TextStyle(color: R.color.black),
              interval: 6)
          : _selected == TimePeriodFilter.WEEKLY
              ? DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  dateFormat: DateFormat("EEE"),
                  majorGridLines: MajorGridLines(color: Colors.black12),
                  intervalType: DateTimeIntervalType.days,
                  interval: 1,
                )
              : DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: MajorGridLines(color: Colors.black12),
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
    List<ScatterSeries<ChartData, DateTime>> list = [];
    list.addAll(_defaultScatterDataList);
    list.addAll(<ScatterSeries<ChartData, DateTime>>[]);
    _selected == TimePeriodFilter.DAILY ||
            _selected == TimePeriodFilter.SPECIFIC
        ? list.add(ScatterSeries<ChartData, DateTime>(
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
                MarkerSettings(height: 15, width: 15, isVisible: true)))
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
