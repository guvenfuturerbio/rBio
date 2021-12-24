import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/widgets/utils/time_period_filters.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/charts/sample_view.dart';
import '../view/pressure_progres_page.dart';
import '../view_model/pressure_measurement_view_model.dart';

class AnimatedPulseChart extends SampleView {
  /// Creates the Scatter chart sample with dynamically updated data points.
  @override
  _AnimatedPulseChartState createState() => _AnimatedPulseChartState();
}

class _AnimatedPulseChartState extends SampleViewState {
  List<ChartData> sys;
  List<ChartData> dia;
  List<ChartData> pulse;

  Color sysColor = Colors.red;
  Color diaColor = Colors.blue[900];
  Color pulseColor = Colors.green;
  double markerSize = 10;
  @override
  Widget build(BuildContext context) {
    return Consumer<BpProgressPageVm>(builder: (_, val, __) {
      sys = val.bpMeasurementsDailyData
          .map((item) => ChartData(item.date, item.sys, Colors.red))
          .toList();
      dia = val.bpMeasurementsDailyData
          .map((item) => ChartData(item.date, item.dia, Colors.blue[900]))
          .toList();
      pulse = val.bpMeasurementsDailyData
          .map((item) => ChartData(item.date, item.pulse, Colors.green))
          .toList();
      log(val.selected.toString());
      return Column(
        children: [Expanded(child: _buildChartBody(val)), _infoWidget()],
      );
    });
  }

  SfCartesianChart _buildChartBody(BpProgressPageVm val) {
    return SfCartesianChart(
      primaryXAxis: val.selected == TimePeriodFilter.DAILY
          ? DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: MajorGridLines(color: Colors.black12),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              enableAutoIntervalOnZooming: true,
            )
          : val.selected == TimePeriodFilter.WEEKLY
              ? DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  dateFormat: DateFormat("EEE"),
                  intervalType: DateTimeIntervalType.days,
                  majorGridLines: MajorGridLines(color: Colors.black12),
                  interval: 1,
                )
              : DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: MajorGridLines(color: Colors.black12),
                ),
      series: <LineSeries>[
        //Dia Line
        LineSeries<ChartData, DateTime>(
          dataSource: sys,
          xValueMapper: (ChartData model, _) => (model).x,
          yValueMapper: (ChartData model, _) => (model).y,
          xAxisName: "Time",
          markerSettings: MarkerSettings(
              height: 10,
              width: 10,
              borderColor: sysColor,
              isVisible: dia.length == 1 ? true : false,
              color: sysColor),
        ),

        val.selected == TimePeriodFilter.DAILY ||
                val.selected == TimePeriodFilter.SPECIFIC
            ? LineSeries<ChartData, DateTime>(
                dataSource: sys != null && sys.length > 0
                    ? [
                        ChartData(
                            DateTime(sys[0].x.year, sys[0].x.month,
                                sys[0].x.day, 24, 00),
                            -50,
                            Colors.transparent),
                        ChartData(
                            DateTime(sys[0].x.year, sys[0].x.month,
                                sys[0].x.day, 00, 00),
                            -50,
                            Colors.transparent),
                      ]
                    : [
                        ChartData(DateTime(1997, 11, 09, 24, 00), -50,
                            Colors.transparent),
                        ChartData(DateTime(1997, 11, 09, 00, 00), -50,
                            Colors.transparent),
                      ],
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y,
                color: Colors.transparent,
                xAxisName: "Time",
                markerSettings:
                    MarkerSettings(height: 10, width: 10, isVisible: false))
            : LineSeries<ChartData, DateTime>(
                dataSource: [
                    ChartData(val.startDate, -50, Colors.transparent),
                    ChartData(val.endDate, -50, Colors.transparent),
                  ],
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y,
                color: Colors.red,
                xAxisName: "Time",
                markerSettings: MarkerSettings(
                    height: markerSize, width: markerSize, isVisible: false))
      ],
    );
  }

  _infoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Spacer(),
        _infoItem('${LocaleProvider.current.pulse}', Colors.green),
        Spacer(),
        _infoItem('${LocaleProvider.current.sys}', Colors.red),
        Spacer(),
        _infoItem('${LocaleProvider.current.dia}', Colors.blue[900]),
        Spacer(),
      ],
    );
  }

  Expanded _infoItem(String title, Color color) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Container(height: 15, width: 15, color: color), Text(title)],
      ),
    );
  }
}

class ChartData {
  final DateTime x;
  final int y;
  final Color color;
  final bool isBorder;
  final int tag;

  ChartData(
    this.x,
    this.y,
    this.color, {
    this.isBorder = false,
    this.tag = 3,
  });
}
