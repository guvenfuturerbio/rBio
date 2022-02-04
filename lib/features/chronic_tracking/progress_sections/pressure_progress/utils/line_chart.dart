import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../view/pressure_progres_page.dart';

class AnimatedPulseChart extends StatefulWidget {
  const AnimatedPulseChart({Key? key}) : super(key: key);

  /// Creates the Scatter chart sample with dynamically updated data points.
  @override
  _AnimatedPulseChartState createState() => _AnimatedPulseChartState();
}

class _AnimatedPulseChartState extends State<AnimatedPulseChart> {
  late List<ChartData> sys;
  late List<ChartData> dia;
  late List<ChartData> pulse;

  Color sysColor = Colors.red[900]!;
  Color diaColor = Colors.amber;
  Color pulseColor = Colors.lime[800]!;

  double markerSize = 10;
  DateTime? beginDate;
  DateTime? endDate;

  late Map<String, bool> map;
  @override
  Widget build(BuildContext context) {
    return Consumer<BpProgressPageVm>(builder: (_, val, __) {
      sys = val.bpMeasurementsDailyData
          .where((element) => element.sys != 0 && element.sys != null)
          .map((item) => ChartData(item.date, item.sys!, sysColor))
          .toList();
      dia = val.bpMeasurementsDailyData
          .where((element) => element.dia != 0 && element.dia != null)
          .map((item) => ChartData(item.date, item.dia!, diaColor))
          .toList();
      pulse = val.bpMeasurementsDailyData
          .where((element) => element.pulse != 0 && element.pulse != null)
          .map((item) => ChartData(item.date, item.pulse!, pulseColor))
          .toList();

      sys.sort((a, b) => a.x.compareTo(b.x));
      dia.sort((a, b) => a.x.compareTo(b.x));
      pulse.sort((a, b) => a.x.compareTo(b.x));
      if (sys.isNotEmpty) {
        beginDate = sys.first.x;
        endDate = sys.last.x;
      }
      if (dia.isNotEmpty) {
        if (beginDate != null && beginDate!.isBefore(dia.first.x)) {
          beginDate = dia.first.x;
        }
        if (endDate != null && endDate!.isAfter(dia.last.x)) {
          endDate = dia.last.x;
        }
      }
      if (pulse.isNotEmpty) {
        if (beginDate != null && beginDate!.isBefore(pulse.first.x)) {
          beginDate = pulse.first.x;
        }
        if (endDate != null && endDate!.isAfter(pulse.last.x)) {
          endDate = pulse.last.x;
        }
      }

      map = val.measurements;

      return _buildChartBody(val);
    });
  }

  SfCartesianChart _buildChartBody(BpProgressPageVm val) {
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
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enableMouseWheelZooming: true,
          maximumZoomLevel: 0.2,
          enablePanning: true,
          zoomMode: ZoomMode.x),
      trackballBehavior: TrackballBehavior(
        enable: true,
        tooltipAlignment: ChartAlignment.near,
        activationMode: ActivationMode.singleTap,
        markerSettings: const TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.visible),
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'),
        tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
      ),
      onSelectionChanged: (args) {
        LoggerUtils.instance.i(args.toString());
      },
      series: <LineSeries>[
        //Sys Line
        if (map[LocaleProvider.current.sys]! && sys.isNotEmpty)
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
        if (map[LocaleProvider.current.dia]! && dia.isNotEmpty)
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
            color: pulseColor,
          ),
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
