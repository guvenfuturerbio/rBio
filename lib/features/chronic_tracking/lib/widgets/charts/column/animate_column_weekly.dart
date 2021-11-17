import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/chart_data.dart';
import '../../../pages/progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import '../sample_view.dart';

/// Renders the column chart sample with dynamically updated data points.
class AnimationColumnWeekly extends SampleView {
  @override
  _AnimationColumnWeeklyState createState() => _AnimationColumnWeeklyState();
}

class _AnimationColumnWeeklyState extends SampleViewState {
  List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressPageViewModel>(
      builder: (context, value, child) {
        this.chartData = value.chartData;
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
            dateFormat: DateFormat("EEE"),
            intervalType: DateTimeIntervalType.days,
            interval: 1),
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
        dataSource: chartData,
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
