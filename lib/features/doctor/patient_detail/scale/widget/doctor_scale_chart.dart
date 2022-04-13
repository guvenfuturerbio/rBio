import 'package:flutter/material.dart';
import 'package:onedosehealth/core/data/service/model/patient_scale_measurement.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../core/core.dart';

class DoctorScaleChart extends StatefulWidget {
  final List<PatientScaleMeasurement> list;
  final ZoomPanBehavior zoomPanBehavior;
  final ValueNotifier<PatientScaleMeasurement?>? pointTapNotifier;
  double? maximumWeight;
  double? minimumWeight;
  DoctorScaleChart({
    Key? key,
    required this.list,
    required this.zoomPanBehavior,
    this.pointTapNotifier,
  }) : super(key: key);

  @override
  State<DoctorScaleChart> createState() => _DoctorScaleChartState();
}

class _DoctorScaleChartState extends State<DoctorScaleChart> {
  @override
  void initState() {
    calculateMinMax(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // Zoom
      zoomPanBehavior: widget.zoomPanBehavior,
      onZooming: (ZoomPanArgs args) {
        // print(args.currentZoomFactor);
        // print(args.currentZoomPosition);
      },

      // Title
      title: ChartTitle(
        text: "",
        alignment: ChartAlignment.center,
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        borderWidth: 0,
        textStyle: Theme.of(context).textTheme.headline6,
      ),

      // Plot Area
      plotAreaBorderWidth: 0,
      plotAreaBorderColor: Colors.transparent,
      plotAreaBackgroundColor: getIt<ITheme>().mainColor,
      onPlotAreaSwipe: (detail) {},
      // plotAreaBackgroundImage: const AssetImage('images/bike.png'),

      // Legend
      legend: Legend(
        isVisible: false,
        title: LegendTitle(),
        backgroundColor: Colors.transparent,
        isResponsive: true,
        alignment: ChartAlignment.center,
        borderWidth: 2.0,
        borderColor: Colors.transparent,
        iconBorderWidth: 2.0,
        iconBorderColor: Colors.transparent,
        itemPadding: 10,
      ),
      onLegendTapped: (detail) {},
      onLegendItemRender: (detail) {},

      // General
      borderWidth: 0,
      borderColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(top: 16),
      // selectionType: SelectionType.point,

      // Primary
      primaryXAxis: CategoryAxis(
        plotOffset: 10,
        visibleMaximum: 10,
        labelPlacement: LabelPlacement.onTicks,
        majorGridLines: const MajorGridLines(
          width: 0,
          color: Colors.transparent,
        ),
        minorGridLines: const MinorGridLines(
          width: 0,
          color: Colors.transparent,
        ),
        majorTickLines: const MajorTickLines(
          size: 0,
          color: Colors.transparent,
        ),

        //
        borderWidth: 0,
        borderColor: Colors.transparent,

        axisLine: const AxisLine(
          width: 0.01,
          color: Colors.transparent,
        ),
        axisLabelFormatter: (detail) {
          return ChartAxisLabel(
            "",
            const TextStyle(fontSize: 0),
          );
        },
        axisBorderType: AxisBorderType.rectangle,
      ),
      primaryYAxis: NumericAxis(
        minimum: widget.minimumWeight,
        maximum: widget.maximumWeight,
        edgeLabelPlacement: EdgeLabelPlacement.shift,

        //
        majorGridLines: const MajorGridLines(
          width: 0.5,
          color: Colors.grey,
        ),
        majorTickLines: const MajorTickLines(
          size: 0,
          width: 0,
          color: Colors.transparent,
        ),
        minorTickLines: const MinorTickLines(
          size: 0,
          width: 0,
          color: Colors.transparent,
        ),

        //
        title: AxisTitle(
          text: "",
          alignment: ChartAlignment.center,
          textStyle: const TextStyle(),
        ),

        //
        axisLine: const AxisLine(
          width: 0,
          color: Colors.transparent,
        ),
        axisBorderType: AxisBorderType.withoutTopAndBottom,

        //
        labelFormat: '{value}',
        labelStyle: const TextStyle(fontSize: 10),

        //
        borderWidth: 0,
        borderColor: Colors.transparent,
      ),

      // Series
      series: _getSeries(context, widget.list),

      // Trackball
      trackballBehavior: TrackballBehavior(),

      // Tooltip
      onTooltipRender: (detail) {},
      tooltipBehavior: TooltipBehavior(
        enable: true,
        color: Colors.black, // Background Color
        borderWidth: 0,
        borderColor: Colors.transparent,
        // header: "Header",
        textStyle: const TextStyle(fontSize: 13),
        elevation: 4,
        shadowColor: Colors.black,
        shouldAlwaysShow: false,
        tooltipPosition: TooltipPosition.auto,
        format: 'point.x | point.y KG',
      ),
    );
  }

  List<SplineSeries<PatientScaleMeasurement, String>> _getSeries(
    BuildContext context,
    List<PatientScaleMeasurement> list,
  ) {
    return <SplineSeries<PatientScaleMeasurement, String>>[
      SplineSeries<PatientScaleMeasurement, String>(
        name: LocaleProvider.of(context).scale_graph,
        width: 5,
        trendlines: const [],
        enableTooltip: true,

        //
        pointColorMapper: (d1, d2) {
          return Colors.green;
        },
        onPointTap: (detail) {
          if (detail.pointIndex != null) {
            final selectedItem = list[detail.pointIndex!];
            if (widget.pointTapNotifier != null) {
              widget.pointTapNotifier!.value = selectedItem;
            }
          }
        },
        onPointDoubleTap: (detail) {
          // print("[onPointDoubleTap] - ${detail.dataPoints}");
        },
        onPointLongPress: (detail) {
          // print("[onPointLongPress] - ${detail.dataPoints}");
        },
        onRendererCreated: (controller) {
          //
        },

        // Legend
        legendItemText: LocaleProvider.of(context).weight,
        isVisibleInLegend: true,
        legendIconType: LegendIconType.seriesType,

        // Data Source
        dataSource: list,
        xValueMapper: (PatientScaleMeasurement sales, int index) =>
            DateTime.parse(sales.occurrenceTime!).xFormatTime3(),
        yValueMapper: (PatientScaleMeasurement sales, int index) =>
            sales.weight,

        // Marker
        markerSettings: const MarkerSettings(
          isVisible: true,
          borderColor: null,
          color: null,
          height: null,
          width: null,
        ),

        //
        isVisible: true,
        splineType: SplineType.natural,
        sortingOrder: SortingOrder.ascending,
        sortFieldValueMapper: (_, __) => DateTime.parse(_.occurrenceTime!),
      ),
    ];
  }

  void calculateMinMax(List<PatientScaleMeasurement> list) {
    widget.maximumWeight = (list
        .reduce((a, b) => (a.weight ?? 0) > (b.weight ?? 0) ? a : b)).weight;
    widget.minimumWeight = (list
        .reduce((a, b) => (a.weight ?? 0) < (b.weight ?? 0) ? a : b)).weight;
  }
}
