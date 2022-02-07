// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class HomeResultsCustomPainter extends CustomPainter {
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
    paint_0_fill.color = const Color(0xffbaecff).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.6407070, size.height * 0.6310492);
    path_1.quadraticBezierTo(size.width * 0.5247637, size.height * 0.6410732,
        size.width * 0.4083392, size.height * 0.6450743);
    path_1.lineTo(size.width * 0.4192772, size.height * 0.6556038);
    path_1.lineTo(size.width * 0.4192772, size.height * 0.5896475);
    path_1.lineTo(size.width * 0.4083392, size.height * 0.6001769);
    path_1.quadraticBezierTo(size.width * 0.5247200, size.height * 0.5962600,
        size.width * 0.6407070, size.height * 0.5861938);
    path_1.arcToPoint(Offset(size.width * 0.6516451, size.height * 0.5756644),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.6516451, size.height * 0.5096239);
    path_1.arcToPoint(Offset(size.width * 0.6407070, size.height * 0.4990945),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.quadraticBezierTo(size.width * 0.5247637, size.height * 0.5090764,
        size.width * 0.4083392, size.height * 0.5130775);
    path_1.lineTo(size.width * 0.4192772, size.height * 0.5236070);
    path_1.lineTo(size.width * 0.4192772, size.height * 0.4573137);
    path_1.lineTo(size.width * 0.4083392, size.height * 0.4678432);
    path_1.quadraticBezierTo(size.width * 0.5247200, size.height * 0.4638841,
        size.width * 0.6407070, size.height * 0.4538180);
    path_1.arcToPoint(Offset(size.width * 0.6516451, size.height * 0.4432885),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.6516451, size.height * 0.3772059);
    path_1.arcToPoint(Offset(size.width * 0.6407070, size.height * 0.3666765),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.quadraticBezierTo(size.width * 0.5247637, size.height * 0.3767426,
        size.width * 0.4083392, size.height * 0.3807017);
    path_1.lineTo(size.width * 0.4192772, size.height * 0.3912311);
    path_1.lineTo(size.width * 0.4214211, size.height * 0.3190835);
    path_1.lineTo(size.width * 0.4248337, size.height * 0.2040601);
    path_1.lineTo(size.width * 0.4255775, size.height * 0.1776945);
    path_1.lineTo(size.width * 0.4175709, size.height * 0.1878448);
    path_1.arcToPoint(Offset(size.width * 0.5485212, size.height * 0.1696921),
        radius:
            Radius.elliptical(size.width * 0.5612531, size.height * 0.5402856),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6129681, size.height * 0.1718401),
        radius:
            Radius.elliptical(size.width * 0.4287714, size.height * 0.4127532),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6351068, size.height * 0.1785368),
        radius: Radius.elliptical(
            size.width * 0.05250263, size.height * 0.05054121),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6471824, size.height * 0.1972792),
        radius: Radius.elliptical(
            size.width * 0.03167658, size.height * 0.03049320),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6525201, size.height * 0.2260456),
        radius:
            Radius.elliptical(size.width * 0.1876094, size.height * 0.1806006),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6497200, size.height * 0.2537169),
        radius: Radius.elliptical(
            size.width * 0.05880294, size.height * 0.05660616),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6351505, size.height * 0.2679948),
        radius: Radius.elliptical(
            size.width * 0.02625131, size.height * 0.02527061),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6054428, size.height * 0.2731331),
        radius:
            Radius.elliptical(size.width * 0.1264438, size.height * 0.1217201),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.4698110, size.height * 0.2756181),
        radius:
            Radius.elliptical(size.width * 0.6741337, size.height * 0.6489492),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.4533164,
        size.height * 0.2743124,
        size.width * 0.4316153,
        size.height * 0.2720381,
        size.width * 0.4251400,
        size.height * 0.2545592);
    path_1.arcToPoint(Offset(size.width * 0.4211586, size.height * 0.2233922),
        radius:
            Radius.elliptical(size.width * 0.1010676, size.height * 0.09729183),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.4235212, size.height * 0.1854862),
        radius:
            Radius.elliptical(size.width * 0.2701698, size.height * 0.2600767),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.4016451, size.height * 0.1854862);
    path_1.lineTo(size.width * 0.3993262, size.height * 0.2143790);
    path_1.lineTo(size.width * 0.4102643, size.height * 0.2038496);
    path_1.cubicTo(
        size.width * 0.3825691,
        size.height * 0.2044392,
        size.width * 0.3464298,
        size.height * 0.2009434,
        size.width * 0.3253850,
        size.height * 0.2222550);
    path_1.cubicTo(
        size.width * 0.3043402,
        size.height * 0.2435665,
        size.width * 0.3102030,
        size.height * 0.2743545,
        size.width * 0.3171159,
        size.height * 0.2996673);
    path_1.cubicTo(
        size.width * 0.3203973,
        size.height * 0.3117129,
        size.width * 0.3375919,
        size.height * 0.3080908,
        size.width * 0.3385982,
        size.height * 0.2968454);
    path_1.lineTo(size.width * 0.3391232, size.height * 0.2911174);
    path_1.lineTo(size.width * 0.3172471, size.height * 0.2911174);
    path_1.lineTo(size.width * 0.3267413, size.height * 0.6112117);
    path_1.cubicTo(
        size.width * 0.3279664,
        size.height * 0.6530346,
        size.width * 0.3256038,
        size.height * 0.6986901,
        size.width * 0.3448547,
        size.height * 0.7375648);
    path_1.arcToPoint(Offset(size.width * 0.3881257, size.height * 0.7796824),
        radius: Radius.elliptical(
            size.width * 0.09139832, size.height * 0.08798383),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.4094330,
        size.height * 0.7891589,
        size.width * 0.4328404,
        size.height * 0.7915596,
        size.width * 0.4560291,
        size.height * 0.7927810);
    path_1.arcToPoint(Offset(size.width * 0.6190935, size.height * 0.7918123),
        radius:
            Radius.elliptical(size.width * 1.345817, size.height * 1.295540),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.6439447,
        size.height * 0.7902119,
        size.width * 0.6697585,
        size.height * 0.7892010,
        size.width * 0.6941722,
        size.height * 0.7841048);
    path_1.cubicTo(
        size.width * 0.7160483,
        size.height * 0.7795561,
        size.width * 0.7360868,
        size.height * 0.7684791,
        size.width * 0.7453623,
        size.height * 0.7481363);
    path_1.cubicTo(
        size.width * 0.7550753,
        size.height * 0.7270775,
        size.width * 0.7541127,
        size.height * 0.7024807,
        size.width * 0.7553378,
        size.height * 0.6797372);
    path_1.quadraticBezierTo(size.width * 0.7574379, size.height * 0.6394306,
        size.width * 0.7592755, size.height * 0.5990397);
    path_1.quadraticBezierTo(size.width * 0.7629069, size.height * 0.5193110,
        size.width * 0.7657945, size.height * 0.4395822);
    path_1.quadraticBezierTo(size.width * 0.7672384, size.height * 0.3996968,
        size.width * 0.7684634, size.height * 0.3598534);
    path_1.cubicTo(
        size.width * 0.7692510,
        size.height * 0.3350461,
        size.width * 0.7710448,
        size.height * 0.3099440,
        size.width * 0.7701698,
        size.height * 0.2850946);
    path_1.cubicTo(
        size.width * 0.7693822,
        size.height * 0.2632355,
        size.width * 0.7645257,
        size.height * 0.2409973,
        size.width * 0.7482937,
        size.height * 0.2246557);
    path_1.cubicTo(
        size.width * 0.7338992,
        size.height * 0.2100830,
        size.width * 0.7132919,
        size.height * 0.2035968,
        size.width * 0.6931222,
        size.height * 0.2007750);
    path_1.arcToPoint(Offset(size.width * 0.6607455, size.height * 0.1988376),
        radius:
            Radius.elliptical(size.width * 0.2427809, size.height * 0.2337110),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.6466573,
        size.height * 0.1988376,
        size.width * 0.6466573,
        size.height * 0.2198964,
        size.width * 0.6607455,
        size.height * 0.2198964);
    path_1.cubicTo(
        size.width * 0.6790777,
        size.height * 0.2198964,
        size.width * 0.6988537,
        size.height * 0.2206545,
        size.width * 0.7158295,
        size.height * 0.2283199);
    path_1.cubicTo(
        size.width * 0.7339429,
        size.height * 0.2363223,
        size.width * 0.7433934,
        size.height * 0.2511477,
        size.width * 0.7467186,
        size.height * 0.2696795);
    path_1.cubicTo(
        size.width * 0.7505688,
        size.height * 0.2907383,
        size.width * 0.7478561,
        size.height * 0.3135661,
        size.width * 0.7472436,
        size.height * 0.3348776);
    path_1.quadraticBezierTo(size.width * 0.7460623, size.height * 0.3731626,
        size.width * 0.7447935, size.height * 0.4114476);
    path_1.quadraticBezierTo(size.width * 0.7421684, size.height * 0.4875121,
        size.width * 0.7388432, size.height * 0.5635345);
    path_1.quadraticBezierTo(size.width * 0.7372244, size.height * 0.6018195,
        size.width * 0.7353430, size.height * 0.6401045);
    path_1.cubicTo(
        size.width * 0.7341617,
        size.height * 0.6645327,
        size.width * 0.7335929,
        size.height * 0.6890873,
        size.width * 0.7314491,
        size.height * 0.7134734);
    path_1.cubicTo(
        size.width * 0.7298740,
        size.height * 0.7315419,
        size.width * 0.7247550,
        size.height * 0.7490208,
        size.width * 0.7069916,
        size.height * 0.7579497);
    path_1.cubicTo(
        size.width * 0.6885719,
        size.height * 0.7672156,
        size.width * 0.6649457,
        size.height * 0.7673420,
        size.width * 0.6447322,
        size.height * 0.7689845);
    path_1.arcToPoint(Offset(size.width * 0.4897620, size.height * 0.7731963),
        radius:
            Radius.elliptical(size.width * 1.356974, size.height * 1.306280),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.4664858,
        size.height * 0.7725645,
        size.width * 0.4424221,
        size.height * 0.7726067,
        size.width * 0.4197585,
        size.height * 0.7678474);
    path_1.cubicTo(
        size.width * 0.4011638,
        size.height * 0.7639725,
        size.width * 0.3835754,
        size.height * 0.7560544,
        size.width * 0.3720686,
        size.height * 0.7409763);
    path_1.cubicTo(
        size.width * 0.3488799,
        size.height * 0.7106094,
        size.width * 0.3501925,
        size.height * 0.6685339,
        size.width * 0.3490987,
        size.height * 0.6326496);
    path_1.lineTo(size.width * 0.3400420, size.height * 0.3289391);
    path_1.lineTo(size.width * 0.3389482, size.height * 0.2912437);
    path_1.cubicTo(
        size.width * 0.3385107,
        size.height * 0.2775555,
        size.width * 0.3182097,
        size.height * 0.2778924,
        size.width * 0.3170721,
        size.height * 0.2912437);
    path_1.lineTo(size.width * 0.3165471, size.height * 0.2969717);
    path_1.lineTo(size.width * 0.3380294, size.height * 0.2941920);
    path_1.cubicTo(
        size.width * 0.3332167,
        size.height * 0.2765025,
        size.width * 0.3261288,
        size.height * 0.2507686,
        size.width * 0.3418358,
        size.height * 0.2361538);
    path_1.cubicTo(
        size.width * 0.3489674,
        size.height * 0.2294992,
        size.width * 0.3597305,
        size.height * 0.2272670,
        size.width * 0.3693560,
        size.height * 0.2263404);
    path_1.cubicTo(
        size.width * 0.3828316,
        size.height * 0.2250769,
        size.width * 0.3965261,
        size.height * 0.2253296,
        size.width * 0.4100893,
        size.height * 0.2250347);
    path_1.arcToPoint(Offset(size.width * 0.4210273, size.height * 0.2145053),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.4233462, size.height * 0.1856126);
    path_1.arcToPoint(Offset(size.width * 0.4124081, size.height * 0.1750832),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.4014701, size.height * 0.1856126),
        radius: Radius.elliptical(
            size.width * 0.01120056, size.height * 0.01078213),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.3991075, size.height * 0.2225498),
        radius:
            Radius.elliptical(size.width * 0.2677634, size.height * 0.2577602),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.4028264, size.height * 0.2569178),
        radius:
            Radius.elliptical(size.width * 0.1425884, size.height * 0.1372615),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.4087329,
        size.height * 0.2779767,
        size.width * 0.4264088,
        size.height * 0.2898117,
        size.width * 0.4477599,
        size.height * 0.2938971);
    path_1.cubicTo(
        size.width * 0.4707298,
        size.height * 0.2981089,
        size.width * 0.4950998,
        size.height * 0.2985301,
        size.width * 0.5184634,
        size.height * 0.2987407);
    path_1.arcToPoint(Offset(size.width * 0.5950298, size.height * 0.2953291),
        radius:
            Radius.elliptical(size.width * 0.6650333, size.height * 0.6401887),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.6074991,
        size.height * 0.2940656,
        size.width * 0.6201435,
        size.height * 0.2928021,
        size.width * 0.6324816,
        size.height * 0.2904856);
    path_1.arcToPoint(Offset(size.width * 0.6603518, size.height * 0.2764604),
        radius: Radius.elliptical(
            size.width * 0.04939622, size.height * 0.04755086),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.6767588,
        size.height * 0.2588131,
        size.width * 0.6764088,
        size.height * 0.2350588,
        size.width * 0.6727336,
        size.height * 0.2129891);
    path_1.cubicTo(
        size.width * 0.6692772,
        size.height * 0.1919303,
        size.width * 0.6647270,
        size.height * 0.1697342,
        size.width * 0.6435947,
        size.height * 0.1588258);
    path_1.cubicTo(
        size.width * 0.6244312,
        size.height * 0.1489281,
        size.width * 0.6001050,
        size.height * 0.1493072,
        size.width * 0.5789289,
        size.height * 0.1487175);
    path_1.arcToPoint(Offset(size.width * 0.4119268, size.height * 0.1675441),
        radius:
            Radius.elliptical(size.width * 0.5830417, size.height * 0.5612602),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.4038764, size.height * 0.1776945),
        radius: Radius.elliptical(
            size.width * 0.01120056, size.height * 0.01078213),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.4017763, size.height * 0.2498421);
    path_1.lineTo(size.width * 0.3981449, size.height * 0.3648233);
    path_1.lineTo(size.width * 0.3973574, size.height * 0.3912311);
    path_1.arcToPoint(Offset(size.width * 0.4082954, size.height * 0.4017605),
        radius: Radius.elliptical(
            size.width * 0.01111306, size.height * 0.01069789),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.quadraticBezierTo(size.width * 0.5246762, size.height * 0.3978015,
        size.width * 0.6406633, size.height * 0.3877353);
    path_1.lineTo(size.width * 0.6297252, size.height * 0.3772059);
    path_1.lineTo(size.width * 0.6297252, size.height * 0.4432885);
    path_1.lineTo(size.width * 0.6406633, size.height * 0.4327591);
    path_1.quadraticBezierTo(size.width * 0.5247200, size.height * 0.4428253,
        size.width * 0.4082954, size.height * 0.4467843);
    path_1.arcToPoint(Offset(size.width * 0.3973574, size.height * 0.4573137),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.3973574, size.height * 0.5233964);
    path_1.arcToPoint(Offset(size.width * 0.4082954, size.height * 0.5339258),
        radius: Radius.elliptical(
            size.width * 0.01106930, size.height * 0.01065577),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.quadraticBezierTo(size.width * 0.5246762, size.height * 0.5299667,
        size.width * 0.6406633, size.height * 0.5199427);
    path_1.lineTo(size.width * 0.6297252, size.height * 0.5094133);
    path_1.lineTo(size.width * 0.6297252, size.height * 0.5754959);
    path_1.lineTo(size.width * 0.6406633, size.height * 0.5649665);
    path_1.quadraticBezierTo(size.width * 0.5247200, size.height * 0.5749905,
        size.width * 0.4082954, size.height * 0.5789496);
    path_1.arcToPoint(Offset(size.width * 0.3973574, size.height * 0.5894790),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.3973574, size.height * 0.6556038);
    path_1.arcToPoint(Offset(size.width * 0.4082954, size.height * 0.6661332),
        radius: Radius.elliptical(
            size.width * 0.01111306, size.height * 0.01069789),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.quadraticBezierTo(size.width * 0.5246762, size.height * 0.6621741,
        size.width * 0.6406633, size.height * 0.6521080);
    path_1.arcToPoint(Offset(size.width * 0.6516013, size.height * 0.6415786),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.6406633, size.height * 0.6310492),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = const Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
