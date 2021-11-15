import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/chart_data.dart';
import '../../../pages/progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import '../sample_view.dart';

///Renders line series with point color mapping
class LineMultiColorWeekly extends SampleView {
  @override
  _LineMultiColorWeeklyState createState() => _LineMultiColorWeeklyState();
}

class _LineMultiColorWeeklyState extends SampleViewState {
  List<ChartData> chartDatas;
  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressPageViewModel>(
      builder: (context, value, child) {
        this.chartDatas = value.chartData;
        return _getMultiColorLineChart();
      },
    );
  }

  ///Get the chart with multi colored line series
  SfCartesianChart _getMultiColorLineChart() {
    return SfCartesianChart(
      title: ChartTitle(text: isCardView ? '' : 'Annual rainfall of Paris'),
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
      series: _getMultiColoredLineSeries(),
      margin: EdgeInsets.all(2),
      trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          lineType: TrackballLineType.vertical,
          tooltipSettings: InteractiveTooltip(format: 'point.x : point.y')),
    );
  }

  ///Get multi colored line series
  List<LineSeries<ChartData, DateTime>> _getMultiColoredLineSeries() {
    final List<ChartData> chartData = chartDatas;
    return <LineSeries<ChartData, DateTime>>[
      LineSeries<ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,

          /// The property used to apply the color each data.
          pointColorMapper: (ChartData sales, _) => sales.color,
          width: 2)
    ];
  }
}
