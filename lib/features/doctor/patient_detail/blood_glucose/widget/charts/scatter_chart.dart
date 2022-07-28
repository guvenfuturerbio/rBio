part of '../../view/bg_patient_detail_screen.dart';

/// Renders the Scatter chart sample with dynamically updated data points.
class BloodGlucosePatientScatter extends StatefulWidget {
  const BloodGlucosePatientScatter({Key? key}) : super(key: key);

  /// Creates the Scatter chart sample with dynamically updated data points.
  @override
  BloodGlucosePatientScatterState createState() =>
      BloodGlucosePatientScatterState();
}

class BloodGlucosePatientScatterState
    extends State<BloodGlucosePatientScatter> {
  List<ChartData> _chartData = [];

  late int _minimum, _maximum, _targetMin, _targetMax;

  Map<int, List<ChartData>> _chartVeryLowTagged = <int, List<ChartData>>{};

  Map<int, List<ChartData>> _chartLowTagged = <int, List<ChartData>>{};

  Map<int, List<ChartData>> _chartTargetTagged = <int, List<ChartData>>{};

  Map<int, List<ChartData>> _chartHighTagged = <int, List<ChartData>>{};

  Map<int, List<ChartData>> _chartVeryHighTagged = <int, List<ChartData>>{};

  DateTime? _startDate, _endDate;

  double markerSize = 10;

  String? _selected;

  final ZoomMode _zoomModeType = ZoomMode.x;

  ZoomPanBehavior? _zoomingBehavior;

  BloodGlucosePatientScatterState();

  @override
  Widget build(BuildContext context) {
    _zoomingBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: _zoomModeType,
      enablePanning: true,
      enableMouseWheelZooming: Atom.isWeb ? true : false,
    );

    return Consumer<BgPatientDetailVm>(builder: (context, value, child) {
      _selected = value.selected;
      _startDate = value.startDate;
      _endDate = value.endDate;
      _chartVeryLowTagged = value.chartVeryLowTagged;
      _chartLowTagged = value.chartLowTagged;
      _chartTargetTagged = value.chartTargetTagged;
      _chartHighTagged = value.chartHighTagged;
      _chartVeryHighTagged = value.chartVeryHighTagged;
      _chartData = value.chartData;
      _minimum = value.dailyLowestValue;
      _maximum = value.dailyHighestValue;
      _targetMin = value.targetMin;
      _targetMax = value.targetMax;
      return _getAnimationScatterChart();
    });
  }

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
      primaryXAxis: _selected == LocaleProvider.current.daily ||
              _selected == LocaleProvider.current.specific
          ? DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorGridLines: const MajorGridLines(color: Colors.black12),
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.hours,
              enableAutoIntervalOnZooming: true,
              labelStyle: TextStyle(
                color: context.xMyCustomTheme.codGray,
              ),
              interval: 6)
          : _selected == LocaleProvider.current.weekly
              ? DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: const MajorGridLines(color: Colors.black12),
                  dateFormat: DateFormat("EEE"),
                  intervalType: DateTimeIntervalType.days,
                  interval: 1,
                )
              : DateTimeAxis(
                  majorGridLines: const MajorGridLines(color: Colors.black12),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          title: AxisTitle(
            text: "mg/dL",
            textStyle: TextStyle(
              fontSize: 10,
              color: context.xMyCustomTheme.codGray,
            ),
          ),
          minimum: _minimum.toDouble(),
          maximum: _maximum.toDouble(),
          interval: 30,
          labelStyle: TextStyle(
            color: context.xMyCustomTheme.codGray,
          ),
          plotBands: [
            PlotBand(
              isVisible: true,
              start: _targetMax,
              end: _targetMin,
              shouldRenderAboveSeries: false,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
              color: context.xMyCustomTheme.skeptic,
            ),
          ],
          majorGridLines: const MajorGridLines(color: Colors.black12)),
      enableAxisAnimation: true,
      zoomPanBehavior: _zoomingBehavior,
      series: getDefaultScatterSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }

  /// It will return the scatter series with its functionality to chart.
  List<ScatterSeries<ChartData, DateTime>> getDefaultScatterSeries() {
    return <ScatterSeries<ChartData, DateTime>>[
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartVeryHighTagged[1]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: Colors.white,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderWidth: 5,
          borderColor: context.xMyCustomTheme.casablanca,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartVeryHighTagged[2]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.casablanca,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartVeryHighTagged[3]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.casablanca,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderColor: context.xMyCustomTheme.casablanca,
          shape: DataMarkerType.rectangle,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartHighTagged[1]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: Colors.white,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderWidth: 2,
          borderColor: context.xMyCustomTheme.energyYellow,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartHighTagged[2]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.energyYellow,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartHighTagged[3]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.energyYellow,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderColor: context.xMyCustomTheme.energyYellow,
          shape: DataMarkerType.rectangle,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartTargetTagged[1]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: Colors.white,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderWidth: 2,
          borderColor: context.xMyCustomTheme.deYork,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartTargetTagged[2]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.deYork,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartTargetTagged[3]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.deYork,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderColor: context.xMyCustomTheme.deYork,
          shape: DataMarkerType.rectangle,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartLowTagged[1]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: Colors.white,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderWidth: 2,
          borderColor: context.xMyCustomTheme.tonysPink,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartLowTagged[2]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.tonysPink,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartLowTagged[3]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.tonysPink,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderColor: context.xMyCustomTheme.tonysPink,
          shape: DataMarkerType.rectangle,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartVeryLowTagged[1]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: Colors.white,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderWidth: 2,
          borderColor: context.xMyCustomTheme.roman,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartVeryLowTagged[2]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.roman,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          isVisible: true,
        ),
      ),

      //
      ScatterSeries<ChartData, DateTime>(
        dataSource: _chartVeryLowTagged[3]!,
        xValueMapper: (ChartData sales, _) => sales.x,
        yValueMapper: (ChartData sales, _) => sales.y,
        color: context.xMyCustomTheme.roman,
        borderWidth: 3,
        xAxisName: "Time",
        markerSettings: MarkerSettings(
          height: markerSize,
          width: markerSize,
          borderColor: context.xMyCustomTheme.roman,
          shape: DataMarkerType.rectangle,
          isVisible: true,
        ),
      ),

      //
      _selected == LocaleProvider.current.daily ||
              _selected == LocaleProvider.current.specific
          ? ScatterSeries<ChartData, DateTime>(
              dataSource: _chartData.isNotEmpty
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
              markerSettings: const MarkerSettings(
                height: 15,
                width: 15,
                isVisible: true,
              ),
            )
          : ScatterSeries<ChartData, DateTime>(
              dataSource: [
                ChartData(_startDate!, -50, Colors.transparent),
                ChartData(_endDate!, -50, Colors.transparent),
              ],
              xValueMapper: (ChartData sales, _) => sales.x,
              yValueMapper: (ChartData sales, _) => sales.y,
              color: Colors.red,
              xAxisName: "Time",
              markerSettings: MarkerSettings(
                height: markerSize,
                width: markerSize,
                isVisible: true,
              ),
            ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
