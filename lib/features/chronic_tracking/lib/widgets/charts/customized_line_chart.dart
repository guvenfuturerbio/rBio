import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'sample_view.dart';

class CustomizedLine extends SampleView {
  @override
  _LineDefaultState createState() => _LineDefaultState();
}

List<num> _xValues;
List<num> _yValues;
List<num> _xPointValues = <num>[];
List<num> _yPointValues = <num>[];

class _LineDefaultState extends SampleViewState {
  _LineDefaultState();

  @override
  Widget build(BuildContext context) {
    return _getCustomizedLineChart();
  }

  ///Get the cartesian chart
  SfCartesianChart _getCustomizedLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: isCardView ? '' : 'Capital investment as a share of exports'),
      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        dateFormat: DateFormat.Hm(),
        intervalType: DateTimeIntervalType.hours,
        interval: 6,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value} mg/dL',
          minimum: 10,
          maximum: 300,
          interval: 50,
          majorGridLines: MajorGridLines(color: Colors.transparent)),
      series: <ChartSeries<_ChartData, DateTime>>[
        LineSeries<_ChartData, DateTime>(
          animationDuration: 0,
          dataSource: <_ChartData>[
            //_ChartData(DateTime(2020, 11, 23, 00, 00), 300),
            _ChartData(DateTime(2020, 11, 23, 24, 00), 300),
            //_ChartData(DateTime(2020, 11, 23, 24, 00), 10),
          ],
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          enableTooltip: false,
          width: 2,
          color: Colors.black,
        ),
        LineSeries<_ChartData, DateTime>(
            onCreateRenderer: (ChartSeries<dynamic, dynamic> series) {
              return _CustomLineSeriesRenderer(series);
            },
            animationDuration: 2500,
            dataSource: <_ChartData>[
              _ChartData(DateTime(2020, 11, 23, 00, 00), _getRandomInt(5, 156)),
              _ChartData(DateTime(2020, 11, 23, 03, 11), _getRandomInt(5, 156)),
              _ChartData(DateTime(2020, 11, 23, 04, 23), _getRandomInt(5, 156)),
              _ChartData(DateTime(2020, 11, 23, 05, 15), _getRandomInt(5, 156)),
              _ChartData(DateTime(2020, 11, 23, 06, 31), _getRandomInt(5, 156)),
              _ChartData(DateTime(2020, 11, 23, 12, 56), _getRandomInt(5, 156)),
              _ChartData(DateTime(2020, 11, 23, 16, 34), _getRandomInt(5, 156)),
              _ChartData(
                  DateTime(2020, 11, 23, 18, 070), _getRandomInt(5, 156)),
              _ChartData(DateTime(2020, 11, 23, 21, 12), _getRandomInt(5, 156)),
              _ChartData(DateTime(2020, 11, 23, 22, 20), _getRandomInt(5, 156)),
            ],
            xValueMapper: (_ChartData sales, _) => sales.x,
            yValueMapper: (_ChartData sales, _) => sales.y,
            width: 2,
            markerSettings: MarkerSettings(isVisible: true)),
      ],
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }
}

num _getRandomInt(num min, num max) {
  final Random random = Random();
  return min + random.nextInt(max - min);
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final int y;
}

class _CustomLineSeriesRenderer extends LineSeriesRenderer {
  _CustomLineSeriesRenderer(this.series);

  final LineSeries<dynamic, dynamic> series;
  static Random randomNumber = Random();

  LineSegment createSegment() {
    return _LineCustomPainter(randomNumber.nextInt(4), series);
  }
}

class _LineCustomPainter extends LineSegment {
  _LineCustomPainter(int value, this.series) {
    //ignore: prefer_initializing_formals
    index = value;
    _xValues = <num>[];
    _yValues = <num>[];
  }

  final LineSeries<dynamic, dynamic> series;
  double maximum, minimum;
  int index;
  List<Color> colors = <Color>[
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.cyan
  ];

