import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/core.dart';
import '../../viewmodel/blood_pressure_vm.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnimatedPatientPulseChart extends StatefulWidget {
  const AnimatedPatientPulseChart({Key? key}) : super(key: key);

  /// Creates the Scatter chart sample with dynamically updated data points.
  @override
  _AnimatedPulseChartState createState() => _AnimatedPulseChartState();
}

class _AnimatedPulseChartState extends State<AnimatedPatientPulseChart> {
  List<ChartData> sys = [];
  List<ChartData> dia = [];
  List<ChartData> pulse = [];

  Color sysColor = Colors.red[900]!;
  Color diaColor = Colors.amber;
  Color pulseColor = Colors.lime[800]!;

  double markerSize = 10;

  Map<String, bool> map = {};
  @override
  Widget build(BuildContext context) {
    return Consumer<BloodPressurePatientDetailVm>(builder: (_, val, __) {
      sys = val.bpMeasurementsDailyData
          .where((element) => element.sys != null)
          .map((item) => ChartData(item.date, item.sys!, sysColor))
          .toList();
      dia = val.bpMeasurementsDailyData
          .where((element) => element.dia != null)
          .map((item) => ChartData(item.date, item.dia!, diaColor))
          .toList();
      pulse = val.bpMeasurementsDailyData
          .where((element) => element.pulse != null)
          .map((item) => ChartData(item.date, item.pulse!, pulseColor))
          .toList();

      map = val.measurements;

      return _buildChartBody(val);
    });
  }

  SfCartesianChart _buildChartBody(BloodPressurePatientDetailVm val) {
    return SfCartesianChart(
      primaryXAxis: val.selected == TimePeriodFilter.daily
          ? DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: const MajorGridLines(color: Colors.black12),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              enableAutoIntervalOnZooming: true,
            )
          : val.selected == TimePeriodFilter.weekly
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
      enableAxisAnimation: false,
      series: <LineSeries>[
        //Sys Line
        if (map[LocaleProvider.current.sys]!)
          LineSeries<ChartData, DateTime>(
            dataSource: sys,
            xValueMapper: (ChartData model, _) => (model).x,
            yValueMapper: (ChartData model, _) => (model).y,
            xAxisName: "Time",
            markerSettings: MarkerSettings(
                height: 5,
                width: 5,
                borderColor: sysColor,
                isVisible: true,
                color: sysColor),
            color: sysColor,
          ),

        //Dia Line
        if (map[LocaleProvider.current.dia]!)
          LineSeries<ChartData, DateTime>(
            dataSource: dia,
            xValueMapper: (ChartData model, _) => (model).x,
            yValueMapper: (ChartData model, _) => (model).y,
            xAxisName: "Time",
            markerSettings: MarkerSettings(
                height: 5,
                width: 5,
                borderColor: diaColor,
                isVisible: true,
                color: diaColor),
            color: diaColor,
          ),
        //Pulse Line
        if (map[LocaleProvider.current.pulse]!)
          LineSeries<ChartData, DateTime>(
            dataSource: pulse,
            xValueMapper: (ChartData model, _) => (model).x,
            yValueMapper: (ChartData model, _) => (model).y,
            xAxisName: "Time",
            dashArray: [5, 5],
            markerSettings: MarkerSettings(
                height: 5,
                width: 5,
                borderColor: pulseColor,
                isVisible: true,
                color: pulseColor),
            color: pulseColor,
          ),

        val.selected == TimePeriodFilter.daily ||
                val.selected == TimePeriodFilter.spesific
            ? LineSeries<ChartData, DateTime>(
                dataSource: sys.isNotEmpty
                    ? [
                        ChartData(
                            DateTime(sys[0].x.year, sys[0].x.month,
                                sys[0].x.day, 24, 00),
                            0,
                            Colors.transparent),
                        ChartData(
                            DateTime(sys[0].x.year, sys[0].x.month,
                                sys[0].x.day, 00, 00),
                            0,
                            Colors.transparent),
                      ]
                    : [
                        ChartData(DateTime(1997, 11, 09, 24, 00), 0,
                            Colors.transparent),
                        ChartData(DateTime(1997, 11, 09, 00, 00), 0,
                            Colors.transparent),
                      ],
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y,
                xAxisName: "Time",
                color: Colors.transparent,
                markerSettings: const MarkerSettings(
                    height: 10, width: 10, isVisible: false))
            : LineSeries<ChartData, DateTime>(
                dataSource: [
                    ChartData(val.startDate, 0, Colors.transparent),
                    ChartData(val.endDate, 0, Colors.transparent),
                  ],
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y,
                color: Colors.transparent,
                xAxisName: "Time",
                markerSettings: MarkerSettings(
                    height: markerSize, width: markerSize, isVisible: false))
      ],
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
