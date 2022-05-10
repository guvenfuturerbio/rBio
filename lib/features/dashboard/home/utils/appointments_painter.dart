// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class HomeAppointmentsCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8687434, 0);
    path_0.lineTo(size.width * 0.2312303, 0);
    path_0.cubicTo(
        size.width * 0.1096430,
        size.height * 0.08048688,
        size.width * 0.03758313,
        size.height * 0.2291623,
        size.width * 0.01133182,
        size.height * 0.3734153);
    path_0.cubicTo(
        size.width * -0.002318866,
        size.height * 0.4481742,
        size.width * -0.006737837,
        size.height * 0.5263025,
        size.width * 0.01570704,
        size.height * 0.5990397);
    path_0.cubicTo(
        size.width * 0.06055303,
        size.height * 0.7432506,
        size.width * 0.2008225,
        size.height * 0.8387735,
        size.width * 0.3391232,
        size.height * 0.9089837);
    path_0.cubicTo(
        size.width * 0.3980574,
        size.height * 0.9389294,
        size.width * 0.4588292,
        size.height * 0.9665586,
        size.width * 0.5233637,
        size.height * 0.9826475);
    path_0.arcToPoint(Offset(size.width * 0.7156545, size.height * 0.9984838),
        radius:
            Radius.elliptical(size.width * 0.6051365, size.height * 0.5825296),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.cubicTo(
        size.width * 0.8156720,
        size.height * 0.9919555,
        size.width * 0.9158645,
        size.height * 0.9623047,
        size.width * 1.000044,
        size.height * 0.9104999);
    path_0.lineTo(size.width * 1.000044, size.height * 0.1263530);
    path_0.arcToPoint(Offset(size.width * 0.8687434, 0),
        radius:
            Radius.elliptical(size.width * 0.1312566, size.height * 0.1263530),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xffffd9ad).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.8000088, size.height * 0.4961884);
    path_1.quadraticBezierTo(size.width * 0.8050403, size.height * 0.4060565,
        size.width * 0.8057840, size.height * 0.3158826);
    path_1.cubicTo(
        size.width * 0.8057840,
        size.height * 0.2928442,
        size.width * 0.8063528,
        size.height * 0.2685844,
        size.width * 0.7955023,
        size.height * 0.2473992);
    path_1.arcToPoint(Offset(size.width * 0.7730574, size.height * 0.2244030),
        radius: Radius.elliptical(
            size.width * 0.05482149, size.height * 0.05277345),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.7605005,
        size.height * 0.2177905,
        size.width * 0.7460186,
        size.height * 0.2165691,
        size.width * 0.7320179,
        size.height * 0.2155162);
    path_1.cubicTo(
        size.width * 0.7013913,
        size.height * 0.2132839,
        size.width * 0.6707648,
        size.height * 0.2132839,
        size.width * 0.6401383,
        size.height * 0.2133260);
    path_1.lineTo(size.width * 0.5464211, size.height * 0.2133260);
    path_1.lineTo(size.width * 0.3588117, size.height * 0.2136630);
    path_1.cubicTo(
        size.width * 0.3415733,
        size.height * 0.2136630,
        size.width * 0.3243787,
        size.height * 0.2136630,
        size.width * 0.3071404,
        size.height * 0.2136630);
    path_1.cubicTo(
        size.width * 0.2923521,
        size.height * 0.2136630,
        size.width * 0.2768638,
        size.height * 0.2143369,
        size.width * 0.2628631,
        size.height * 0.2194752);
    path_1.arcToPoint(Offset(size.width * 0.2322366, size.height * 0.2447458),
        radius: Radius.elliptical(
            size.width * 0.05530277, size.height * 0.05323674),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.2322366, size.height * 0.2831993),
        radius: Radius.elliptical(
            size.width * 0.04152083, size.height * 0.03996968),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.2393245,
        size.height * 0.2949080,
        size.width * 0.2584879,
        size.height * 0.2843364,
        size.width * 0.2511376,
        size.height * 0.2725856);
    path_1.cubicTo(
        size.width * 0.2467623,
        size.height * 0.2655941,
        size.width * 0.2490812,
        size.height * 0.2577181,
        size.width * 0.2536752,
        size.height * 0.2510214);
    path_1.arcToPoint(Offset(size.width * 0.2790515, size.height * 0.2366592),
        radius: Radius.elliptical(
            size.width * 0.03876444, size.height * 0.03731626),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.3151908, size.height * 0.2345533),
        radius:
            Radius.elliptical(size.width * 0.1690147, size.height * 0.1627006),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.3589429, size.height * 0.2345533);
    path_1.lineTo(size.width * 0.5356143, size.height * 0.2342585);
    path_1.cubicTo(
        size.width * 0.5935422,
        size.height * 0.2342585,
        size.width * 0.6517326,
        size.height * 0.2325738,
        size.width * 0.7096167,
        size.height * 0.2349745);
    path_1.arcToPoint(Offset(size.width * 0.7485562, size.height * 0.2380491),
        radius:
            Radius.elliptical(size.width * 0.2696885, size.height * 0.2596134),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.7730137, size.height * 0.2516952),
        radius: Radius.elliptical(
            size.width * 0.03657683, size.height * 0.03521038),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.7841267,
        size.height * 0.2671103,
        size.width * 0.7839954,
        size.height * 0.2882113,
        size.width * 0.7839079,
        size.height * 0.3061534);
    path_1.quadraticBezierTo(size.width * 0.7835579, size.height * 0.4011709,
        size.width * 0.7780889, size.height * 0.4960199);
    path_1.cubicTo(
        size.width * 0.7773451,
        size.height * 0.5095818,
        size.width * 0.7992212,
        size.height * 0.5095397,
        size.width * 0.7999650,
        size.height * 0.4960199);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.2282989, size.height * 0.2742703);
    path_2.lineTo(size.width * 0.2289552, size.height * 0.5817294);
    path_2.cubicTo(
        size.width * 0.2289552,
        size.height * 0.6039675,
        size.width * 0.2260238,
        size.height * 0.6297856,
        size.width * 0.2383619,
        size.height * 0.6497494);
    path_2.cubicTo(
        size.width * 0.2484249,
        size.height * 0.6660489,
        size.width * 0.2667133,
        size.height * 0.6748094,
        size.width * 0.2853518,
        size.height * 0.6787264);
    path_2.cubicTo(
        size.width * 0.3076216,
        size.height * 0.6834014,
        size.width * 0.3310291,
        size.height * 0.6832751,
        size.width * 0.3536927,
        size.height * 0.6839911);
    path_2.quadraticBezierTo(size.width * 0.3925446, size.height * 0.6852546,
        size.width * 0.4314403, size.height * 0.6850861);
    path_2.cubicTo(
        size.width * 0.4907683,
        size.height * 0.6847913,
        size.width * 0.5500525,
        size.height * 0.6830224,
        size.width * 0.6093805,
        size.height * 0.6818010);
    path_2.cubicTo(
        size.width * 0.6234249,
        size.height * 0.6815061,
        size.width * 0.6234687,
        size.height * 0.6604473,
        size.width * 0.6093805,
        size.height * 0.6607421);
    path_2.cubicTo(
        size.width * 0.5584092,
        size.height * 0.6617951,
        size.width * 0.5074816,
        size.height * 0.6631007,
        size.width * 0.4565103,
        size.height * 0.6637746);
    path_2.cubicTo(
        size.width * 0.4308715,
        size.height * 0.6641115,
        size.width * 0.4051890,
        size.height * 0.6641536,
        size.width * 0.3795502,
        size.height * 0.6637746);
    path_2.cubicTo(
        size.width * 0.3558803,
        size.height * 0.6633113,
        size.width * 0.3320354,
        size.height * 0.6630165,
        size.width * 0.3084092,
        size.height * 0.6610369);
    path_2.cubicTo(
        size.width * 0.2928771,
        size.height * 0.6596892,
        size.width * 0.2745450,
        size.height * 0.6568252,
        size.width * 0.2628194,
        size.height * 0.6460009);
    path_2.cubicTo(
        size.width * 0.2478124,
        size.height * 0.6320600,
        size.width * 0.2508750,
        size.height * 0.6086004,
        size.width * 0.2508313,
        size.height * 0.5903214);
    path_2.lineTo(size.width * 0.2505250, size.height * 0.4408457);
    path_2.lineTo(size.width * 0.2501750, size.height * 0.2745230);
    path_2.cubicTo(
        size.width * 0.2501750,
        size.height * 0.2610032,
        size.width * 0.2282989,
        size.height * 0.2609611,
        size.width * 0.2282989,
        size.height * 0.2745230);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3132657, size.height * 0.1617319);
    path_3.arcToPoint(Offset(size.width * 0.3099405, size.height * 0.2325738),
        radius:
            Radius.elliptical(size.width * 0.1922034, size.height * 0.1850230),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.3220599, size.height * 0.2569178),
        radius: Radius.elliptical(
            size.width * 0.04335842, size.height * 0.04173862),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.3538239, size.height * 0.2598661),
        radius: Radius.elliptical(
            size.width * 0.02708260, size.height * 0.02607084),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.cubicTo(
        size.width * 0.3640620,
        size.height * 0.2543065,
        size.width * 0.3693997,
        size.height * 0.2438613,
        size.width * 0.3728124,
        size.height * 0.2335004);
    path_3.arcToPoint(Offset(size.width * 0.3788939, size.height * 0.1993851),
        radius:
            Radius.elliptical(size.width * 0.1337504, size.height * 0.1287537),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.3752188, size.height * 0.1640062),
        radius:
            Radius.elliptical(size.width * 0.1366381, size.height * 0.1315335),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.cubicTo(
        size.width * 0.3725499,
        size.height * 0.1531820,
        size.width * 0.3681309,
        size.height * 0.1421050,
        size.width * 0.3587242,
        size.height * 0.1351135);
    path_3.arcToPoint(Offset(size.width * 0.3230662, size.height * 0.1347766),
        radius: Radius.elliptical(
            size.width * 0.02787014, size.height * 0.02682896),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.cubicTo(
        size.width * 0.3143157,
        size.height * 0.1420629,
        size.width * 0.3115156,
        size.height * 0.1538138,
        size.width * 0.3116468,
        size.height * 0.1645116);
    path_3.cubicTo(
        size.width * 0.3116468,
        size.height * 0.1780314,
        size.width * 0.3335229,
        size.height * 0.1780735,
        size.width * 0.3335229,
        size.height * 0.1645116);
    path_3.arcToPoint(Offset(size.width * 0.3368918, size.height * 0.1508234),
        radius: Radius.elliptical(
            size.width * 0.02086979, size.height * 0.02009013),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.cubicTo(
        size.width * 0.3401295,
        size.height * 0.1475803,
        size.width * 0.3456423,
        size.height * 0.1508234,
        size.width * 0.3479611,
        size.height * 0.1540243);
    path_3.arcToPoint(Offset(size.width * 0.3550928, size.height * 0.1741145),
        radius: Radius.elliptical(
            size.width * 0.05219636, size.height * 0.05024639),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.arcToPoint(Offset(size.width * 0.3569741, size.height * 0.1982058),
        radius:
            Radius.elliptical(size.width * 0.1114806, size.height * 0.1073158),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.arcToPoint(Offset(size.width * 0.3533427, size.height * 0.2221286),
        radius:
            Radius.elliptical(size.width * 0.1158995, size.height * 0.1115697),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.cubicTo(
        size.width * 0.3517238,
        size.height * 0.2280251,
        size.width * 0.3498425,
        size.height * 0.2360696,
        size.width * 0.3445922,
        size.height * 0.2401971);
    path_3.cubicTo(
        size.width * 0.3346167,
        size.height * 0.2481574,
        size.width * 0.3314666,
        size.height * 0.2310997,
        size.width * 0.3305915,
        size.height * 0.2241503);
    path_3.arcToPoint(Offset(size.width * 0.3342230, size.height * 0.1673335),
        radius:
            Radius.elliptical(size.width * 0.1808715, size.height * 0.1741145),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.cubicTo(
        size.width * 0.3373731,
        size.height * 0.1541507,
        size.width * 0.3162846,
        size.height * 0.1485069,
        size.width * 0.3131344,
        size.height * 0.1617319);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.6538764, size.height * 0.1617319);
    path_4.arcToPoint(Offset(size.width * 0.6505950, size.height * 0.2325738),
        radius:
            Radius.elliptical(size.width * 0.1913283, size.height * 0.1841806),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.6626706, size.height * 0.2569178),
        radius: Radius.elliptical(
            size.width * 0.04305215, size.height * 0.04144379),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.6944347, size.height * 0.2598661),
        radius: Radius.elliptical(
            size.width * 0.02708260, size.height * 0.02607084),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.7046727,
        size.height * 0.2543065,
        size.width * 0.7100105,
        size.height * 0.2438613,
        size.width * 0.7134669,
        size.height * 0.2335004);
    path_4.arcToPoint(Offset(size.width * 0.7158295, size.height * 0.1640062),
        radius:
            Radius.elliptical(size.width * 0.1361568, size.height * 0.1310702),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.7131607,
        size.height * 0.1531820,
        size.width * 0.7087417,
        size.height * 0.1421050,
        size.width * 0.6993350,
        size.height * 0.1351135);
    path_4.arcToPoint(Offset(size.width * 0.6636769, size.height * 0.1348187),
        radius: Radius.elliptical(
            size.width * 0.02787014, size.height * 0.02682896),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.6549265,
        size.height * 0.1421050,
        size.width * 0.6521264,
        size.height * 0.1538559,
        size.width * 0.6522576,
        size.height * 0.1645538);
    path_4.cubicTo(
        size.width * 0.6522576,
        size.height * 0.1780735,
        size.width * 0.6741337,
        size.height * 0.1781157,
        size.width * 0.6741337,
        size.height * 0.1645538);
    path_4.arcToPoint(Offset(size.width * 0.6775901, size.height * 0.1510340),
        radius: Radius.elliptical(
            size.width * 0.02086979, size.height * 0.02009013),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.6808715,
        size.height * 0.1477909,
        size.width * 0.6861218,
        size.height * 0.1510340,
        size.width * 0.6886594,
        size.height * 0.1542349);
    path_4.arcToPoint(Offset(size.width * 0.6956598, size.height * 0.1741145),
        radius: Radius.elliptical(
            size.width * 0.05088379, size.height * 0.04898286),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.arcToPoint(Offset(size.width * 0.6939097, size.height * 0.2221286),
        radius:
            Radius.elliptical(size.width * 0.1142807, size.height * 0.1100114),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.6922909,
        size.height * 0.2280251,
        size.width * 0.6904095,
        size.height * 0.2360696,
        size.width * 0.6851593,
        size.height * 0.2401971);
    path_4.cubicTo(
        size.width * 0.6751400,
        size.height * 0.2481574,
        size.width * 0.6720336,
        size.height * 0.2310997,
        size.width * 0.6711148,
        size.height * 0.2241503);
    path_4.arcToPoint(Offset(size.width * 0.6747462, size.height * 0.1673335),
        radius:
            Radius.elliptical(size.width * 0.1808715, size.height * 0.1741145),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.6778964,
        size.height * 0.1541507,
        size.width * 0.6568078,
        size.height * 0.1485069,
        size.width * 0.6536577,
        size.height * 0.1617319);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.3081029, size.height * 0.3864297);
    path_5.arcToPoint(Offset(size.width * 0.3088904, size.height * 0.4243356),
        radius:
            Radius.elliptical(size.width * 0.3838379, size.height * 0.3694984),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.3132657, size.height * 0.4586615),
        radius:
            Radius.elliptical(size.width * 0.1987224, size.height * 0.1912985),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.3362356, size.height * 0.4813629),
        radius: Radius.elliptical(
            size.width * 0.03023276, size.height * 0.02910331),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.3743875, size.height * 0.4836794),
        radius:
            Radius.elliptical(size.width * 0.2180609, size.height * 0.2099145),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.3811253,
        size.height * 0.4836794,
        size.width * 0.3879069,
        size.height * 0.4836794,
        size.width * 0.3946447,
        size.height * 0.4836794);
    path_5.cubicTo(
        size.width * 0.4013826,
        size.height * 0.4836794,
        size.width * 0.4077704,
        size.height * 0.4833003,
        size.width * 0.4128456,
        size.height * 0.4783305);
    path_5.arcToPoint(Offset(size.width * 0.4183147, size.height * 0.4626627),
        radius: Radius.elliptical(
            size.width * 0.02625131, size.height * 0.02527061),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4189272,
        size.height * 0.4562608,
        size.width * 0.4193647,
        size.height * 0.4500274,
        size.width * 0.4196710,
        size.height * 0.4434149);
    path_5.quadraticBezierTo(size.width * 0.4205898, size.height * 0.4240829,
        size.width * 0.4196710, size.height * 0.4047930);
    path_5.cubicTo(
        size.width * 0.4191022,
        size.height * 0.3928737,
        size.width * 0.4202835,
        size.height * 0.3771217,
        size.width * 0.4052765,
        size.height * 0.3734574);
    path_5.arcToPoint(Offset(size.width * 0.3834004, size.height * 0.3708461),
        radius:
            Radius.elliptical(size.width * 0.1316066, size.height * 0.1266900),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.3762251,
        size.height * 0.3702986,
        size.width * 0.3690497,
        size.height * 0.3700459,
        size.width * 0.3618743,
        size.height * 0.3701301);
    path_5.arcToPoint(Offset(size.width * 0.3161533, size.height * 0.3748473),
        radius:
            Radius.elliptical(size.width * 0.2585754, size.height * 0.2489155),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.3219723, size.height * 0.3951480),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.3850193, size.height * 0.3920735),
        radius:
            Radius.elliptical(size.width * 0.2300053, size.height * 0.2214126),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.arcToPoint(Offset(size.width * 0.3987574, size.height * 0.3936739),
        radius:
            Radius.elliptical(size.width * 0.1322191, size.height * 0.1272796),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.4005075,
        size.height * 0.3940109,
        size.width * 0.4019076,
        size.height * 0.3951059,
        size.width * 0.3987574,
        size.height * 0.3926210);
    path_5.cubicTo(
        size.width * 0.3956073,
        size.height * 0.3901360,
        size.width * 0.3972699,
        size.height * 0.3906415,
        size.width * 0.3969198,
        size.height * 0.3916944);
    path_5.arcToPoint(Offset(size.width * 0.3975324, size.height * 0.4004549),
        radius: Radius.elliptical(
            size.width * 0.03430172, size.height * 0.03302026),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.quadraticBezierTo(size.width * 0.3984512, size.height * 0.4162490,
        size.width * 0.3981887, size.height * 0.4320431);
    path_5.cubicTo(
        size.width * 0.3981887,
        size.height * 0.4422777,
        size.width * 0.3972699,
        size.height * 0.4524702,
        size.width * 0.3964386,
        size.height * 0.4627048);
    path_5.lineTo(size.width * 0.3964386, size.height * 0.4644316);
    path_5.cubicTo(
        size.width * 0.3964386,
        size.height * 0.4637577,
        size.width * 0.3964386,
        size.height * 0.4637999,
        size.width * 0.3964386,
        size.height * 0.4644316);
    path_5.cubicTo(
        size.width * 0.3964386,
        size.height * 0.4650634,
        size.width * 0.3954760,
        size.height * 0.4653161,
        size.width * 0.3979261,
        size.height * 0.4635050);
    path_5.cubicTo(
        size.width * 0.4003763,
        size.height * 0.4616940,
        size.width * 0.3997637,
        size.height * 0.4626627,
        size.width * 0.3991950,
        size.height * 0.4624100);
    path_5.arcToPoint(Offset(size.width * 0.3948197, size.height * 0.4624100),
        radius: Radius.elliptical(
            size.width * 0.01610081, size.height * 0.01549931),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.3893070,
        size.height * 0.4624100,
        size.width * 0.3837504,
        size.height * 0.4624100,
        size.width * 0.3782377,
        size.height * 0.4624100);
    path_5.cubicTo(
        size.width * 0.3671684,
        size.height * 0.4624100,
        size.width * 0.3560991,
        size.height * 0.4619046,
        size.width * 0.3451173,
        size.height * 0.4610622);
    path_5.arcToPoint(Offset(size.width * 0.3378544, size.height * 0.4593775),
        radius: Radius.elliptical(
            size.width * 0.01583829, size.height * 0.01524660),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.arcToPoint(Offset(size.width * 0.3343980, size.height * 0.4522175),
        radius: Radius.elliptical(
            size.width * 0.01251313, size.height * 0.01204566),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.arcToPoint(Offset(size.width * 0.3306790, size.height * 0.4215137),
        radius:
            Radius.elliptical(size.width * 0.1818341, size.height * 0.1750411),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.3298915,
        size.height * 0.4097208,
        size.width * 0.3297165,
        size.height * 0.3978857,
        size.width * 0.3300665,
        size.height * 0.3860506);
    path_5.cubicTo(
        size.width * 0.3305040,
        size.height * 0.3724887,
        size.width * 0.3086279,
        size.height * 0.3725309,
        size.width * 0.3081904,
        size.height * 0.3860506);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4352905, size.height * 0.3864297);
    path_6.cubicTo(
        size.width * 0.4348967,
        size.height * 0.3990650,
        size.width * 0.4352905,
        size.height * 0.4117003,
        size.width * 0.4360781,
        size.height * 0.4243356);
    path_6.arcToPoint(Offset(size.width * 0.4404533, size.height * 0.4586615),
        radius:
            Radius.elliptical(size.width * 0.1987662, size.height * 0.1913406),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.4634232, size.height * 0.4813629),
        radius: Radius.elliptical(
            size.width * 0.03010151, size.height * 0.02897696),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.5015313, size.height * 0.4836794),
        radius:
            Radius.elliptical(size.width * 0.2173171, size.height * 0.2091985),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.cubicTo(
        size.width * 0.5083129,
        size.height * 0.4836794,
        size.width * 0.5150508,
        size.height * 0.4836794,
        size.width * 0.5217886,
        size.height * 0.4836794);
    path_6.cubicTo(
        size.width * 0.5285264,
        size.height * 0.4836794,
        size.width * 0.5349142,
        size.height * 0.4833003,
        size.width * 0.5399895,
        size.height * 0.4783305);
    path_6.arcToPoint(Offset(size.width * 0.5454585, size.height * 0.4626627),
        radius: Radius.elliptical(
            size.width * 0.02559503, size.height * 0.02463884),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.cubicTo(
        size.width * 0.5460711,
        size.height * 0.4562608,
        size.width * 0.5465523,
        size.height * 0.4500274,
        size.width * 0.5468148,
        size.height * 0.4434149);
    path_6.quadraticBezierTo(size.width * 0.5477336, size.height * 0.4240829,
        size.width * 0.5468148, size.height * 0.4047930);
    path_6.cubicTo(
        size.width * 0.5462023,
        size.height * 0.3928737,
        size.width * 0.5473836,
        size.height * 0.3771217,
        size.width * 0.5324204,
        size.height * 0.3734574);
    path_6.arcToPoint(Offset(size.width * 0.5105443, size.height * 0.3708461),
        radius:
            Radius.elliptical(size.width * 0.1327004, size.height * 0.1277429),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.cubicTo(
        size.width * 0.5034127,
        size.height * 0.3702986,
        size.width * 0.4962373,
        size.height * 0.3700459,
        size.width * 0.4890620,
        size.height * 0.3701301);
    path_6.arcToPoint(Offset(size.width * 0.4433409, size.height * 0.3748473),
        radius:
            Radius.elliptical(size.width * 0.2586629, size.height * 0.2489997),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.4491600, size.height * 0.3951480),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.5123381, size.height * 0.3920735),
        radius:
            Radius.elliptical(size.width * 0.2300053, size.height * 0.2214126),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_6.arcToPoint(Offset(size.width * 0.5260763, size.height * 0.3936739),
        radius:
            Radius.elliptical(size.width * 0.1308190, size.height * 0.1259319),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_6.cubicTo(
        size.width * 0.5278264,
        size.height * 0.3940109,
        size.width * 0.5292265,
        size.height * 0.3951059,
        size.width * 0.5260763,
        size.height * 0.3926210);
    path_6.cubicTo(
        size.width * 0.5229261,
        size.height * 0.3901360,
        size.width * 0.5245887,
        size.height * 0.3906415,
        size.width * 0.5241950,
        size.height * 0.3916944);
    path_6.arcToPoint(Offset(size.width * 0.5248075, size.height * 0.4004549),
        radius: Radius.elliptical(
            size.width * 0.03430172, size.height * 0.03302026),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.quadraticBezierTo(size.width * 0.5257700, size.height * 0.4162490,
        size.width * 0.5254638, size.height * 0.4320431);
    path_6.cubicTo(
        size.width * 0.5254638,
        size.height * 0.4422777,
        size.width * 0.5245887,
        size.height * 0.4524702,
        size.width * 0.5237137,
        size.height * 0.4627048);
    path_6.lineTo(size.width * 0.5237137, size.height * 0.4644316);
    path_6.cubicTo(
        size.width * 0.5237137,
        size.height * 0.4637577,
        size.width * 0.5237137,
        size.height * 0.4637999,
        size.width * 0.5237137,
        size.height * 0.4644316);
    path_6.cubicTo(
        size.width * 0.5237137,
        size.height * 0.4650634,
        size.width * 0.5227511,
        size.height * 0.4653161,
        size.width * 0.5252450,
        size.height * 0.4635050);
    path_6.cubicTo(
        size.width * 0.5277389,
        size.height * 0.4616940,
        size.width * 0.5270389,
        size.height * 0.4626627,
        size.width * 0.5264701,
        size.height * 0.4624100);
    path_6.arcToPoint(Offset(size.width * 0.5220949, size.height * 0.4624100),
        radius: Radius.elliptical(
            size.width * 0.01610081, size.height * 0.01549931),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.cubicTo(
        size.width * 0.5165821,
        size.height * 0.4624100,
        size.width * 0.5110693,
        size.height * 0.4624100,
        size.width * 0.5055128,
        size.height * 0.4624100);
    path_6.cubicTo(
        size.width * 0.4944872,
        size.height * 0.4624100,
        size.width * 0.4836367,
        size.height * 0.4619046,
        size.width * 0.4723924,
        size.height * 0.4610622);
    path_6.arcToPoint(Offset(size.width * 0.4651733, size.height * 0.4593775),
        radius: Radius.elliptical(
            size.width * 0.01566328, size.height * 0.01507813),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_6.arcToPoint(Offset(size.width * 0.4616731, size.height * 0.4522175),
        radius: Radius.elliptical(
            size.width * 0.01251313, size.height * 0.01204566),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_6.arcToPoint(Offset(size.width * 0.4579541, size.height * 0.4215137),
        radius:
            Radius.elliptical(size.width * 0.1905408, size.height * 0.1834225),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_6.cubicTo(
        size.width * 0.4571666,
        size.height * 0.4097208,
        size.width * 0.4569916,
        size.height * 0.3978857,
        size.width * 0.4573416,
        size.height * 0.3860506);
    path_6.cubicTo(
        size.width * 0.4577791,
        size.height * 0.3724887,
        size.width * 0.4359030,
        size.height * 0.3725309,
        size.width * 0.4354655,
        size.height * 0.3860506);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.3081029, size.height * 0.5102557);
    path_7.arcToPoint(Offset(size.width * 0.3088904, size.height * 0.5481616),
        radius:
            Radius.elliptical(size.width * 0.3841005, size.height * 0.3697511),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.3132657, size.height * 0.5824875),
        radius:
            Radius.elliptical(size.width * 0.1987224, size.height * 0.1912985),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.3362356, size.height * 0.6051468),
        radius: Radius.elliptical(
            size.width * 0.03014526, size.height * 0.02901908),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.3743875, size.height * 0.6075054),
        radius:
            Radius.elliptical(size.width * 0.2181047, size.height * 0.2099566),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.3811253,
        size.height * 0.6075054,
        size.width * 0.3879069,
        size.height * 0.6075054,
        size.width * 0.3946447,
        size.height * 0.6075054);
    path_7.cubicTo(
        size.width * 0.4013826,
        size.height * 0.6075054,
        size.width * 0.4077704,
        size.height * 0.6071263,
        size.width * 0.4128456,
        size.height * 0.6021564);
    path_7.arcToPoint(Offset(size.width * 0.4183147, size.height * 0.5864886),
        radius: Radius.elliptical(
            size.width * 0.02625131, size.height * 0.02527061),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.4189272,
        size.height * 0.5800446,
        size.width * 0.4193647,
        size.height * 0.5738533,
        size.width * 0.4196710,
        size.height * 0.5671988);
    path_7.cubicTo(
        size.width * 0.4202835,
        size.height * 0.5543529,
        size.width * 0.4202835,
        size.height * 0.5414649,
        size.width * 0.4196710,
        size.height * 0.5286190);
    path_7.cubicTo(
        size.width * 0.4191022,
        size.height * 0.5166997,
        size.width * 0.4202835,
        size.height * 0.5009055,
        size.width * 0.4052765,
        size.height * 0.4972413);
    path_7.arcToPoint(Offset(size.width * 0.3834004, size.height * 0.4946721),
        radius:
            Radius.elliptical(size.width * 0.1315628, size.height * 0.1266479),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.3762251,
        size.height * 0.4941246,
        size.width * 0.3690497,
        size.height * 0.4938719,
        size.width * 0.3618743,
        size.height * 0.4939561);
    path_7.arcToPoint(Offset(size.width * 0.3161971, size.height * 0.4986312),
        radius:
            Radius.elliptical(size.width * 0.2545502, size.height * 0.2450406),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.3085404, size.height * 0.5115613),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.3220161, size.height * 0.5189319),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.3850193, size.height * 0.5158994),
        radius:
            Radius.elliptical(size.width * 0.2282989, size.height * 0.2197700),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.arcToPoint(Offset(size.width * 0.3987574, size.height * 0.5174999),
        radius:
            Radius.elliptical(size.width * 0.1322191, size.height * 0.1272796),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.cubicTo(
        size.width * 0.4005075,
        size.height * 0.5178368,
        size.width * 0.4019076,
        size.height * 0.5189319,
        size.width * 0.3987574,
        size.height * 0.5164048);
    path_7.cubicTo(
        size.width * 0.3956073,
        size.height * 0.5138778,
        size.width * 0.3972699,
        size.height * 0.5144674,
        size.width * 0.3969198,
        size.height * 0.5155204);
    path_7.arcToPoint(Offset(size.width * 0.3975324, size.height * 0.5242808),
        radius: Radius.elliptical(
            size.width * 0.03430172, size.height * 0.03302026),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.quadraticBezierTo(size.width * 0.3984512, size.height * 0.5399907,
        size.width * 0.3981887, size.height * 0.5558270);
    path_7.cubicTo(
        size.width * 0.3981887,
        size.height * 0.5661037,
        size.width * 0.3972699,
        size.height * 0.5762962,
        size.width * 0.3964386,
        size.height * 0.5865308);
    path_7.lineTo(size.width * 0.3964386, size.height * 0.5882576);
    path_7.cubicTo(
        size.width * 0.3964386,
        size.height * 0.5875837,
        size.width * 0.3964386,
        size.height * 0.5876258,
        size.width * 0.3964386,
        size.height * 0.5882576);
    path_7.cubicTo(
        size.width * 0.3964386,
        size.height * 0.5888894,
        size.width * 0.3954760,
        size.height * 0.5891842,
        size.width * 0.3979261,
        size.height * 0.5873310);
    path_7.cubicTo(
        size.width * 0.4003763,
        size.height * 0.5854778,
        size.width * 0.3997637,
        size.height * 0.5865308,
        size.width * 0.3991950,
        size.height * 0.5862781);
    path_7.arcToPoint(Offset(size.width * 0.3948197, size.height * 0.5862781),
        radius: Radius.elliptical(
            size.width * 0.01312566, size.height * 0.01263530),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.3893070,
        size.height * 0.5862781,
        size.width * 0.3837504,
        size.height * 0.5862781,
        size.width * 0.3782377,
        size.height * 0.5862781);
    path_7.cubicTo(
        size.width * 0.3671684,
        size.height * 0.5862781,
        size.width * 0.3560991,
        size.height * 0.5857726,
        size.width * 0.3451173,
        size.height * 0.5848882);
    path_7.arcToPoint(Offset(size.width * 0.3378544, size.height * 0.5832456),
        radius: Radius.elliptical(
            size.width * 0.01588204, size.height * 0.01528872),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.arcToPoint(Offset(size.width * 0.3343980, size.height * 0.5760435),
        radius: Radius.elliptical(
            size.width * 0.01260063, size.height * 0.01212989),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.arcToPoint(Offset(size.width * 0.3306790, size.height * 0.5453818),
        radius:
            Radius.elliptical(size.width * 0.1808715, size.height * 0.1741145),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.cubicTo(
        size.width * 0.3298915,
        size.height * 0.5335467,
        size.width * 0.3297165,
        size.height * 0.5217538,
        size.width * 0.3300665,
        size.height * 0.5099187);
    path_7.cubicTo(
        size.width * 0.3305040,
        size.height * 0.4963568,
        size.width * 0.3086279,
        size.height * 0.4963568,
        size.width * 0.3081904,
        size.height * 0.5099187);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.4352905, size.height * 0.5102557);
    path_8.quadraticBezierTo(size.width * 0.4347217, size.height * 0.5292507,
        size.width * 0.4360781, size.height * 0.5481616);
    path_8.arcToPoint(Offset(size.width * 0.4404533, size.height * 0.5824875),
        radius:
            Radius.elliptical(size.width * 0.1987662, size.height * 0.1913406),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.4634232, size.height * 0.6051468),
        radius: Radius.elliptical(
            size.width * 0.03001400, size.height * 0.02889273),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.5015313, size.height * 0.6075054),
        radius:
            Radius.elliptical(size.width * 0.2173609, size.height * 0.2092406),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.cubicTo(
        size.width * 0.5083129,
        size.height * 0.6075054,
        size.width * 0.5150508,
        size.height * 0.6075054,
        size.width * 0.5217886,
        size.height * 0.6075054);
    path_8.cubicTo(
        size.width * 0.5285264,
        size.height * 0.6075054,
        size.width * 0.5349142,
        size.height * 0.6071263,
        size.width * 0.5399895,
        size.height * 0.6021564);
    path_8.arcToPoint(Offset(size.width * 0.5454585, size.height * 0.5864886),
        radius: Radius.elliptical(
            size.width * 0.02559503, size.height * 0.02463884),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.cubicTo(
        size.width * 0.5460711,
        size.height * 0.5800446,
        size.width * 0.5465523,
        size.height * 0.5738533,
        size.width * 0.5468148,
        size.height * 0.5671988);
    path_8.cubicTo(
        size.width * 0.5474274,
        size.height * 0.5543529,
        size.width * 0.5474274,
        size.height * 0.5414649,
        size.width * 0.5468148,
        size.height * 0.5286190);
    path_8.cubicTo(
        size.width * 0.5462023,
        size.height * 0.5166997,
        size.width * 0.5473836,
        size.height * 0.5009055,
        size.width * 0.5324204,
        size.height * 0.4972413);
    path_8.arcToPoint(Offset(size.width * 0.5105443, size.height * 0.4946721),
        radius:
            Radius.elliptical(size.width * 0.1326566, size.height * 0.1277008),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.cubicTo(
        size.width * 0.5034127,
        size.height * 0.4941246,
        size.width * 0.4962373,
        size.height * 0.4938719,
        size.width * 0.4890620,
        size.height * 0.4939561);
    path_8.arcToPoint(Offset(size.width * 0.4433409, size.height * 0.4986312),
        radius:
            Radius.elliptical(size.width * 0.2545940, size.height * 0.2450828),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.4357280, size.height * 0.5115613),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.4491600, size.height * 0.5189319),
        radius: Radius.elliptical(
            size.width * 0.01111306, size.height * 0.01069789),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.5123381, size.height * 0.5158573),
        radius:
            Radius.elliptical(size.width * 0.2282989, size.height * 0.2197700),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_8.arcToPoint(Offset(size.width * 0.5260763, size.height * 0.5174578),
        radius:
            Radius.elliptical(size.width * 0.1308190, size.height * 0.1259319),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_8.cubicTo(
        size.width * 0.5278264,
        size.height * 0.5177947,
        size.width * 0.5292265,
        size.height * 0.5188898,
        size.width * 0.5260763,
        size.height * 0.5163627);
    path_8.cubicTo(
        size.width * 0.5229261,
        size.height * 0.5138357,
        size.width * 0.5245887,
        size.height * 0.5144253,
        size.width * 0.5241950,
        size.height * 0.5154782);
    path_8.arcToPoint(Offset(size.width * 0.5248075, size.height * 0.5242387),
        radius: Radius.elliptical(
            size.width * 0.03430172, size.height * 0.03302026),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.quadraticBezierTo(size.width * 0.5257700, size.height * 0.5399486,
        size.width * 0.5254638, size.height * 0.5557849);
    path_8.cubicTo(
        size.width * 0.5254638,
        size.height * 0.5660616,
        size.width * 0.5245887,
        size.height * 0.5762541,
        size.width * 0.5237137,
        size.height * 0.5864886);
    path_8.lineTo(size.width * 0.5237137, size.height * 0.5882155);
    path_8.cubicTo(
        size.width * 0.5237137,
        size.height * 0.5875416,
        size.width * 0.5237137,
        size.height * 0.5875837,
        size.width * 0.5237137,
        size.height * 0.5882155);
    path_8.cubicTo(
        size.width * 0.5237137,
        size.height * 0.5888472,
        size.width * 0.5227511,
        size.height * 0.5891421,
        size.width * 0.5252450,
        size.height * 0.5872889);
    path_8.cubicTo(
        size.width * 0.5277389,
        size.height * 0.5854357,
        size.width * 0.5270389,
        size.height * 0.5864886,
        size.width * 0.5264701,
        size.height * 0.5862359);
    path_8.arcToPoint(Offset(size.width * 0.5220949, size.height * 0.5862359),
        radius: Radius.elliptical(
            size.width * 0.01312566, size.height * 0.01263530),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.cubicTo(
        size.width * 0.5165821,
        size.height * 0.5862359,
        size.width * 0.5110693,
        size.height * 0.5862359,
        size.width * 0.5055128,
        size.height * 0.5862359);
    path_8.cubicTo(
        size.width * 0.4944872,
        size.height * 0.5862359,
        size.width * 0.4836367,
        size.height * 0.5857305,
        size.width * 0.4723924,
        size.height * 0.5848461);
    path_8.arcToPoint(Offset(size.width * 0.4651733, size.height * 0.5832035),
        radius: Radius.elliptical(
            size.width * 0.01566328, size.height * 0.01507813),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_8.arcToPoint(Offset(size.width * 0.4616731, size.height * 0.5760013),
        radius: Radius.elliptical(
            size.width * 0.01264438, size.height * 0.01217201),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_8.arcToPoint(Offset(size.width * 0.4579541, size.height * 0.5453397),
        radius:
            Radius.elliptical(size.width * 0.1894907, size.height * 0.1824117),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_8.cubicTo(
        size.width * 0.4571666,
        size.height * 0.5335046,
        size.width * 0.4569916,
        size.height * 0.5217117,
        size.width * 0.4573416,
        size.height * 0.5098766);
    path_8.cubicTo(
        size.width * 0.4577791,
        size.height * 0.4963147,
        size.width * 0.4359030,
        size.height * 0.4963147,
        size.width * 0.4354655,
        size.height * 0.5098766);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.5681659, size.height * 0.3864297);
    path_9.arcToPoint(Offset(size.width * 0.5689534, size.height * 0.4243356),
        radius:
            Radius.elliptical(size.width * 0.3838379, size.height * 0.3694984),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.arcToPoint(Offset(size.width * 0.5733287, size.height * 0.4586615),
        radius:
            Radius.elliptical(size.width * 0.1987224, size.height * 0.1912985),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.arcToPoint(Offset(size.width * 0.5962986, size.height * 0.4813629),
        radius: Radius.elliptical(
            size.width * 0.03018901, size.height * 0.02906120),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.arcToPoint(Offset(size.width * 0.6344505, size.height * 0.4836794),
        radius:
            Radius.elliptical(size.width * 0.2180609, size.height * 0.2099145),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.cubicTo(
        size.width * 0.6411883,
        size.height * 0.4836794,
        size.width * 0.6479699,
        size.height * 0.4836794,
        size.width * 0.6547077,
        size.height * 0.4836794);
    path_9.cubicTo(
        size.width * 0.6614456,
        size.height * 0.4836794,
        size.width * 0.6680522,
        size.height * 0.4833003,
        size.width * 0.6729086,
        size.height * 0.4783305);
    path_9.arcToPoint(Offset(size.width * 0.6783777, size.height * 0.4626627),
        radius: Radius.elliptical(
            size.width * 0.02625131, size.height * 0.02527061),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.cubicTo(
        size.width * 0.6789902,
        size.height * 0.4562608,
        size.width * 0.6794277,
        size.height * 0.4500274,
        size.width * 0.6797340,
        size.height * 0.4434149);
    path_9.quadraticBezierTo(size.width * 0.6806528, size.height * 0.4240829,
        size.width * 0.6797340, size.height * 0.4047930);
    path_9.cubicTo(
        size.width * 0.6791652,
        size.height * 0.3928737,
        size.width * 0.6803465,
        size.height * 0.3771217,
        size.width * 0.6653395,
        size.height * 0.3734574);
    path_9.arcToPoint(Offset(size.width * 0.6434634, size.height * 0.3708461),
        radius:
            Radius.elliptical(size.width * 0.1316066, size.height * 0.1266900),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.cubicTo(
        size.width * 0.6362881,
        size.height * 0.3702986,
        size.width * 0.6291127,
        size.height * 0.3700459,
        size.width * 0.6219373,
        size.height * 0.3701301);
    path_9.arcToPoint(Offset(size.width * 0.5762163, size.height * 0.3748473),
        radius:
            Radius.elliptical(size.width * 0.2585754, size.height * 0.2489155),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.arcToPoint(Offset(size.width * 0.5819041, size.height * 0.3951480),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_9.arcToPoint(Offset(size.width * 0.6450823, size.height * 0.3920735),
        radius:
            Radius.elliptical(size.width * 0.2299177, size.height * 0.2213284),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.arcToPoint(Offset(size.width * 0.6588204, size.height * 0.3936739),
        radius:
            Radius.elliptical(size.width * 0.1322191, size.height * 0.1272796),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.cubicTo(
        size.width * 0.6605705,
        size.height * 0.3940109,
        size.width * 0.6619706,
        size.height * 0.3951059,
        size.width * 0.6588204,
        size.height * 0.3926210);
    path_9.cubicTo(
        size.width * 0.6556703,
        size.height * 0.3901360,
        size.width * 0.6573329,
        size.height * 0.3906415,
        size.width * 0.6569828,
        size.height * 0.3916944);
    path_9.arcToPoint(Offset(size.width * 0.6575954, size.height * 0.4004549),
        radius: Radius.elliptical(
            size.width * 0.03255163, size.height * 0.03133555),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.quadraticBezierTo(size.width * 0.6585142, size.height * 0.4162490,
        size.width * 0.6582517, size.height * 0.4320431);
    path_9.cubicTo(
        size.width * 0.6580329,
        size.height * 0.4422777,
        size.width * 0.6573329,
        size.height * 0.4524702,
        size.width * 0.6565016,
        size.height * 0.4627048);
    path_9.lineTo(size.width * 0.6565016, size.height * 0.4644316);
    path_9.cubicTo(
        size.width * 0.6565016,
        size.height * 0.4637577,
        size.width * 0.6565016,
        size.height * 0.4637999,
        size.width * 0.6565016,
        size.height * 0.4644316);
    path_9.cubicTo(
        size.width * 0.6565016,
        size.height * 0.4650634,
        size.width * 0.6555390,
        size.height * 0.4653161,
        size.width * 0.6579891,
        size.height * 0.4635050);
    path_9.cubicTo(
        size.width * 0.6604393,
        size.height * 0.4616940,
        size.width * 0.6598267,
        size.height * 0.4626627,
        size.width * 0.6592580,
        size.height * 0.4624100);
    path_9.arcToPoint(Offset(size.width * 0.6548827, size.height * 0.4624100),
        radius: Radius.elliptical(
            size.width * 0.01610081, size.height * 0.01549931),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.cubicTo(
        size.width * 0.6493700,
        size.height * 0.4624100,
        size.width * 0.6438134,
        size.height * 0.4624100,
        size.width * 0.6383007,
        size.height * 0.4624100);
    path_9.cubicTo(
        size.width * 0.6272314,
        size.height * 0.4624100,
        size.width * 0.6161621,
        size.height * 0.4619046,
        size.width * 0.6051803,
        size.height * 0.4610622);
    path_9.arcToPoint(Offset(size.width * 0.5979174, size.height * 0.4593775),
        radius: Radius.elliptical(
            size.width * 0.01583829, size.height * 0.01524660),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.arcToPoint(Offset(size.width * 0.5944610, size.height * 0.4522175),
        radius: Radius.elliptical(
            size.width * 0.01251313, size.height * 0.01204566),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.arcToPoint(Offset(size.width * 0.5907420, size.height * 0.4215137),
        radius:
            Radius.elliptical(size.width * 0.1818341, size.height * 0.1750411),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.cubicTo(
        size.width * 0.5899545,
        size.height * 0.4097208,
        size.width * 0.5897795,
        size.height * 0.3978857,
        size.width * 0.5901295,
        size.height * 0.3860506);
    path_9.cubicTo(
        size.width * 0.5905670,
        size.height * 0.3724887,
        size.width * 0.5686909,
        size.height * 0.3725309,
        size.width * 0.5682534,
        size.height * 0.3860506);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.7795327, size.height * 0.4885651);
    path_10.arcToPoint(Offset(size.width * 0.6838904, size.height * 0.5066335),
        radius:
            Radius.elliptical(size.width * 0.1361131, size.height * 0.1310281),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.arcToPoint(Offset(size.width * 0.6208435, size.height * 0.5728004),
        radius:
            Radius.elliptical(size.width * 0.1817028, size.height * 0.1749147),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.cubicTo(
        size.width * 0.6046552,
        size.height * 0.6017352,
        size.width * 0.5938922,
        size.height * 0.6355979,
        size.width * 0.5980487,
        size.height * 0.6687024);
    path_10.arcToPoint(Offset(size.width * 0.6366818, size.height * 0.7441772),
        radius:
            Radius.elliptical(size.width * 0.1344505, size.height * 0.1294276),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.cubicTo(
        size.width * 0.6836279,
        size.height * 0.7897907,
        size.width * 0.7580067,
        size.height * 0.7973719,
        size.width * 0.8182097,
        size.height * 0.7736596);
    path_10.arcToPoint(Offset(size.width * 0.8609118, size.height * 0.7483890),
        radius:
            Radius.elliptical(size.width * 0.1337067, size.height * 0.1287116),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.arcToPoint(Offset(size.width * 0.8879506, size.height * 0.7110727),
        radius:
            Radius.elliptical(size.width * 0.1265751, size.height * 0.1218464),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.arcToPoint(Offset(size.width * 0.9054515, size.height * 0.6175294),
        radius:
            Radius.elliptical(size.width * 0.1965348, size.height * 0.1891926),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.arcToPoint(Offset(size.width * 0.8708873, size.height * 0.5317357),
        radius:
            Radius.elliptical(size.width * 0.1601330, size.height * 0.1541507),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.arcToPoint(Offset(size.width * 0.7970774, size.height * 0.4870067),
        radius:
            Radius.elliptical(size.width * 0.1353693, size.height * 0.1303121),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.arcToPoint(Offset(size.width * 0.7748950, size.height * 0.4842690),
        radius:
            Radius.elliptical(size.width * 0.1261376, size.height * 0.1214253),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.cubicTo(
        size.width * 0.7608068,
        size.height * 0.4837215,
        size.width * 0.7608068,
        size.height * 0.5047804,
        size.width * 0.7748950,
        size.height * 0.5053279);
    path_10.cubicTo(
        size.width * 0.8290165,
        size.height * 0.5074759,
        size.width * 0.8700560,
        size.height * 0.5511519,
        size.width * 0.8809065,
        size.height * 0.5999242);
    path_10.arcToPoint(Offset(size.width * 0.8759188, size.height * 0.6830645),
        radius:
            Radius.elliptical(size.width * 0.1727336, size.height * 0.1662806),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_10.cubicTo(
        size.width * 0.8677809,
        size.height * 0.7083351,
        size.width * 0.8530802,
        size.height * 0.7316683,
        size.width * 0.8288852,
        size.height * 0.7456092);
    path_10.cubicTo(
        size.width * 0.7803203,
        size.height * 0.7735754,
        size.width * 0.7121106,
        size.height * 0.7740808,
        size.width * 0.6660396,
        size.height * 0.7411026);
    path_10.arcToPoint(Offset(size.width * 0.6240375, size.height * 0.6855073),
        radius:
            Radius.elliptical(size.width * 0.1181309, size.height * 0.1137177),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_10.cubicTo(
        size.width * 0.6150245,
        size.height * 0.6580466,
        size.width * 0.6196622,
        size.height * 0.6291539,
        size.width * 0.6304690,
        size.height * 0.6027882);
    path_10.cubicTo(
        size.width * 0.6527389,
        size.height * 0.5480352,
        size.width * 0.7085229,
        size.height * 0.4974940,
        size.width * 0.7738449,
        size.height * 0.5088237);
    path_10.arcToPoint(Offset(size.width * 0.7873206, size.height * 0.5014952),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.arcToPoint(Offset(size.width * 0.7796640, size.height * 0.4885229),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.7031414, size.height * 0.5596176);
    path_11.arcToPoint(Offset(size.width * 0.6981099, size.height * 0.5822348),
        radius: Radius.elliptical(
            size.width * 0.04502100, size.height * 0.04333909),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.cubicTo(
        size.width * 0.6981099,
        size.height * 0.5911637,
        size.width * 0.6981099,
        size.height * 0.6000927,
        size.width * 0.6981099,
        size.height * 0.6089795);
    path_11.lineTo(size.width * 0.6981099, size.height * 0.6367772);
    path_11.cubicTo(
        size.width * 0.6981099,
        size.height * 0.6449480,
        size.width * 0.6975849,
        size.height * 0.6533715,
        size.width * 0.7010413,
        size.height * 0.6610369);
    path_11.cubicTo(
        size.width * 0.7074291,
        size.height * 0.6749779,
        size.width * 0.7236174,
        size.height * 0.6785579,
        size.width * 0.7378369,
        size.height * 0.6802005);
    path_11.arcToPoint(Offset(size.width * 0.7943647, size.height * 0.6819273),
        radius:
            Radius.elliptical(size.width * 0.3298040, size.height * 0.3174830),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.cubicTo(
        size.width * 0.8091967,
        size.height * 0.6811271,
        size.width * 0.8305040,
        size.height * 0.6819273,
        size.width * 0.8399545,
        size.height * 0.6684918);
    path_11.cubicTo(
        size.width * 0.8494050,
        size.height * 0.6550562,
        size.width * 0.8452923,
        size.height * 0.6329444,
        size.width * 0.8308103,
        size.height * 0.6249842);
    path_11.cubicTo(
        size.width * 0.8163283,
        size.height * 0.6170240,
        size.width * 0.7994837,
        size.height * 0.6228783,
        size.width * 0.7844330,
        size.height * 0.6234680);
    path_11.cubicTo(
        size.width * 0.7800578,
        size.height * 0.6234680,
        size.width * 0.7753763,
        size.height * 0.6234680,
        size.width * 0.7708698,
        size.height * 0.6234680);
    path_11.cubicTo(
        size.width * 0.7687697,
        size.height * 0.6234680,
        size.width * 0.7664946,
        size.height * 0.6234680,
        size.width * 0.7645695,
        size.height * 0.6231310);
    path_11.cubicTo(
        size.width * 0.7641320,
        size.height * 0.6231310,
        size.width * 0.7589692,
        size.height * 0.6226256,
        size.width * 0.7619881,
        size.height * 0.6233416);
    path_11.cubicTo(
        size.width * 0.7641757,
        size.height * 0.6238891,
        size.width * 0.7623819,
        size.height * 0.6243946,
        size.width * 0.7622944,
        size.height * 0.6229204);
    path_11.arcToPoint(Offset(size.width * 0.7617693, size.height * 0.6209409),
        radius: Radius.elliptical(
            size.width * 0.01570704, size.height * 0.01512025),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.arcToPoint(Offset(size.width * 0.7608943, size.height * 0.6161816),
        radius: Radius.elliptical(
            size.width * 0.03163283, size.height * 0.03045108),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_11.arcToPoint(Offset(size.width * 0.7611131, size.height * 0.6026197),
        radius: Radius.elliptical(
            size.width * 0.08409170, size.height * 0.08095017),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_11.cubicTo(
        size.width * 0.7623381,
        size.height * 0.5851409,
        size.width * 0.7636069,
        size.height * 0.5649665,
        size.width * 0.7479874,
        size.height * 0.5524576);
    path_11.arcToPoint(Offset(size.width * 0.7214298, size.height * 0.5452976),
        radius: Radius.elliptical(
            size.width * 0.03062653, size.height * 0.02948237),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.arcToPoint(Offset(size.width * 0.7005600, size.height * 0.5602493),
        radius: Radius.elliptical(
            size.width * 0.03898320, size.height * 0.03752685),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.arcToPoint(Offset(size.width * 0.7005600, size.height * 0.5751590),
        radius: Radius.elliptical(
            size.width * 0.01128806, size.height * 0.01086636),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.arcToPoint(Offset(size.width * 0.7160046, size.height * 0.5751590),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.cubicTo(
        size.width * 0.7186297,
        size.height * 0.5719581,
        size.width * 0.7224361,
        size.height * 0.5659773,
        size.width * 0.7272489,
        size.height * 0.5655983);
    path_11.arcToPoint(Offset(size.width * 0.7359993, size.height * 0.5709472),
        radius: Radius.elliptical(
            size.width * 0.01176934, size.height * 0.01132966),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_11.cubicTo(
        size.width * 0.7434809,
        size.height * 0.5809712,
        size.width * 0.7388869,
        size.height * 0.5971444,
        size.width * 0.7385369,
        size.height * 0.6084320);
    path_11.cubicTo(
        size.width * 0.7381432,
        size.height * 0.6213200,
        size.width * 0.7401120,
        size.height * 0.6390936,
        size.width * 0.7555565,
        size.height * 0.6430527);
    path_11.arcToPoint(Offset(size.width * 0.7767763, size.height * 0.6446953),
        radius: Radius.elliptical(
            size.width * 0.08623556, size.height * 0.08301394),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.arcToPoint(Offset(size.width * 0.7997025, size.height * 0.6432212),
        radius:
            Radius.elliptical(size.width * 0.1750088, size.height * 0.1684707),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.arcToPoint(Offset(size.width * 0.8157158, size.height * 0.6422103),
        radius: Radius.elliptical(
            size.width * 0.06352818, size.height * 0.06115487),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_11.cubicTo(
        size.width * 0.8200910,
        size.height * 0.6427579,
        size.width * 0.8217973,
        size.height * 0.6446532,
        size.width * 0.8222349,
        size.height * 0.6489070);
    path_11.cubicTo(
        size.width * 0.8225411,
        size.height * 0.6516868,
        size.width * 0.8228036,
        size.height * 0.6560249,
        size.width * 0.8203973,
        size.height * 0.6576254);
    path_11.cubicTo(
        size.width * 0.8160221,
        size.height * 0.6605315,
        size.width * 0.8064403,
        size.height * 0.6600261,
        size.width * 0.8014963,
        size.height * 0.6604052);
    path_11.arcToPoint(Offset(size.width * 0.7555565, size.height * 0.6607421),
        radius:
            Radius.elliptical(size.width * 0.3219723, size.height * 0.3099440),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_11.arcToPoint(Offset(size.width * 0.7349930, size.height * 0.6588468),
        radius:
            Radius.elliptical(size.width * 0.1994662, size.height * 0.1920145),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_11.arcToPoint(Offset(size.width * 0.7226111, size.height * 0.6548456),
        radius: Radius.elliptical(
            size.width * 0.02795765, size.height * 0.02691320),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_11.cubicTo(
        size.width * 0.7184547,
        size.height * 0.6516026,
        size.width * 0.7196360,
        size.height * 0.6446953,
        size.width * 0.7196360,
        size.height * 0.6398939);
    path_11.lineTo(size.width * 0.7196360, size.height * 0.5904898);
    path_11.cubicTo(
        size.width * 0.7196360,
        size.height * 0.5842564,
        size.width * 0.7182359,
        size.height * 0.5758750,
        size.width * 0.7216923,
        size.height * 0.5702733);
    path_11.cubicTo(
        size.width * 0.7288677,
        size.height * 0.5585646,
        size.width * 0.7099667,
        size.height * 0.5479510,
        size.width * 0.7027914,
        size.height * 0.5596176);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
