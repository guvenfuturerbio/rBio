import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utils/home_card/home_card.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/chart_data.dart';
import '../../../../pages/progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import '../../../utils/time_period_filters.dart';
import '../../sample_view.dart';

/// Renders the Scatter chart sample with dynamically updated data points.
class BgSmallScatterDefault extends SampleView {
  final Function() callBack;

  BgSmallScatterDefault(this.callBack) : super(callBack: callBack);

  /// Creates the Scatter chart sample with dynamically updated data points.
  @override
  _BgSmallScatterDefaultState createState() => _BgSmallScatterDefaultState();
}

class _BgSmallScatterDefaultState extends SampleViewState {
  List<ChartData> _chartData;

  int _minimum, _maximum;

  TimePeriodFilter _selected;

  DateTime _startDate, _endDate;

  double markerSize = 10;

  List<ScatterSeries<ChartData, DateTime>> _defaultScatterDataList;
  _BgSmallScatterDefaultState();
  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressPageViewModel>(builder: (context, value, child) {
      _selected = value.selected;
      _chartData = value.chartData;
      _minimum = value.dailyLowestValue;
      _maximum = value.dailyHighestValue;
      _startDate = value.startDate;
      _endDate = value.endDate;
      _defaultScatterDataList = value.getDataScatterSeries();

      return HomeCard(
        child: _getBgSmallScatterChart(),
        title: LocaleProvider.current.blood_glucose_measurement,
        callBack: widget.callBack,
      );
    });
  }

  /// Get the Scatter chart sample with dynamically updated data points.
  SfCartesianChart _getBgSmallScatterChart() {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          placeLabelsNearAxisLine: false,
          dateFormat: DateFormat("EEE"),
          majorGridLines: MajorGridLines(width: 0),
          minorGridLines: MinorGridLines(width: 0),
          majorTickLines: MajorTickLines(width: 0),
          minorTickLines: MinorTickLines(width: 0),
          labelStyle: TextStyle(color: Colors.transparent),
          axisLine: AxisLine(width: 0)),
      primaryYAxis: NumericAxis(
        labelFormat: '{value}',
        placeLabelsNearAxisLine: false,
        majorGridLines: MajorGridLines(color: Colors.transparent),
        axisLine: AxisLine(width: 0),
        minimum: _minimum.toDouble(),
        maximum: _maximum.toDouble(),
        minorGridLines: MinorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        minorTickLines: MinorTickLines(width: 0),
        labelStyle: TextStyle(color: Colors.transparent),
      ),
      borderWidth: 0,
      plotAreaBorderWidth: 0,
      borderColor: Colors.transparent,
      enableAxisAnimation: true,
      series: getDefaultScatterSeries(),
    );
  }

  /// It will return the scatter series with its functionality to chart.
  List<ScatterSeries<ChartData, DateTime>> getDefaultScatterSeries() {
    List<ScatterSeries<ChartData, DateTime>> list = [];
    list.addAll(_defaultScatterDataList);
    list.addAll(<ScatterSeries<ChartData, DateTime>>[]);
    print(_startDate.toString() + " " + _endDate.toString());
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
