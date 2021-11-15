import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../helper/resources.dart';
import '../../../models/chart_data.dart';
import '../../../pages/progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import '../sample_view.dart';

/// Local imports

/// Renders the column chart sample with dynamically updated data points.
class AnimationColumnDefault extends SampleView {
  @override
  _AnimationColumnDefaultState createState() => _AnimationColumnDefaultState();
}

class _AnimationColumnDefaultState extends SampleViewState {
  List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressPageViewModel>(
      builder: (context, value, child) {
        //print(value.chartData.toString());
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
            dateFormat: DateFormat.Hm(),
            labelStyle: TextStyle(color: R.color.graph_plot_range),
            intervalType: DateTimeIntervalType.hours,
            interval: 6),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            title: AxisTitle(
                text: "mg/dL",
                textStyle:
                    TextStyle(fontSize: 10, color: R.color.graph_plot_range)),
            labelStyle: TextStyle(color: R.color.graph_plot_range),
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
      ),
      ColumnSeries<ChartData, DateTime>(
        dataSource: chartData != null && chartData.isNotEmpty
            ? [
                ChartData(
                    DateTime(chartData[0].x.year, chartData[0].x.month,
                        chartData[0].x.day, 24, 00),
                    -1,
                    Colors.transparent),
                ChartData(
                    DateTime(chartData[0].x.year, chartData[0].x.month,
                        chartData[0].x.day, 18, 00),
                    -1,
                    Colors.transparent),
                ChartData(
                    DateTime(chartData[0].x.year, chartData[0].x.month,
                        chartData[0].x.day, 12, 00),
                    -1,
                    Colors.transparent),
                ChartData(
                    DateTime(chartData[0].x.year, chartData[0].x.month,
                        chartData[0].x.day, 06, 00),
                    -1,
                    Colors.transparent),
                ChartData(
                    DateTime(chartData[0].x.year, chartData[0].x.month,
                        chartData[0].x.day, 00, 00),
                    -1,
                    Colors.transparent),
              ]
            : [
                ChartData(
                    DateTime(1995, 20, 02, 24, 00), 100, Colors.transparent),
                ChartData(
                    DateTime(1995, 20, 02, 18, 00), 100, Colors.transparent),
                ChartData(
                    DateTime(1995, 20, 02, 12, 00), 100, Colors.transparent),
                ChartData(
                    DateTime(1995, 20, 02, 06, 00), 100, Colors.transparent),
                ChartData(
                    DateTime(1995, 20, 02, 00, 00), 100, Colors.transparent),
              ],
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        pointColorMapper: (ChartData sales, _) => sales.color,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