  @override
  Paint getStrokePaint() {
    final Paint customerStrokePaint = Paint();
    customerStrokePaint.color = const Color.fromRGBO(53, 92, 125, 1);
    customerStrokePaint.strokeWidth = 2;
    customerStrokePaint.style = PaintingStyle.stroke;
    return customerStrokePaint;
  }

  void _storeValues() {
    _xPointValues.add(points[0].dx);
    _xPointValues.add(points[1].dx);
    _yPointValues.add(points[0].dy);
    _yPointValues.add(points[1].dy);
    _xValues.add(points[0].dx);
    _xValues.add(points[1].dx);
    _yValues.add(points[0].dy);
    _yValues.add(points[1].dy);
  }

  @override
  void onPaint(Canvas canvas) {
    final double x1 = points[0].dx,
        y1 = points[0].dy,
        x2 = points[1].dx,
        y2 = points[1].dy;
    _storeValues();
    final Path path = Path();
    path.moveTo(x1, y1);
    path.lineTo(x2, y2);
    canvas.drawPath(path, getStrokePaint());

    if (currentSegmentIndex == series.dataSource.length - 2) {
      const double labelPadding = 10;
      final Paint topLinePaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final Paint bottomLinePaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      maximum = _yPointValues.reduce(max);
      minimum = _yPointValues.reduce(min);
      final Path bottomLinePath = Path();
      final Path topLinePath = Path();
      bottomLinePath.moveTo(_xPointValues[0], maximum);
      bottomLinePath.lineTo(_xPointValues[_xPointValues.length - 1], maximum);

      topLinePath.moveTo(_xPointValues[0], minimum);
      topLinePath.lineTo(_xPointValues[_xPointValues.length - 1], minimum);
      canvas.drawPath(
          _dashPath(
            bottomLinePath,
            dashArray: _CircularIntervalList<double>(<double>[15, 3, 3, 3]),
          ),
          bottomLinePaint);

      canvas.drawPath(
          _dashPath(
            topLinePath,
            dashArray: _CircularIntervalList<double>(<double>[15, 3, 3, 3]),
          ),
          topLinePaint);

      final TextSpan span = TextSpan(
        style: TextStyle(color: Colors.red[800], fontSize: 12.0),
        text: 'Low point',
      );
      final TextPainter tp =
          TextPainter(text: span, textDirection: prefix0.TextDirection.ltr);
      tp.layout();
      tp.paint(
          canvas,
          Offset(
              _xPointValues[_xPointValues.length - 4], maximum + labelPadding));
      final TextSpan span1 = TextSpan(
        style: TextStyle(color: Colors.green[800], fontSize: 12.0),
        text: 'High point',
      );
      final TextPainter tp1 =
          TextPainter(text: span1, textDirection: prefix0.TextDirection.ltr);
      tp1.layout();
      tp1.paint(
          canvas,
          Offset(_xPointValues[0] + labelPadding / 2,
              minimum - labelPadding - tp1.size.height));
      _yValues.clear();
      _yPointValues.clear();
    }
  }
}

Path _dashPath(
  Path source, {
  @required _CircularIntervalList<double> dashArray,
}) {
  if (source == null) {
    return null;
  }
  const double intialValue = 0.0;
  final Path path = Path();
  for (final PathMetric measurePath in source.computeMetrics()) {
    double distance = intialValue;
    bool draw = true;
    while (distance < measurePath.length) {
      final double length = dashArray.next;
      if (draw) {
        path.addPath(
            measurePath.extractPath(distance, distance + length), Offset.zero);
      }
      distance += length;
      draw = !draw;
    }
  }
  return path;
}

class _CircularIntervalList<T> {
  _CircularIntervalList(this._values);
  final List<T> _values;
  int _index = 0;
  T get next {
    if (_index >= _values.length) {
      _index = 0;
    }
    return _values[_index++];
  }
}
