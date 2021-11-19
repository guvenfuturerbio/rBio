import 'package:flutter/material.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../helper/resources.dart';
import '../../pages/progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import 'custom_directional_button.dart';
import 'sample_view.dart';

/// Render the semi pie series.
class PieSemi extends SampleView {
  @override
  _PieSemiState createState() => _PieSemiState();
}

class _PieSemiState extends SampleViewState {
  int veryLowCount;
  int lowCount;
  int targetCount;
  int highCount;
  int veryHighCount;
  //_PieSemiState();
  int _startAngle = 270;
  int _endAngle = 90;

  @override
  Widget buildSettings(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: CustomDirectionalButtons(
                    minValue: 90,
                    maxValue: 270,
                    initialValue: _startAngle.toDouble(),
                    onChanged: (double val) => setState(() {
                      _startAngle = val.toInt();
                    }),
                    step: 10,
                    iconColor: model.textColor,
                    style: TextStyle(fontSize: 20.0, color: model.textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text('${LocaleProvider.current.end_angle} ',
                    style: TextStyle(fontSize: 16.0, color: model.textColor)),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: CustomDirectionalButtons(
                    minValue: 90,
                    maxValue: 270,
                    initialValue: _endAngle.toDouble(),
                    onChanged: (double val) => setState(() {
                      _endAngle = val.toInt();
                    }),
                    step: 10,
                    iconColor: model.textColor,
                    style: TextStyle(fontSize: 20.0, color: model.textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressPageViewModel>(builder: (context, value, child) {
      veryHighCount = value.chartVeryHigh?.length ?? 0;
      highCount = value.chartHigh?.length ?? 0;
      targetCount = value.chartTarget?.length ?? 0;
      lowCount = value.chartLow?.length ?? 0;
      veryLowCount = value.chartVeryLow?.length ?? 0;
      return Container(child: _getSemiPieChart());
    });
  }

  /// Return the circular chart with semi pie series.
  SfCircularChart _getSemiPieChart() {
    return SfCircularChart(
      centerY: '35%',
      title: ChartTitle(
          text: isCardView ? '' : 'Rural population of various countries'),
      legend: Legend(
          isVisible: !isCardView, overflowMode: LegendItemOverflowMode.wrap),
      series: _getSemiPieSeries(),
      palette: [
        R.color.very_low,
        R.color.low,
        R.color.target,
        R.color.high,
        R.color.very_high
      ],
      tooltipBehavior:
          TooltipBehavior(enable: true, format: 'point.x : point.y'),
    );
  }

  /// Return the semi pie series.
  List<PieSeries<ChartSampleData, String>> _getSemiPieSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: veryLowCount > 0 ? LocaleProvider.current.very_low : '',
          y: veryLowCount),
      ChartSampleData(
          x: lowCount > 0 ? LocaleProvider.current.low : '', y: lowCount),
      ChartSampleData(
          x: targetCount > 0 ? LocaleProvider.current.target : '',
          y: targetCount),
      ChartSampleData(
          x: highCount > 0 ? LocaleProvider.current.high : '', y: highCount),
      ChartSampleData(
          x: veryHighCount > 0 ? LocaleProvider.current.very_high : '',
          y: veryHighCount)
    ];
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.x,

          /// If we set start and end angle given below
          /// it will render as semi pie chart.
          startAngle: _startAngle ?? 270,
          endAngle: _endAngle ?? 90,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.inside))
    ];
  }
}
