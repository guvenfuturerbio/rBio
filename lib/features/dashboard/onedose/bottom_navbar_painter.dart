import 'package:flutter/material.dart';

class BottomNavbarCustomPainter extends CustomPainter {
  final Color backgroundColor;

  BottomNavbarCustomPainter(
    this.backgroundColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(0, 0);

    int x1 = 40;
    int x2 = 40;
    // path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(
        size.width / 2 - x1 - 15, 0, size.width / 2 - x1 - 10, 0);
    // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.quadraticBezierTo(size.width / 2 - x1 - 5, 0, size.width / 2 - x1, 20);
    path.arcToPoint(
      // Offset(size.width * 0.60, 20),
      Offset(size.width / 2 + x2, 20),
      radius: const Radius.circular(20.0),
      clockwise: false,
    );
    // path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(
        size.width / 2 + x2 + 5, 0, size.width / 2 + x2 + 10, 0);
    // path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.quadraticBezierTo(size.width / 2 + x2 + 15, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black, 0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
