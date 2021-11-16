import 'package:flutter/cupertino.dart';

/// Package import
import 'package:flutter/material.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/charts/sample_view.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Render the rounded corner doughnut series.
class DoughnutRounded extends SampleView {
  /// Creates the rounded corner doughnut series.
  final String radius;
  DoughnutRounded({this.radius});
  @override
  _DoughnutRoundedState createState() => _DoughnutRoundedState(radius: radius);
}

/// State class of rounded corner doughnut series.
class _DoughnutRoundedState extends SampleViewState {
  _DoughnutRoundedState({this.radius});
  int startAngle = 270;
  int endAngle = 90;
  String radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getRoundedDoughnutChart(),
    );
  }

  /// Returns the circular charts with rounded corner doughnut series.
  SfCircularChart _getRoundedDoughnutChart() {
    return radius == '90%'
        ? SfCircularChart(
            centerY: '50%',
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                  widget: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.040),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        //padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.040),
                        child: Text('100',
                            style:
                                TextStyle(color: Colors.green, fontSize: 30))),
                    Text(
                      "mg/dL",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    Text(
                      "${LocaleProvider.current.last_measurement}",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    )
                  ],
                ),
              ))
            ],
            palette: [R.color.very_low, R.color.target, R.color.very_high],
            legend: Legend(
                isVisible: !isCardView,
                overflowMode: LegendItemOverflowMode.scroll),
            title: ChartTitle(
                text: isCardView ? '' : 'Software development cycle'),
            series: _getRoundedDoughnutSeries(),
          )
        : SfCircularChart(
            centerY: '20%',
            annotations: <CircularChartAnnotation>[
              /*CircularChartAnnotation(
            height: '100%',
            width: '100%',
            widget: Container(
                child: PhysicalModel(
                    child: Container(),
                    shape: BoxShape.circle,
                    elevation: 10,
                    shadowColor: R.color.very_low,
                    color: R.color.very_low))),*/
              CircularChartAnnotation(
                  widget: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.065),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${LocaleProvider.current.estimated_hb1ac}",
                      style: TextStyle(color: R.color.very_low, fontSize: 12),
                    ),
                    Container(
                        //padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040),
                        child: Text('3.8',
                            style: TextStyle(
                                color: R.color.very_low, fontSize: 25))),
                    Text(
                      "",
                      style: TextStyle(color: R.color.very_low, fontSize: 12),
                    )
                  ],
                ),
              ))
            ],
            palette: [R.color.very_low, R.color.target, R.color.very_high],
            legend: Legend(
                isVisible: !isCardView,
                overflowMode: LegendItemOverflowMode.scroll),
            title: ChartTitle(
                text: isCardView ? '' : 'Software development cycle'),
            series: _getRoundedDoughnutSeries2(),
          );
  }

  /// Returns rounded corner doughunut series.
  List<DoughnutSeries<ChartSampleData, String>> _getRoundedDoughnutSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Planning', y: 10, text: "0-50"),
      ChartSampleData(x: 'Analysis', y: 20, text: "50-120 mg/dL"),
      ChartSampleData(x: 'Design', y: 10, text: "120-170"),
    ];
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: chartData,
          animationDuration: 0,
          startAngle: startAngle,
          endAngle: endAngle,
          cornerStyle: CornerStyle.bothCurve,
          radius: radius != null ? radius : '60%',
          innerRadius: '75%',
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          //explodeAll: true,
          explode: true,
          explodeOffset: '10%',
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(fontSize: 10),
              labelAlignment: ChartDataLabelAlignment.middle,
              borderRadius: 12,
              margin: EdgeInsets.only(bottom: 5))),
    ];
  }

  List<DoughnutSeries<ChartSampleData, String>> _getRoundedDoughnutSeries2() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Planning', y: 10, text: "0-50"),
      ChartSampleData(x: 'Analysis', y: 20, text: "%5-%7"),
      ChartSampleData(x: 'Design', y: 10, text: "120-170"),
    ];
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: chartData,
          animationDuration: 0,
          startAngle: endAngle,
          endAngle: startAngle,
          cornerStyle: CornerStyle.bothCurve,
          radius: radius != null ? radius : '60%',
          innerRadius: '75%',
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          //explodeAll: true,
          explode: true,
          explodeOffset: '10%',
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(fontSize: 10),
              labelAlignment: ChartDataLabelAlignment.middle,
              borderRadius: 12,
              margin: EdgeInsets.only(bottom: 5))),
    ];
  }
}
