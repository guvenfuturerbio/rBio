import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../core/core.dart';
import '../../viewmodel/bp_progres_vm.dart';

class BpPulseChart extends StatefulWidget {
  const BpPulseChart({Key? key}) : super(key: key);

  @override
  _BpPulseChartState createState() => _BpPulseChartState();
}

class _BpPulseChartState extends State<BpPulseChart> {
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
    return Consumer<BpProgressVm>(builder: (_, val, __) {
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

      // DateTime n = DateTime.now();
      if (pulse.isNotEmpty) {
        beginDate = DateTime(
          pulse.first.x.year,
          pulse.first.x.month,
          pulse.first.x.day,
          00,
          00,
        );
        endDate = DateTime(
          pulse.first.x.year,
          pulse.first.x.month,
          pulse.first.x.day,
          24,
          00,
        );
      }

      map = val.measurements;

      return _buildChartBody(val);
    });
  }

  SfCartesianChart _buildChartBody(BpProgressVm val) {
    return SfCartesianChart(
      primaryXAxis: val.selected == TimePeriodFilter.daily
          ? DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: const MajorGridLines(color: Colors.black12),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              enableAutoIntervalOnZooming: true,
              interval: 1,
              minimum: beginDate,
              maximum: endDate,
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
        zoomMode: ZoomMode.x,
      ),
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
