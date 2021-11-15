import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/chart_data.dart';
import '../../../pages/progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import '../../utils/time_period_filters.dart';
import '../sample_view.dart';

/// Renders the column chart sample with dynamically updated data points.
class AnimationColumnMonthly extends SampleView {
  @override
  _AnimationColumnMonthlyState createState() => _AnimationColumnMonthlyState();
}

class _AnimationColumnMonthlyState extends SampleViewState {
  List<ChartData> _chartData;
  TimePeriodFilter _monthInterval;
  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressPageViewModel>(
      builder: (context, value, child) {
        this._monthInterval = value.selected;
        this._chartData = value.chartData;
        return _getAnimationColumnChart();
      },
    );
  }

  /// Get the cartesian chart
  SfCartesianChart _getAnimationColumnChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: DateTimeAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            dateFormat: _monthInterval == TimePeriodFilter.MONTHLY
                ? DateFormat.d()
                : DateFormat.MMMd(Intl.getCurrentLocale()),
            intervalType: DateTimeIntervalType.days,
            interval: _monthInterval == TimePeriodFilter.MONTHLY_THREE
                ? 15
                : _chartData.length > 15
                    ? 3
                    : 1),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(text: "mg/dL", textStyle: TextStyle(fontSize: 10)),
            minimum: 10,
            maximum: 300,
            interval: 50,
            majorGridLines: MajorGridLines(color: Colors.transparent)),
        series: _getDefaultColumnSeries());
  }

  /// Get the column series
  List<ColumnSeries<ChartData, DateTime>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartData, DateTime>>[
      ColumnSeries<ChartData, DateTime>(
        dataSource: _chartData,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        pointColorMapper: (ChartData sales, _) => sales.color,
      )
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
