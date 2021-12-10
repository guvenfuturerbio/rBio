import 'dart:ui';

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
