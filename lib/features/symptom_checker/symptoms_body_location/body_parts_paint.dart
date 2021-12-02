import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../core/core.dart';
import '../../../model/model.dart';
import 'package:path_drawing/path_drawing.dart';

class Shape {
  Shape(strPath, this.label, this.id, this.tmpOffset)
      : path = parseSvgPathData(strPath);

  /// transforms a [path] into [transformedPath] using given [matrix]
  void transform(Matrix4 matrix) =>
      transformedPath = path.transform(matrix.storage);

  final Offset tmpOffset;
  final Path path;
  Path transformedPath;
  final String label;
  final int id;
}

class BodyPartsPainter extends CustomPainter {
  BodyPartsPainter(
      {this.notifier,
      this.clickedPathFunc,
      this.bodyLocations,
      this.isGenderMale})
      : super(repaint: notifier);
  Function clickedPathFunc;
  List<GetBodyLocationResponse> bodyLocations;
  bool isGenderMale;

  List<Shape> get shapes => [
        Shape(
            this.isGenderMale
                ? R.bodyDatas.maleData[0]
                : R.bodyDatas.femaleData[0],
            'Head, throat & neck, baş, boğaz, boyun, kafa',
            6,
            this.isGenderMale ? Offset(100.0, 44.0) : Offset(97.5, 70.0)),
        Shape(
            this.isGenderMale
                ? R.bodyDatas.maleData[1]
                : R.bodyDatas.femaleData[1],
            'Arms & shoulder, arm, Kol, omuz, kollar, omuzlar',
            7,
            this.isGenderMale ? Offset(169.7, 136.0) : Offset(58.7, 142.1)),
        Shape(
            this.isGenderMale
                ? R.bodyDatas.maleData[2]
                : R.bodyDatas.femaleData[2],
            'Arms & shoulder, arm, Kol, omuz, kollar, omuzlar',
            7,
            this.isGenderMale ? Offset(169.7, 136.0) : Offset(58.7, 142.1)),
        Shape(
            this.isGenderMale
                ? R.bodyDatas.maleData[3]
                : R.bodyDatas.femaleData[3],
            'Chest & back, Göğüs, sırt',
            15,
            this.isGenderMale ? Offset(97.7, 117.0) : Offset(102.2, 140.2)),
        Shape(
            this.isGenderMale
                ? R.bodyDatas.maleData[4]
                : R.bodyDatas.femaleData[4],
            'Abdomen, pelvis & buttocks, karın, bel, kalça',
            16,
            this.isGenderMale ? Offset(106.0, 199.0) : Offset(104.1, 221.3)),
        Shape(
            this.isGenderMale
                ? R.bodyDatas.maleData[5]
                : R.bodyDatas.femaleData[5],
            'Legs, Leg, bacak, bacaklar',
            10,
            this.isGenderMale ? Offset(137.0, 300.0) : Offset(126.8, 281.7)),
        Shape(
            this.isGenderMale
                ? R.bodyDatas.maleData[6]
                : R.bodyDatas.femaleData[6],
            'Legs, Leg, bacak, bacaklar',
            10,
            this.isGenderMale ? Offset(137.0, 300.0) : Offset(126.8, 281.7)),
      ];

  final ValueNotifier<Offset> notifier;
  final Paint _paint = Paint();
  Size _size = Size.zero;

  @override
  void paint(Canvas canvas, Size size) {
    var myList = shapes;
    if (size != _size) {
      _size = size;
      final fs = this.isGenderMale
          ? applyBoxFit(BoxFit.contain, Size(size.width + 80, 1620.00000), size)
          : applyBoxFit(
              BoxFit.contain, Size(size.width + 525, 1660.00000), size);
      final r = Alignment.center.inscribe(fs.destination, Offset.zero & size);
      final matrix = Matrix4.translationValues(r.left, r.top, 0)
        ..scale(fs.destination.width / fs.source.width);
      for (var shape in myList) {
        shape.transform(matrix);
      }
    }
    canvas..clipRect(Offset.zero & size);
    for (var shape in myList) {
      final path = shape.transformedPath;
      _paint
        ..color = Colors.grey
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, _paint);
    }
    for (var shape in myList) {
      final path = shape.transformedPath;
      final selected = path.contains(notifier.value);
      if (selected) {
        _paint
          ..color = getIt<ITheme>().mainColor.withOpacity(0.7)
          ..style = PaintingStyle.fill;
        clickedPathFunc(shape.id);
        if (shape.label == myList[1].label || shape.label == myList[2].label) {
          canvas.drawPath(myList[1].transformedPath, _paint);
          canvas.drawPath(myList[2].transformedPath, _paint);
        } else if (shape.label == myList[5].label ||
            shape.label == myList[6].label) {
          canvas.drawPath(myList[5].transformedPath, _paint);
          canvas.drawPath(myList[6].transformedPath, _paint);
        } else {
          canvas.drawPath(path, _paint);
        }
        break;
      } else {
        clickedPathFunc(null);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
