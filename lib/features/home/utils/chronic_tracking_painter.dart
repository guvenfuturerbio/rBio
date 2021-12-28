import 'package:flutter/material.dart';

class HomeChronicTrackingCustomPainter extends CustomPainter {
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
    paint_0_fill.color = Color(0xffffc4cf).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.7020039, size.height * 0.1959314);
    path_1.cubicTo(
        size.width * 0.6845030,
        size.height * 0.1496020,
        size.width * 0.6301190,
        size.height * 0.1300594,
        size.width * 0.5823854,
        size.height * 0.1365876);
    path_1.cubicTo(
        size.width * 0.5260763,
        size.height * 0.1443373,
        size.width * 0.4784302,
        size.height * 0.1866234,
        size.width * 0.4627669,
        size.height * 0.2387230);
    path_1.cubicTo(
        size.width * 0.4474974,
        size.height * 0.2897275,
        size.width * 0.4627669,
        size.height * 0.3485238,
        size.width * 0.5065191,
        size.height * 0.3821337);
    path_1.arcToPoint(Offset(size.width * 0.5825166, size.height * 0.4060565),
        radius:
            Radius.elliptical(size.width * 0.1116556, size.height * 0.1074843),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.6652520, size.height * 0.3756897),
        radius:
            Radius.elliptical(size.width * 0.1520389, size.height * 0.1463589),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.7201610, size.height * 0.3024892),
        radius:
            Radius.elliptical(size.width * 0.1551453, size.height * 0.1493493),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.7128981, size.height * 0.2063766),
        radius:
            Radius.elliptical(size.width * 0.1350630, size.height * 0.1300173),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.7066416,
        size.height * 0.1942467,
        size.width * 0.6877844,
        size.height * 0.2049025,
        size.width * 0.6939972,
        size.height * 0.2169903);
    path_1.cubicTo(
        size.width * 0.7166608,
        size.height * 0.2612138,
        size.width * 0.7016976,
        size.height * 0.3138609,
        size.width * 0.6662146,
        size.height * 0.3475551);
    path_1.cubicTo(
        size.width * 0.6322191,
        size.height * 0.3795645,
        size.width * 0.5767851,
        size.height * 0.3985596,
        size.width * 0.5327704,
        size.height * 0.3741313);
    path_1.cubicTo(
        size.width * 0.4929996,
        size.height * 0.3520617,
        size.width * 0.4740112,
        size.height * 0.3060692,
        size.width * 0.4796990,
        size.height * 0.2632355);
    path_1.arcToPoint(Offset(size.width * 0.5682097, size.height * 0.1613107),
        radius:
            Radius.elliptical(size.width * 0.1291127, size.height * 0.1242893),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.6075866,
        size.height * 0.1493072,
        size.width * 0.6650333,
        size.height * 0.1594154,
        size.width * 0.6809153,
        size.height * 0.2015331);
    path_1.arcToPoint(Offset(size.width * 0.6943472, size.height * 0.2088616),
        radius: Radius.elliptical(
            size.width * 0.01120056, size.height * 0.01078213),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.7020039, size.height * 0.1959314),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.4284214, size.height * 0.7429979);
    path_2.arcToPoint(Offset(size.width * 0.4624606, size.height * 0.5808870),
        radius:
            Radius.elliptical(size.width * 0.7000350, size.height * 0.6738828),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.cubicTo(
        size.width * 0.4779926,
        size.height * 0.5360317,
        size.width * 0.4971999,
        size.height * 0.4882281,
        size.width * 0.5316328,
        size.height * 0.4534389);
    path_2.cubicTo(
        size.width * 0.5482587,
        size.height * 0.4365918,
        size.width * 0.5693035,
        size.height * 0.4221455,
        size.width * 0.5934547,
        size.height * 0.4177652);
    path_2.cubicTo(
        size.width * 0.6182622,
        size.height * 0.4132586,
        size.width * 0.6393070,
        size.height * 0.4261888,
        size.width * 0.6557578,
        size.height * 0.4430358);
    path_2.cubicTo(
        size.width * 0.6903658,
        size.height * 0.4781199,
        size.width * 0.7071229,
        size.height * 0.5258392,
        size.width * 0.7162671,
        size.height * 0.5725056);
    path_2.cubicTo(
        size.width * 0.7284302,
        size.height * 0.6345449,
        size.width * 0.7275989,
        size.height * 0.6981847,
        size.width * 0.7410308,
        size.height * 0.7600556);
    path_2.arcToPoint(Offset(size.width * 0.7544627, size.height * 0.7674262),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.arcToPoint(Offset(size.width * 0.7621194, size.height * 0.7544539),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.cubicTo(
        size.width * 0.7390182,
        size.height * 0.6478541,
        size.width * 0.7563878,
        size.height * 0.5247441,
        size.width * 0.6782902,
        size.height * 0.4357916);
    path_2.cubicTo(
        size.width * 0.6605705,
        size.height * 0.4155330,
        size.width * 0.6375131,
        size.height * 0.3981805,
        size.width * 0.6091617,
        size.height * 0.3961589);
    path_2.cubicTo(
        size.width * 0.5808103,
        size.height * 0.3941372,
        size.width * 0.5541652,
        size.height * 0.4076149,
        size.width * 0.5329016,
        size.height * 0.4239565);
    path_2.cubicTo(
        size.width * 0.4914683,
        size.height * 0.4557975,
        size.width * 0.4683672,
        size.height * 0.5048225,
        size.width * 0.4502100,
        size.height * 0.5514467);
    path_2.arcToPoint(Offset(size.width * 0.4064578, size.height * 0.7432085),
        radius:
            Radius.elliptical(size.width * 0.7219111, size.height * 0.6949417),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.arcToPoint(Offset(size.width * 0.4173959, size.height * 0.7537379),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.arcToPoint(Offset(size.width * 0.4283339, size.height * 0.7432085),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.4186209, size.height * 0.7547488);
    path_3.arcToPoint(Offset(size.width * 0.6775026, size.height * 0.7749653),
        radius:
            Radius.elliptical(size.width * 1.256038, size.height * 1.209114),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.quadraticBezierTo(size.width * 0.7147357, size.height * 0.7741650,
        size.width * 0.7518813, size.height * 0.7711325);
    path_3.arcToPoint(Offset(size.width * 0.7628194, size.height * 0.7606031),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.7518813, size.height * 0.7500737),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.4950998, size.height * 0.7449775),
        radius:
            Radius.elliptical(size.width * 1.240856, size.height * 1.194499),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.cubicTo(
        size.width * 0.4714298,
        size.height * 0.7421135,
        size.width * 0.4478911,
        size.height * 0.7384913,
        size.width * 0.4244837,
        size.height * 0.7343217);
    path_3.arcToPoint(Offset(size.width * 0.4110081, size.height * 0.7416502),
        radius: Radius.elliptical(
            size.width * 0.01120056, size.height * 0.01078213),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.4186647, size.height * 0.7546224),
        radius: Radius.elliptical(
            size.width * 0.01111306, size.height * 0.01069789),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4996062, size.height * 0.4574401);
    path_4.arcToPoint(Offset(size.width * 0.5063003, size.height * 0.5694310),
        radius:
            Radius.elliptical(size.width * 0.1671334, size.height * 0.1608895),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.5212636, size.height * 0.5731795),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.5252013, size.height * 0.5587752),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.5208260, size.height * 0.4630417),
        radius:
            Radius.elliptical(size.width * 0.1435947, size.height * 0.1382302),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.5252013,
        size.height * 0.4501116,
        size.width * 0.5039377,
        size.height * 0.4445521,
        size.width * 0.4996937,
        size.height * 0.4574401);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.5278264, size.height * 0.6382934);
    path_5.arcToPoint(Offset(size.width * 0.5237574, size.height * 0.6340816),
        radius: Radius.elliptical(
            size.width * 0.01750088, size.height * 0.01684707),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.arcToPoint(Offset(size.width * 0.5218323, size.height * 0.6308386),
        radius: Radius.elliptical(
            size.width * 0.03193910, size.height * 0.03074590),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.5215698,
        size.height * 0.6303753,
        size.width * 0.5213511,
        size.height * 0.6298699,
        size.width * 0.5210886,
        size.height * 0.6294066);
    path_5.cubicTo(
        size.width * 0.5217448,
        size.height * 0.6307543,
        size.width * 0.5207823,
        size.height * 0.6286484,
        size.width * 0.5206948,
        size.height * 0.6283957);
    path_5.arcToPoint(Offset(size.width * 0.5166696, size.height * 0.6129807),
        radius: Radius.elliptical(
            size.width * 0.09533602, size.height * 0.09177442),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.5166696,
        size.height * 0.6118014,
        size.width * 0.5162758,
        size.height * 0.6106221,
        size.width * 0.5160571,
        size.height * 0.6094428);
    path_5.cubicTo(
        size.width * 0.5158383,
        size.height * 0.6082635,
        size.width * 0.5160571,
        size.height * 0.6094428,
        size.width * 0.5160571,
        size.height * 0.6096955);
    path_5.cubicTo(
        size.width * 0.5160571,
        size.height * 0.6090216,
        size.width * 0.5160571,
        size.height * 0.6083056,
        size.width * 0.5160571,
        size.height * 0.6076317);
    path_5.arcToPoint(Offset(size.width * 0.5155758, size.height * 0.6003454),
        radius: Radius.elliptical(
            size.width * 0.07245362, size.height * 0.06974687),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.arcToPoint(Offset(size.width * 0.5159258, size.height * 0.5932275),
        radius: Radius.elliptical(
            size.width * 0.05250263, size.height * 0.05054121),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.5156633,
        size.height * 0.5952070,
        size.width * 0.5162321,
        size.height * 0.5921324,
        size.width * 0.5163633,
        size.height * 0.5916270);
    path_5.arcToPoint(Offset(size.width * 0.5175446, size.height * 0.5878785),
        radius: Radius.elliptical(
            size.width * 0.03062653, size.height * 0.02948237),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.5181134,
        size.height * 0.5863202,
        size.width * 0.5168008,
        size.height * 0.5891842,
        size.width * 0.5175446,
        size.height * 0.5878785);
    path_5.lineTo(size.width * 0.5182009, size.height * 0.5866150);
    path_5.lineTo(size.width * 0.5192510, size.height * 0.5849724);
    path_5.cubicTo(
        size.width * 0.5192510,
        size.height * 0.5849724,
        size.width * 0.5203448,
        size.height * 0.5836668,
        size.width * 0.5196010,
        size.height * 0.5845091);
    path_5.cubicTo(
        size.width * 0.5188572,
        size.height * 0.5853515,
        size.width * 0.5202573,
        size.height * 0.5839195,
        size.width * 0.5204323,
        size.height * 0.5837089);
    path_5.lineTo(size.width * 0.5215698, size.height * 0.5826981);
    path_5.cubicTo(
        size.width * 0.5219198,
        size.height * 0.5823611,
        size.width * 0.5231887,
        size.height * 0.5816872,
        size.width * 0.5215698,
        size.height * 0.5826981);
    path_5.lineTo(size.width * 0.5232324, size.height * 0.5817294);
    path_5.lineTo(size.width * 0.5249387, size.height * 0.5808870);
    path_5.cubicTo(
        size.width * 0.5249387,
        size.height * 0.5808870,
        size.width * 0.5233637,
        size.height * 0.5814345,
        size.width * 0.5245450,
        size.height * 0.5810976);
    path_5.lineTo(size.width * 0.5277826, size.height * 0.5802974);
    path_5.cubicTo(
        size.width * 0.5277826,
        size.height * 0.5802974,
        size.width * 0.5294890,
        size.height * 0.5802974,
        size.width * 0.5282202,
        size.height * 0.5802974);
    path_5.cubicTo(
        size.width * 0.5269513,
        size.height * 0.5802974,
        size.width * 0.5288327,
        size.height * 0.5802974,
        size.width * 0.5291827,
        size.height * 0.5802974);
    path_5.lineTo(size.width * 0.5330767, size.height * 0.5802974);
    path_5.lineTo(size.width * 0.5325954, size.height * 0.5802974);
    path_5.cubicTo(
        size.width * 0.5332517,
        size.height * 0.5802974,
        size.width * 0.5339079,
        size.height * 0.5802974,
        size.width * 0.5345642,
        size.height * 0.5806764);
    path_5.arcToPoint(Offset(size.width * 0.5379769, size.height * 0.5816030),
        radius: Radius.elliptical(
            size.width * 0.03320791, size.height * 0.03196732),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.lineTo(size.width * 0.5393770, size.height * 0.5820663);
    path_5.cubicTo(
        size.width * 0.5389832,
        size.height * 0.5820663,
        size.width * 0.5376706,
        size.height * 0.5812239,
        size.width * 0.5393770,
        size.height * 0.5820663);
    path_5.cubicTo(
        size.width * 0.5406020,
        size.height * 0.5826559,
        size.width * 0.5417833,
        size.height * 0.5832456,
        size.width * 0.5429646,
        size.height * 0.5839195);
    path_5.lineTo(size.width * 0.5442335, size.height * 0.5847197);
    path_5.cubicTo(
        size.width * 0.5442335,
        size.height * 0.5847197,
        size.width * 0.5462023,
        size.height * 0.5860254,
        size.width * 0.5451960,
        size.height * 0.5853094);
    path_5.cubicTo(
        size.width * 0.5441897,
        size.height * 0.5845934,
        size.width * 0.5455898,
        size.height * 0.5856463,
        size.width * 0.5456773,
        size.height * 0.5857305);
    path_5.lineTo(size.width * 0.5471649, size.height * 0.5869941);
    path_5.cubicTo(
        size.width * 0.5479086,
        size.height * 0.5877101,
        size.width * 0.5486524,
        size.height * 0.5884682,
        size.width * 0.5493525,
        size.height * 0.5892263);
    path_5.arcToPoint(Offset(size.width * 0.5513213, size.height * 0.5915849),
        radius: Radius.elliptical(
            size.width * 0.01347567, size.height * 0.01297224),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.5583654,
        size.height * 0.6019458,
        size.width * 0.5612093,
        size.height * 0.6129386,
        size.width * 0.5644470,
        size.height * 0.6256160);
    path_5.arcToPoint(Offset(size.width * 0.5805915, size.height * 0.6317652),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.5863231, size.height * 0.6107063),
        radius: Radius.elliptical(
            size.width * 0.01610081, size.height * 0.01549931),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.5674221, size.height * 0.6213200),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.5695660, size.height * 0.6134018),
        radius: Radius.elliptical(
            size.width * 0.006387819, size.height * 0.006149181),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.lineTo(size.width * 0.5856230, size.height * 0.6197195);
    path_5.cubicTo(
        size.width * 0.5823416,
        size.height * 0.6064524,
        size.width * 0.5787539,
        size.height * 0.5925957,
        size.width * 0.5707035,
        size.height * 0.5811397);
    path_5.arcToPoint(Offset(size.width * 0.5374081, size.height * 0.5594491),
        radius: Radius.elliptical(
            size.width * 0.05031502, size.height * 0.04843533),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.5002625, size.height * 0.5740639),
        radius: Radius.elliptical(
            size.width * 0.03640182, size.height * 0.03504191),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4928684,
        size.height * 0.5845512,
        size.width * 0.4926934,
        size.height * 0.5984501,
        size.width * 0.4943560,
        size.height * 0.6105378);
    path_5.cubicTo(
        size.width * 0.4964123,
        size.height * 0.6257002,
        size.width * 0.4999125,
        size.height * 0.6425473,
        size.width * 0.5123819,
        size.height * 0.6531188);
    path_5.arcToPoint(Offset(size.width * 0.5278264, size.height * 0.6531188),
        radius: Radius.elliptical(
            size.width * 0.01120056, size.height * 0.01078213),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.5278264, size.height * 0.6382092),
        radius: Radius.elliptical(
            size.width * 0.01106930, size.height * 0.01065577),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.6557140, size.height * 0.4656952);
    path_6.arcToPoint(Offset(size.width * 0.6351943, size.height * 0.5339258),
        radius:
            Radius.elliptical(size.width * 0.1637644, size.height * 0.1576465),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_6.arcToPoint(Offset(size.width * 0.6540515, size.height * 0.5445816),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.6775901, size.height * 0.4656952),
        radius:
            Radius.elliptical(size.width * 0.1872594, size.height * 0.1802637),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.6557140, size.height * 0.4656952),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.6490637, size.height * 0.5465611);
    path_7.arcToPoint(Offset(size.width * 0.6411446, size.height * 0.5395696),
        radius: Radius.elliptical(
            size.width * 0.02331992, size.height * 0.02244872),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6305565, size.height * 0.5368319),
        radius: Radius.elliptical(
            size.width * 0.02625131, size.height * 0.02527061),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6120494, size.height * 0.5429811),
        radius: Radius.elliptical(
            size.width * 0.02712636, size.height * 0.02611296),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6017238, size.height * 0.5586910),
        radius: Radius.elliptical(
            size.width * 0.03417046, size.height * 0.03289391),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.5995800, size.height * 0.5760856),
        radius: Radius.elliptical(
            size.width * 0.04952748, size.height * 0.04767721),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6078491, size.height * 0.5953755),
        radius: Radius.elliptical(
            size.width * 0.03036402, size.height * 0.02922967),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6253500, size.height * 0.6025776),
        radius: Radius.elliptical(
            size.width * 0.02773889, size.height * 0.02670261),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6421946, size.height * 0.5993767),
        radius: Radius.elliptical(
            size.width * 0.03403920, size.height * 0.03276755),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6553203, size.height * 0.5884682),
        radius: Radius.elliptical(
            size.width * 0.03298915, size.height * 0.03175673),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.6640707,
        size.height * 0.5770543,
        size.width * 0.6637644,
        size.height * 0.5620183,
        size.width * 0.6617518,
        size.height * 0.5487512);
    path_7.arcToPoint(Offset(size.width * 0.6567203, size.height * 0.5424336),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6482762, size.height * 0.5413806),
        radius: Radius.elliptical(
            size.width * 0.01137557, size.height * 0.01095060),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6417571, size.height * 0.5462242),
        radius: Radius.elliptical(
            size.width * 0.01106930, size.height * 0.01065577),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6406633, size.height * 0.5543529),
        radius: Radius.elliptical(
            size.width * 0.01246937, size.height * 0.01200354),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.6410133,
        size.height * 0.5565851,
        size.width * 0.6403570,
        size.height * 0.5516994,
        size.width * 0.6406633,
        size.height * 0.5539738);
    path_7.lineTo(size.width * 0.6406633, size.height * 0.5552373);
    path_7.lineTo(size.width * 0.6409258, size.height * 0.5583119);
    path_7.arcToPoint(Offset(size.width * 0.6409258, size.height * 0.5651771),
        radius: Radius.elliptical(
            size.width * 0.05543402, size.height * 0.05336310),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.cubicTo(
        size.width * 0.6409258,
        size.height * 0.5661037,
        size.width * 0.6402258,
        size.height * 0.5693889,
        size.width * 0.6409258,
        size.height * 0.5660616);
    path_7.cubicTo(
        size.width * 0.6409258,
        size.height * 0.5670724,
        size.width * 0.6406195,
        size.height * 0.5680832,
        size.width * 0.6403570,
        size.height * 0.5690940);
    path_7.cubicTo(
        size.width * 0.6400945,
        size.height * 0.5701049,
        size.width * 0.6398757,
        size.height * 0.5710315,
        size.width * 0.6395695,
        size.height * 0.5720002);
    path_7.lineTo(size.width * 0.6391757, size.height * 0.5731373);
    path_7.lineTo(size.width * 0.6386944, size.height * 0.5742745);
    path_7.lineTo(size.width * 0.6393507, size.height * 0.5728846);
    path_7.arcToPoint(Offset(size.width * 0.6379069, size.height * 0.5755381),
        radius: Radius.elliptical(
            size.width * 0.02060728, size.height * 0.01983743),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.6373819,
        size.height * 0.5764225,
        size.width * 0.6367256,
        size.height * 0.5772228,
        size.width * 0.6362006,
        size.height * 0.5780651);
    path_7.cubicTo(
        size.width * 0.6377756,
        size.height * 0.5754959,
        size.width * 0.6364631,
        size.height * 0.5776861,
        size.width * 0.6357630,
        size.height * 0.5783599);
    path_7.lineTo(size.width * 0.6346692, size.height * 0.5793286);
    path_7.cubicTo(
        size.width * 0.6333129,
        size.height * 0.5805501,
        size.width * 0.6369006,
        size.height * 0.5778966,
        size.width * 0.6352818,
        size.height * 0.5789075);
    path_7.lineTo(size.width * 0.6331379, size.height * 0.5802131);
    path_7.lineTo(size.width * 0.6322191, size.height * 0.5806764);
    path_7.cubicTo(
        size.width * 0.6313003,
        size.height * 0.5810976,
        size.width * 0.6299440,
        size.height * 0.5812239,
        size.width * 0.6329629,
        size.height * 0.5803816);
    path_7.cubicTo(
        size.width * 0.6321316,
        size.height * 0.5806343,
        size.width * 0.6313441,
        size.height * 0.5809712,
        size.width * 0.6305565,
        size.height * 0.5811818);
    path_7.lineTo(size.width * 0.6295502, size.height * 0.5814345);
    path_7.cubicTo(
        size.width * 0.6291127,
        size.height * 0.5814345,
        size.width * 0.6267938,
        size.height * 0.5818557,
        size.width * 0.6290252,
        size.height * 0.5814345);
    path_7.cubicTo(
        size.width * 0.6312566,
        size.height * 0.5810134,
        size.width * 0.6285877,
        size.height * 0.5814345,
        size.width * 0.6279751,
        size.height * 0.5814345);
    path_7.arcToPoint(Offset(size.width * 0.6255250, size.height * 0.5814345),
        radius: Radius.elliptical(
            size.width * 0.02288239, size.height * 0.02202754),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.cubicTo(
        size.width * 0.6235124,
        size.height * 0.5814345,
        size.width * 0.6284127,
        size.height * 0.5819821,
        size.width * 0.6264876,
        size.height * 0.5814345);
    path_7.lineTo(size.width * 0.6255688, size.height * 0.5814345);
    path_7.lineTo(size.width * 0.6241687, size.height * 0.5810134);
    path_7.cubicTo(
        size.width * 0.6224624,
        size.height * 0.5805501,
        size.width * 0.6267063,
        size.height * 0.5822348,
        size.width * 0.6250438,
        size.height * 0.5813924);
    path_7.arcToPoint(Offset(size.width * 0.6229874, size.height * 0.5802552),
        radius: Radius.elliptical(
            size.width * 0.01920721, size.height * 0.01848966),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.cubicTo(
        size.width * 0.6215873,
        size.height * 0.5794550,
        size.width * 0.6241687,
        size.height * 0.5810134,
        size.width * 0.6240812,
        size.height * 0.5810555);
    path_7.arcToPoint(Offset(size.width * 0.6229874, size.height * 0.5801289),
        radius: Radius.elliptical(
            size.width * 0.007175359, size.height * 0.006907299),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.arcToPoint(Offset(size.width * 0.6223749, size.height * 0.5794129),
        radius: Radius.elliptical(
            size.width * 0.009144207, size.height * 0.008802594),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.6245187,
        size.height * 0.5812661,
        size.width * 0.6234249,
        size.height * 0.5808028,
        size.width * 0.6227249,
        size.height * 0.5797498);
    path_7.lineTo(size.width * 0.6221124, size.height * 0.5786126);
    path_7.cubicTo(
        size.width * 0.6211061,
        size.height * 0.5768437,
        size.width * 0.6228999,
        size.height * 0.5809712,
        size.width * 0.6221124,
        size.height * 0.5786126);
    path_7.arcToPoint(Offset(size.width * 0.6214123, size.height * 0.5758329),
        radius: Radius.elliptical(
            size.width * 0.01071929, size.height * 0.01031883),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.lineTo(size.width * 0.6214123, size.height * 0.5773912);
    path_7.lineTo(size.width * 0.6214123, size.height * 0.5761277);
    path_7.cubicTo(
        size.width * 0.6214123,
        size.height * 0.5757065,
        size.width * 0.6214123,
        size.height * 0.5752432,
        size.width * 0.6214123,
        size.height * 0.5748221);
    path_7.cubicTo(
        size.width * 0.6214123,
        size.height * 0.5737691,
        size.width * 0.6214123,
        size.height * 0.5726741,
        size.width * 0.6214123,
        size.height * 0.5716211);
    path_7.lineTo(size.width * 0.6214123, size.height * 0.5697679);
    path_7.cubicTo(
        size.width * 0.6214123,
        size.height * 0.5688835,
        size.width * 0.6221124,
        size.height * 0.5671566,
        size.width * 0.6214123,
        size.height * 0.5701891);
    path_7.cubicTo(
        size.width * 0.6218936,
        size.height * 0.5682517,
        size.width * 0.6221561,
        size.height * 0.5662722,
        size.width * 0.6227686,
        size.height * 0.5643348);
    path_7.lineTo(size.width * 0.6231624, size.height * 0.5631976);
    path_7.cubicTo(
        size.width * 0.6235124,
        size.height * 0.5623131,
        size.width * 0.6245187,
        size.height * 0.5610917,
        size.width * 0.6231624,
        size.height * 0.5635345);
    path_7.cubicTo(
        size.width * 0.6237312,
        size.height * 0.5626079,
        size.width * 0.6241687,
        size.height * 0.5616392,
        size.width * 0.6247812,
        size.height * 0.5607126);
    path_7.arcToPoint(Offset(size.width * 0.6256125, size.height * 0.5594912),
        radius: Radius.elliptical(
            size.width * 0.007919146, size.height * 0.007623299),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.6245187,
        size.height * 0.5608811,
        size.width * 0.6243437,
        size.height * 0.5611338,
        size.width * 0.6250438,
        size.height * 0.5602915);
    path_7.lineTo(size.width * 0.6254375, size.height * 0.5598703);
    path_7.lineTo(size.width * 0.6267501, size.height * 0.5586067);
    path_7.cubicTo(
        size.width * 0.6281939,
        size.height * 0.5572590,
        size.width * 0.6246062,
        size.height * 0.5599124,
        size.width * 0.6262688,
        size.height * 0.5589858);
    path_7.cubicTo(
        size.width * 0.6266626,
        size.height * 0.5589858,
        size.width * 0.6270126,
        size.height * 0.5585646,
        size.width * 0.6274064,
        size.height * 0.5583540);
    path_7.cubicTo(
        size.width * 0.6293752,
        size.height * 0.5571326,
        size.width * 0.6250875,
        size.height * 0.5590279,
        size.width * 0.6269251,
        size.height * 0.5583540);
    path_7.cubicTo(
        size.width * 0.6278439,
        size.height * 0.5581013,
        size.width * 0.6288064,
        size.height * 0.5579329,
        size.width * 0.6297252,
        size.height * 0.5576380);
    path_7.cubicTo(
        size.width * 0.6306440,
        size.height * 0.5573432,
        size.width * 0.6266188,
        size.height * 0.5578486,
        size.width * 0.6286314,
        size.height * 0.5576380);
    path_7.cubicTo(
        size.width * 0.6291127,
        size.height * 0.5576380,
        size.width * 0.6296377,
        size.height * 0.5576380,
        size.width * 0.6301628,
        size.height * 0.5576380);
    path_7.cubicTo(
        size.width * 0.6314316,
        size.height * 0.5576380,
        size.width * 0.6319566,
        size.height * 0.5583119,
        size.width * 0.6292877,
        size.height * 0.5576380);
    path_7.lineTo(size.width * 0.6307753, size.height * 0.5579329);
    path_7.cubicTo(
        size.width * 0.6311691,
        size.height * 0.5579329,
        size.width * 0.6327879,
        size.height * 0.5586910,
        size.width * 0.6307753,
        size.height * 0.5579329);
    path_7.cubicTo(
        size.width * 0.6287627,
        size.height * 0.5571747,
        size.width * 0.6307753,
        size.height * 0.5579329,
        size.width * 0.6312566,
        size.height * 0.5583119);
    path_7.cubicTo(
        size.width * 0.6317378,
        size.height * 0.5586910,
        size.width * 0.6316066,
        size.height * 0.5592385,
        size.width * 0.6302065,
        size.height * 0.5575117);
    path_7.cubicTo(
        size.width * 0.6306878,
        size.height * 0.5581435,
        size.width * 0.6324379,
        size.height * 0.5600387,
        size.width * 0.6302065,
        size.height * 0.5571747);
    path_7.arcToPoint(Offset(size.width * 0.6367256, size.height * 0.5620183),
        radius: Radius.elliptical(
            size.width * 0.01203185, size.height * 0.01158236),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6451698, size.height * 0.5609653),
        radius: Radius.elliptical(
            size.width * 0.01137557, size.height * 0.01095060),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.6491075, size.height * 0.5465190),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.4812741, size.height * 0.2436086);
    path_8.arcToPoint(Offset(size.width * 0.6901470, size.height * 0.2450406),
        radius:
            Radius.elliptical(size.width * 0.2982149, size.height * 0.2870741),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.6978036, size.height * 0.2320684),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.6843717, size.height * 0.2246978),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.4872681, size.height * 0.2232237),
        radius:
            Radius.elliptical(size.width * 0.2793140, size.height * 0.2688792),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_8.arcToPoint(Offset(size.width * 0.4737924, size.height * 0.2305943),
        radius: Radius.elliptical(
            size.width * 0.01106930, size.height * 0.01065577),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.4812741, size.height * 0.2436086),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.5804165, size.height * 0.1811060);
    path_9.cubicTo(
        size.width * 0.5882919,
        size.height * 0.1765152,
        size.width * 0.5997987,
        size.height * 0.1788317,
        size.width * 0.6072366,
        size.height * 0.1859495);
    path_9.arcToPoint(Offset(size.width * 0.6147620, size.height * 0.1998484),
        radius: Radius.elliptical(
            size.width * 0.02699510, size.height * 0.02598661),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.arcToPoint(Offset(size.width * 0.6032989, size.height * 0.2281515),
        radius: Radius.elliptical(
            size.width * 0.03062653, size.height * 0.02948237),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.arcToPoint(Offset(size.width * 0.5879419, size.height * 0.2334583),
        radius: Radius.elliptical(
            size.width * 0.02752013, size.height * 0.02649202),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.cubicTo(
        size.width * 0.5774851,
        size.height * 0.2338373,
        size.width * 0.5674221,
        size.height * 0.2280672,
        size.width * 0.5647532,
        size.height * 0.2196016);
    path_9.arcToPoint(Offset(size.width * 0.5853168, size.height * 0.2190119),
        radius: Radius.elliptical(
            size.width * 0.02795765, size.height * 0.02691320),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.arcToPoint(Offset(size.width * 0.5950298, size.height * 0.1947521),
        radius: Radius.elliptical(
            size.width * 0.02012601, size.height * 0.01937413),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.arcToPoint(Offset(size.width * 0.5804165, size.height * 0.1811060),
        radius: Radius.elliptical(
            size.width * 0.02734512, size.height * 0.02632355),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
