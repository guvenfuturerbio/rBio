/// Example of a time series chart with range annotations configured to render
/// labels in the chart margin area.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class TimeSeriesRangeAnnotationMarginChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  TimeSeriesRangeAnnotationMarginChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesRangeAnnotationMarginChart.withSampleData() {
    return new TimeSeriesRangeAnnotationMarginChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: new charts.TimeSeriesChart(seriesList, animate: animate,
          // Allow enough space in the left and right chart margins for the
          // annotations.
          selectionModels: [
            charts.SelectionModelConfig(
                changedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection)
                print(model.selectedSeries[0]
                    .domainFn(model.selectedDatum[0].index));
              print(model.selectedSeries[0]
                  .measureFn(model.selectedDatum[0].index));
            })
          ],
          /*layoutConfig: new charts.LayoutConfig(
                leftMarginSpec: new charts.MarginSpec.fixedPixel(60),
                topMarginSpec: new charts.MarginSpec.fixedPixel(20),
                rightMarginSpec: new charts.MarginSpec.fixedPixel(60),
                bottomMarginSpec: new charts.MarginSpec.fixedPixel(20)),*/
          behaviors: [
            // Define one domain and two measure annotations configured to render
            // labels in the chart margins.
            new charts.RangeAnnotation([
              new charts.RangeAnnotationSegment(
                  new DateTime(2020, 10, 16),
                  new DateTime(2020, 10, 16),
                  charts.RangeAnnotationAxisType.domain,
                  startLabel: ' ',
                  endLabel: ' ',
                  labelAnchor: charts.AnnotationLabelAnchor.end,
                  color: charts.MaterialPalette.transparent,
                  // Override the default vertical direction for domain labels.
                  labelDirection: charts.AnnotationLabelDirection.horizontal),
              new charts.RangeAnnotationSegment(
                  85, 89, charts.RangeAnnotationAxisType.measure,
                  labelStyleSpec: charts.TextStyleSpec(
                      color: charts.ColorUtil.fromDartColor(
                          Colors.orange.shade200)),
                  startLabel: '',
                  endLabel: ' ',
                  labelAnchor: charts.AnnotationLabelAnchor.end,
                  color: charts.ColorUtil.fromDartColor(Colors.black)),
              new charts.RangeAnnotationSegment(
                  69, 72, charts.RangeAnnotationAxisType.measure,
                  labelStyleSpec: charts.TextStyleSpec(
                      color: charts.ColorUtil.fromDartColor(
                          Colors.orange.shade200)),
                  startLabel: '',
                  endLabel: ' ',
                  labelAnchor: charts.AnnotationLabelAnchor.end,
                  color:
                      charts.ColorUtil.fromDartColor(Colors.orange.shade200)),
              new charts.RangeAnnotationSegment(
                  80, 120, charts.RangeAnnotationAxisType.measure,
                  labelStyleSpec: charts.TextStyleSpec(
                      color: charts.MaterialPalette.green.shadeDefault),
                  startLabel: '',
                  endLabel: ' ',
                  labelAnchor: charts.AnnotationLabelAnchor.end,
                  color: charts.ColorUtil.fromDartColor(Colors.green.shade200)),
              new charts.RangeAnnotationSegment(
                  0, 65, charts.RangeAnnotationAxisType.measure,
                  labelStyleSpec: charts.TextStyleSpec(
                      color: charts.MaterialPalette.red.shadeDefault),
                  startLabel: ' ',
                  endLabel: ' ',
                  labelAnchor: charts.AnnotationLabelAnchor.end,
                  color: charts.ColorUtil.fromDartColor(Colors.red.shade200)),
              new charts.RangeAnnotationSegment(
                  180, 300, charts.RangeAnnotationAxisType.measure,
                  labelStyleSpec: charts.TextStyleSpec(
                      color: charts.MaterialPalette.red.shadeDefault),
                  startLabel: ' ',
                  endLabel: ' ',
                  labelAnchor: charts.AnnotationLabelAnchor.end,
                  color: charts.ColorUtil.fromDartColor(Colors.red.shade200)),
              new charts.RangeAnnotationSegment(
                  120, 180, charts.RangeAnnotationAxisType.measure,
                  labelStyleSpec: charts.TextStyleSpec(
                      color: charts.MaterialPalette.red.shadeDefault),
                  startLabel: '',
                  endLabel: '',
                  labelAnchor: charts.AnnotationLabelAnchor.end,
                  color:
                      charts.ColorUtil.fromDartColor(Colors.yellow.shade200)),
            ], defaultLabelPosition: charts.AnnotationLabelPosition.margin),
          ]),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
          id: 'Sales',
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: data)
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
