import 'package:flutter/material.dart';

class HomeHospitalAppointmentCustomPainter extends CustomPainter {
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
    paint_0_fill.color = Color(0xffcaead8).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.6309940, size.height * 0.1482121);
    path_1.cubicTo(
        size.width * 0.6551015,
        size.height * 0.1498126,
        size.width * 0.6791215,
        size.height * 0.1520448,
        size.width * 0.7030977,
        size.height * 0.1551615);
    path_1.cubicTo(
        size.width * 0.7128981,
        size.height * 0.1564251,
        size.width * 0.7237049,
        size.height * 0.1573516,
        size.width * 0.7326304,
        size.height * 0.1617319);
    path_1.arcToPoint(Offset(size.width * 0.7505688, size.height * 0.1808954),
        radius: Radius.elliptical(
            size.width * 0.04375219, size.height * 0.04211768),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.7706073,
        size.height * 0.2171166,
        size.width * 0.7764263,
        size.height * 0.2599503,
        size.width * 0.7784389,
        size.height * 0.3003833);
    path_1.cubicTo(
        size.width * 0.7806703,
        size.height * 0.3446489,
        size.width * 0.7793140,
        size.height * 0.3891673,
        size.width * 0.7789639,
        size.height * 0.4334330);
    path_1.cubicTo(
        size.width * 0.7785702,
        size.height * 0.4800573,
        size.width * 0.7779576,
        size.height * 0.5267237,
        size.width * 0.7766013,
        size.height * 0.5733058);
    path_1.cubicTo(
        size.width * 0.7750263,
        size.height * 0.6261635,
        size.width * 0.7724449,
        size.height * 0.6789791,
        size.width * 0.7682009,
        size.height * 0.7317104);
    path_1.lineTo(size.width * 0.7791390, size.height * 0.7211810);
    path_1.quadraticBezierTo(size.width * 0.6106055, size.height * 0.7312892,
        size.width * 0.4416346, size.height * 0.7268247);
    path_1.quadraticBezierTo(size.width * 0.3937259, size.height * 0.7255191,
        size.width * 0.3458610, size.height * 0.7230342);
    path_1.cubicTo(
        size.width * 0.3317728,
        size.height * 0.7223182,
        size.width * 0.3318166,
        size.height * 0.7433770,
        size.width * 0.3458610,
        size.height * 0.7440930);
    path_1.quadraticBezierTo(size.width * 0.5144382, size.height * 0.7528114,
        size.width * 0.6834092, size.height * 0.7468306);
    path_1.quadraticBezierTo(size.width * 0.7315366, size.height * 0.7451459,
        size.width * 0.7791390, size.height * 0.7422398);
    path_1.arcToPoint(Offset(size.width * 0.7900770, size.height * 0.7317104),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.7978649,
        size.height * 0.6348397,
        size.width * 0.7999650,
        size.height * 0.5379691,
        size.width * 0.8007525,
        size.height * 0.4407615);
    path_1.cubicTo(
        size.width * 0.8011463,
        size.height * 0.3944320,
        size.width * 0.8025901,
        size.height * 0.3483553,
        size.width * 0.8004463,
        size.height * 0.3022786);
    path_1.cubicTo(
        size.width * 0.7983462,
        size.height * 0.2586447,
        size.width * 0.7916958,
        size.height * 0.2144211,
        size.width * 0.7718323,
        size.height * 0.1747041);
    path_1.arcToPoint(Offset(size.width * 0.7504375, size.height * 0.1477067),
        radius: Radius.elliptical(
            size.width * 0.07577879, size.height * 0.07294782),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.7160046, size.height * 0.1358295),
        radius: Radius.elliptical(
            size.width * 0.07337242, size.height * 0.07063134),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.6877844,
        size.height * 0.1318283,
        size.width * 0.6593892,
        size.height * 0.1290064,
        size.width * 0.6309940,
        size.height * 0.1271533);
    path_1.arcToPoint(Offset(size.width * 0.6309940, size.height * 0.1482121),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.3538677, size.height * 0.7255612);
    path_2.arcToPoint(Offset(size.width * 0.3595555, size.height * 0.5680411),
        radius:
            Radius.elliptical(size.width * 1.326523, size.height * 1.276966),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.cubicTo(
        size.width * 0.3580679,
        size.height * 0.5158573,
        size.width * 0.3530364,
        size.height * 0.4637999,
        size.width * 0.3493175,
        size.height * 0.4117003);
    path_2.cubicTo(
        size.width * 0.3455985,
        size.height * 0.3596007,
        size.width * 0.3431047,
        size.height * 0.3084277,
        size.width * 0.3466486,
        size.height * 0.2569178);
    path_2.cubicTo(
        size.width * 0.3480487,
        size.height * 0.2358590,
        size.width * 0.3494487,
        size.height * 0.2138314,
        size.width * 0.3570179,
        size.height * 0.1937413);
    path_2.arcToPoint(Offset(size.width * 0.3714561, size.height * 0.1713768),
        radius: Radius.elliptical(
            size.width * 0.06068428, size.height * 0.05841722),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.3972699, size.height * 0.1583625),
        radius: Radius.elliptical(
            size.width * 0.05805915, size.height * 0.05589016),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.4350718, size.height * 0.1524660),
        radius:
            Radius.elliptical(size.width * 0.2511376, size.height * 0.2417555),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.quadraticBezierTo(size.width * 0.4576479, size.height * 0.1500653,
        size.width * 0.4803553, size.height * 0.1485490);
    path_2.quadraticBezierTo(size.width * 0.5267326, size.height * 0.1454323,
        size.width * 0.5733287, size.height * 0.1461062);
    path_2.cubicTo(
        size.width * 0.5874169,
        size.height * 0.1461062,
        size.width * 0.5874169,
        size.height * 0.1250474,
        size.width * 0.5733287,
        size.height * 0.1250474);
    path_2.arcToPoint(Offset(size.width * 0.4068953, size.height * 0.1347766),
        radius:
            Radius.elliptical(size.width * 0.9612356, size.height * 0.9253254),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.cubicTo(
        size.width * 0.3834879,
        size.height * 0.1383987,
        size.width * 0.3617431,
        size.height * 0.1469486,
        size.width * 0.3474361,
        size.height * 0.1659015);
    path_2.cubicTo(
        size.width * 0.3346167,
        size.height * 0.1827486,
        size.width * 0.3302853,
        size.height * 0.2042286,
        size.width * 0.3276601,
        size.height * 0.2245715);
    path_2.cubicTo(
        size.width * 0.3139657,
        size.height * 0.3304132,
        size.width * 0.3315541,
        size.height * 0.4373500,
        size.width * 0.3364106,
        size.height * 0.5431496);
    path_2.arcToPoint(Offset(size.width * 0.3316853, size.height * 0.7255612),
        radius:
            Radius.elliptical(size.width * 1.336411, size.height * 1.286484),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.3535614, size.height * 0.7255612),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3388169, size.height * 0.4067304);
    path_3.cubicTo(
        size.width * 0.3173784,
        size.height * 0.4067304,
        size.width * 0.2959398,
        size.height * 0.4067304,
        size.width * 0.2745012,
        size.height * 0.4067304);
    path_3.cubicTo(
        size.width * 0.2577004,
        size.height * 0.4067304,
        size.width * 0.2401995,
        size.height * 0.4062671,
        size.width * 0.2240112,
        size.height * 0.4112370);
    path_3.cubicTo(
        size.width * 0.2078229,
        size.height * 0.4162069,
        size.width * 0.1944785,
        size.height * 0.4270732,
        size.width * 0.1900158,
        size.height * 0.4433728);
    path_3.arcToPoint(Offset(size.width * 0.1878281, size.height * 0.4712547),
        radius:
            Radius.elliptical(size.width * 0.1107368, size.height * 0.1065998),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.cubicTo(
        size.width * 0.1878281,
        size.height * 0.4819526,
        size.width * 0.1882657,
        size.height * 0.4926505,
        size.width * 0.1886594,
        size.height * 0.5033484);
    path_3.cubicTo(
        size.width * 0.1902783,
        size.height * 0.5450870,
        size.width * 0.1934284,
        size.height * 0.5867835,
        size.width * 0.1935597,
        size.height * 0.6286063);
    path_3.cubicTo(
        size.width * 0.1935597,
        size.height * 0.6492019,
        size.width * 0.1929471,
        size.height * 0.6698816,
        size.width * 0.1909783,
        size.height * 0.6903930);
    path_3.cubicTo(
        size.width * 0.1904533,
        size.height * 0.6955313,
        size.width * 0.1898845,
        size.height * 0.7006697,
        size.width * 0.1892282,
        size.height * 0.7058080);
    path_3.arcToPoint(Offset(size.width * 0.1877406, size.height * 0.7206756),
        radius: Radius.elliptical(
            size.width * 0.07634757, size.height * 0.07349535),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.2040165, size.height * 0.7407236),
        radius: Radius.elliptical(
            size.width * 0.02323241, size.height * 0.02236449),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.cubicTo(
        size.width * 0.2132919,
        size.height * 0.7437982,
        size.width * 0.2235737,
        size.height * 0.7423241,
        size.width * 0.2331554,
        size.height * 0.7420292);
    path_3.cubicTo(
        size.width * 0.2452310,
        size.height * 0.7417344,
        size.width * 0.2573066,
        size.height * 0.7417765,
        size.width * 0.2693822,
        size.height * 0.7420292);
    path_3.cubicTo(
        size.width * 0.2938834,
        size.height * 0.7423662,
        size.width * 0.3183847,
        size.height * 0.7430822,
        size.width * 0.3428421,
        size.height * 0.7420292);
    path_3.cubicTo(
        size.width * 0.3568428,
        size.height * 0.7413553,
        size.width * 0.3569303,
        size.height * 0.7202544,
        size.width * 0.3428421,
        size.height * 0.7209704);
    path_3.cubicTo(
        size.width * 0.3030714,
        size.height * 0.7228657,
        size.width * 0.2633007,
        size.height * 0.7197911,
        size.width * 0.2235299,
        size.height * 0.7215600);
    path_3.arcToPoint(Offset(size.width * 0.2136419, size.height * 0.7215600),
        radius: Radius.elliptical(
            size.width * 0.06217186, size.height * 0.05984922),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.arcToPoint(Offset(size.width * 0.2104480, size.height * 0.7208019),
        radius: Radius.elliptical(
            size.width * 0.02787014, size.height * 0.02682896),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.cubicTo(
        size.width * 0.2109293,
        size.height * 0.7208019,
        size.width * 0.2092667,
        size.height * 0.7196226,
        size.width * 0.2098355,
        size.height * 0.7208019);
    path_3.cubicTo(
        size.width * 0.2087854,
        size.height * 0.7188645,
        size.width * 0.2098355,
        size.height * 0.7151160,
        size.width * 0.2101418,
        size.height * 0.7130102);
    path_3.cubicTo(
        size.width * 0.2109293,
        size.height * 0.7076191,
        size.width * 0.2116293,
        size.height * 0.7022280,
        size.width * 0.2121981,
        size.height * 0.6968791);
    path_3.cubicTo(
        size.width * 0.2142982,
        size.height * 0.6777155,
        size.width * 0.2152170,
        size.height * 0.6584678,
        size.width * 0.2154358,
        size.height * 0.6392200);
    path_3.cubicTo(
        size.width * 0.2157858,
        size.height * 0.6005560,
        size.width * 0.2132044,
        size.height * 0.5619340,
        size.width * 0.2114106,
        size.height * 0.5233121);
    path_3.cubicTo(
        size.width * 0.2104918,
        size.height * 0.5041065,
        size.width * 0.2096605,
        size.height * 0.4848587,
        size.width * 0.2096605,
        size.height * 0.4656530);
    path_3.cubicTo(
        size.width * 0.2096605,
        size.height * 0.4519227,
        size.width * 0.2116731,
        size.height * 0.4393716,
        size.width * 0.2257613,
        size.height * 0.4333067);
    path_3.cubicTo(
        size.width * 0.2398495,
        size.height * 0.4272417,
        size.width * 0.2563878,
        size.height * 0.4280841,
        size.width * 0.2713073,
        size.height * 0.4280841);
    path_3.cubicTo(
        size.width * 0.2937959,
        size.height * 0.4280841,
        size.width * 0.3163283,
        size.height * 0.4280841,
        size.width * 0.3388169,
        size.height * 0.4280841);
    path_3.cubicTo(
        size.width * 0.3529051,
        size.height * 0.4280841,
        size.width * 0.3529051,
        size.height * 0.4070252,
        size.width * 0.3388169,
        size.height * 0.4070252);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.7897270, size.height * 0.4277892);
    path_4.cubicTo(
        size.width * 0.8095905,
        size.height * 0.4277892,
        size.width * 0.8294540,
        size.height * 0.4277892,
        size.width * 0.8492737,
        size.height * 0.4277892);
    path_4.cubicTo(
        size.width * 0.8645432,
        size.height * 0.4277892,
        size.width * 0.8804253,
        size.height * 0.4268627,
        size.width * 0.8953010,
        size.height * 0.4307375);
    path_4.arcToPoint(Offset(size.width * 0.9108330, size.height * 0.4385714),
        radius: Radius.elliptical(
            size.width * 0.03434547, size.height * 0.03306238),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.arcToPoint(Offset(size.width * 0.9180522, size.height * 0.4565135),
        radius: Radius.elliptical(
            size.width * 0.02830767, size.height * 0.02725014),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.arcToPoint(Offset(size.width * 0.9169583, size.height * 0.5136672),
        radius:
            Radius.elliptical(size.width * 0.5375831, size.height * 0.5174999),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.9152520,
        size.height * 0.5530051,
        size.width * 0.9125831,
        size.height * 0.5923009,
        size.width * 0.9125831,
        size.height * 0.6315967);
    path_4.cubicTo(
        size.width * 0.9125831,
        size.height * 0.6511814,
        size.width * 0.9132832,
        size.height * 0.6708082,
        size.width * 0.9152083,
        size.height * 0.6903087);
    path_4.cubicTo(
        size.width * 0.9160833,
        size.height * 0.6994061,
        size.width * 0.9184897,
        size.height * 0.7089247,
        size.width * 0.9184897,
        size.height * 0.7180222);
    path_4.arcToPoint(Offset(size.width * 0.9182272, size.height * 0.7203386),
        radius: Radius.elliptical(
            size.width * 0.009887994, size.height * 0.009518595),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.9187522,
        size.height * 0.7194963,
        size.width * 0.9171334,
        size.height * 0.7206756,
        size.width * 0.9175709,
        size.height * 0.7205492);
    path_4.arcToPoint(Offset(size.width * 0.9088204, size.height * 0.7214337),
        radius: Radius.elliptical(
            size.width * 0.02905145, size.height * 0.02796614),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.8876006,
        size.height * 0.7210546,
        size.width * 0.8665121,
        size.height * 0.7206334,
        size.width * 0.8453360,
        size.height * 0.7209704);
    path_4.cubicTo(
        size.width * 0.8241600,
        size.height * 0.7213073,
        size.width * 0.8015838,
        size.height * 0.7217285,
        size.width * 0.7797077,
        size.height * 0.7206756);
    path_4.cubicTo(
        size.width * 0.7656195,
        size.height * 0.7199596,
        size.width * 0.7656633,
        size.height * 0.7410184,
        size.width * 0.7797077,
        size.height * 0.7417344);
    path_4.cubicTo(
        size.width * 0.8213161,
        size.height * 0.7437139,
        size.width * 0.8628369,
        size.height * 0.7404709,
        size.width * 0.9046640,
        size.height * 0.7423241);
    path_4.arcToPoint(Offset(size.width * 0.9289464, size.height * 0.7385335),
        radius: Radius.elliptical(
            size.width * 0.04449597, size.height * 0.04283368),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.9400158, size.height * 0.7145685),
        radius: Radius.elliptical(
            size.width * 0.02410746, size.height * 0.02320684),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.9374781,
        size.height * 0.6935097,
        size.width * 0.9352468,
        size.height * 0.6724508,
        size.width * 0.9346780,
        size.height * 0.6513920);
    path_4.cubicTo(
        size.width * 0.9335404,
        size.height * 0.6089374,
        size.width * 0.9363843,
        size.height * 0.5665249,
        size.width * 0.9384407,
        size.height * 0.5241124);
    path_4.cubicTo(
        size.width * 0.9394032,
        size.height * 0.5030535,
        size.width * 0.9406720,
        size.height * 0.4819947,
        size.width * 0.9401908,
        size.height * 0.4609359);
    path_4.cubicTo(
        size.width * 0.9397095,
        size.height * 0.4429937,
        size.width * 0.9336717,
        size.height * 0.4263151,
        size.width * 0.9170021,
        size.height * 0.4167544);
    path_4.cubicTo(
        size.width * 0.9010326,
        size.height * 0.4075306,
        size.width * 0.8812128,
        size.height * 0.4067725,
        size.width * 0.8631432,
        size.height * 0.4067304);
    path_4.cubicTo(
        size.width * 0.8386857,
        size.height * 0.4067304,
        size.width * 0.8142282,
        size.height * 0.4067304,
        size.width * 0.7897707,
        size.height * 0.4067304);
    path_4.cubicTo(
        size.width * 0.7756825,
        size.height * 0.4067304,
        size.width * 0.7756825,
        size.height * 0.4277892,
        size.width * 0.7897707,
        size.height * 0.4277892);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4163021, size.height * 0.2764183);
    path_5.cubicTo(
        size.width * 0.4145957,
        size.height * 0.2994146,
        size.width * 0.4146395,
        size.height * 0.3238428,
        size.width * 0.4315278,
        size.height * 0.3420798);
    path_5.cubicTo(
        size.width * 0.4490287,
        size.height * 0.3610327,
        size.width * 0.4769863,
        size.height * 0.3564840,
        size.width * 0.5006563,
        size.height * 0.3559786);
    path_5.cubicTo(
        size.width * 0.5126881,
        size.height * 0.3557259,
        size.width * 0.5285702,
        size.height * 0.3580845,
        size.width * 0.5356580,
        size.height * 0.3461231);
    path_5.arcToPoint(Offset(size.width * 0.5400333, size.height * 0.3292760),
        radius: Radius.elliptical(
            size.width * 0.04983374, size.height * 0.04797203),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.5418271, size.height * 0.3093122),
        radius:
            Radius.elliptical(size.width * 0.1833654, size.height * 0.1765152),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.5422646,
        size.height * 0.2902329,
        size.width * 0.5416083,
        size.height * 0.2548962,
        size.width * 0.5134319,
        size.height * 0.2556964);
    path_5.cubicTo(
        size.width * 0.5063878,
        size.height * 0.2559070,
        size.width * 0.4992562,
        size.height * 0.2577181,
        size.width * 0.4922121,
        size.height * 0.2584762);
    path_5.cubicTo(
        size.width * 0.4851680,
        size.height * 0.2592343,
        size.width * 0.4776426,
        size.height * 0.2598661,
        size.width * 0.4703360,
        size.height * 0.2602451);
    path_5.arcToPoint(Offset(size.width * 0.4265838, size.height * 0.2596134),
        radius:
            Radius.elliptical(size.width * 0.3582867, size.height * 0.3449017),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.arcToPoint(Offset(size.width * 0.4156458, size.height * 0.2701428),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.4265838, size.height * 0.2806722),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.4900245, size.height * 0.2799562),
        radius:
            Radius.elliptical(size.width * 0.3456423, size.height * 0.3327296),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4956248,
        size.height * 0.2793666,
        size.width * 0.5011813,
        size.height * 0.2786505,
        size.width * 0.5067816,
        size.height * 0.2778503);
    path_5.cubicTo(
        size.width * 0.5087942,
        size.height * 0.2775555,
        size.width * 0.5108505,
        size.height * 0.2770922,
        size.width * 0.5128631,
        size.height * 0.2769658);
    path_5.cubicTo(
        size.width * 0.5148757,
        size.height * 0.2768395,
        size.width * 0.5159258,
        size.height * 0.2775976,
        size.width * 0.5150945,
        size.height * 0.2769658);
    path_5.cubicTo(
        size.width * 0.5190322,
        size.height * 0.2797035,
        size.width * 0.5190760,
        size.height * 0.2909910,
        size.width * 0.5194697,
        size.height * 0.2960873);
    path_5.arcToPoint(Offset(size.width * 0.5185072, size.height * 0.3255696),
        radius:
            Radius.elliptical(size.width * 0.1543140, size.height * 0.1485490),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.5181134,
        size.height * 0.3280967,
        size.width * 0.5176759,
        size.height * 0.3306238,
        size.width * 0.5171509,
        size.height * 0.3331087);
    path_5.cubicTo(
        size.width * 0.5171509,
        size.height * 0.3340353,
        size.width * 0.5154883,
        size.height * 0.3370678,
        size.width * 0.5174134,
        size.height * 0.3350882);
    path_5.cubicTo(
        size.width * 0.5193385,
        size.height * 0.3331087,
        size.width * 0.5184197,
        size.height * 0.3347513,
        size.width * 0.5174134,
        size.height * 0.3343722);
    path_5.cubicTo(
        size.width * 0.5164071,
        size.height * 0.3339932,
        size.width * 0.5147445,
        size.height * 0.3343722,
        size.width * 0.5136507,
        size.height * 0.3343722);
    path_5.lineTo(size.width * 0.5049002, size.height * 0.3343722);
    path_5.cubicTo(
        size.width * 0.4943560,
        size.height * 0.3346249,
        size.width * 0.4837679,
        size.height * 0.3349198,
        size.width * 0.4732237,
        size.height * 0.3350882);
    path_5.cubicTo(
        size.width * 0.4651295,
        size.height * 0.3350882,
        size.width * 0.4569041,
        size.height * 0.3350882,
        size.width * 0.4504725,
        size.height * 0.3297814);
    path_5.cubicTo(
        size.width * 0.4347655,
        size.height * 0.3167249,
        size.width * 0.4373469,
        size.height * 0.2937287,
        size.width * 0.4384844,
        size.height * 0.2759550);
    path_5.arcToPoint(Offset(size.width * 0.4275464, size.height * 0.2654256),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.4166083, size.height * 0.2759550),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.5874169, size.height * 0.2764183);
    path_6.cubicTo(
        size.width * 0.5856668,
        size.height * 0.2994146,
        size.width * 0.5857105,
        size.height * 0.3238428,
        size.width * 0.6026426,
        size.height * 0.3420798);
    path_6.cubicTo(
        size.width * 0.6201435,
        size.height * 0.3610327,
        size.width * 0.6480574,
        size.height * 0.3564840,
        size.width * 0.6717273,
        size.height * 0.3559786);
    path_6.cubicTo(
        size.width * 0.6838029,
        size.height * 0.3557259,
        size.width * 0.6996850,
        size.height * 0.3580845,
        size.width * 0.7067291,
        size.height * 0.3461231);
    path_6.arcToPoint(Offset(size.width * 0.7111043, size.height * 0.3292760),
        radius: Radius.elliptical(
            size.width * 0.05084004, size.height * 0.04894074),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.7128544, size.height * 0.3093122),
        radius:
            Radius.elliptical(size.width * 0.1832779, size.height * 0.1764309),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.cubicTo(
        size.width * 0.7132919,
        size.height * 0.2902329,
        size.width * 0.7128544,
        size.height * 0.2548962,
        size.width * 0.6845030,
        size.height * 0.2556964);
    path_6.cubicTo(
        size.width * 0.6774151,
        size.height * 0.2559070,
        size.width * 0.6702835,
        size.height * 0.2577181,
        size.width * 0.6632832,
        size.height * 0.2584762);
    path_6.cubicTo(
        size.width * 0.6562828,
        size.height * 0.2592343,
        size.width * 0.6486699,
        size.height * 0.2598661,
        size.width * 0.6414071,
        size.height * 0.2602451);
    path_6.arcToPoint(Offset(size.width * 0.5976549, size.height * 0.2596134),
        radius:
            Radius.elliptical(size.width * 0.3587679, size.height * 0.3453649),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_6.arcToPoint(Offset(size.width * 0.5867168, size.height * 0.2701428),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.5976549, size.height * 0.2806722),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.6614893, size.height * 0.2797456),
        radius:
            Radius.elliptical(size.width * 0.3456423, size.height * 0.3327296),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.cubicTo(
        size.width * 0.6670896,
        size.height * 0.2791560,
        size.width * 0.6726899,
        size.height * 0.2784400,
        size.width * 0.6782902,
        size.height * 0.2776397);
    path_6.cubicTo(
        size.width * 0.6803028,
        size.height * 0.2773449,
        size.width * 0.6823154,
        size.height * 0.2768816,
        size.width * 0.6843717,
        size.height * 0.2767553);
    path_6.cubicTo(
        size.width * 0.6857280,
        size.height * 0.2767553,
        size.width * 0.6873906,
        size.height * 0.2773870,
        size.width * 0.6865593,
        size.height * 0.2767553);
    path_6.cubicTo(
        size.width * 0.6905408,
        size.height * 0.2794929,
        size.width * 0.6905845,
        size.height * 0.2907804,
        size.width * 0.6909345,
        size.height * 0.2958767);
    path_6.arcToPoint(Offset(size.width * 0.6899282, size.height * 0.3253591),
        radius:
            Radius.elliptical(size.width * 0.1543140, size.height * 0.1485490),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_6.cubicTo(
        size.width * 0.6895782,
        size.height * 0.3278861,
        size.width * 0.6891407,
        size.height * 0.3304132,
        size.width * 0.6885719,
        size.height * 0.3328981);
    path_6.cubicTo(
        size.width * 0.6885719,
        size.height * 0.3338247,
        size.width * 0.6869093,
        size.height * 0.3368572,
        size.width * 0.6888782,
        size.height * 0.3348776);
    path_6.cubicTo(
        size.width * 0.6908470,
        size.height * 0.3328981,
        size.width * 0.6898407,
        size.height * 0.3345407,
        size.width * 0.6888782,
        size.height * 0.3341616);
    path_6.cubicTo(
        size.width * 0.6879156,
        size.height * 0.3337826,
        size.width * 0.6861656,
        size.height * 0.3341616,
        size.width * 0.6851155,
        size.height * 0.3341616);
    path_6.lineTo(size.width * 0.6763651, size.height * 0.3341616);
    path_6.cubicTo(
        size.width * 0.6657770,
        size.height * 0.3344144,
        size.width * 0.6552328,
        size.height * 0.3347092,
        size.width * 0.6446885,
        size.height * 0.3348776);
    path_6.cubicTo(
        size.width * 0.6365506,
        size.height * 0.3348776,
        size.width * 0.6283689,
        size.height * 0.3348776,
        size.width * 0.6219373,
        size.height * 0.3295708);
    path_6.cubicTo(
        size.width * 0.6061866,
        size.height * 0.3165143,
        size.width * 0.6085929,
        size.height * 0.2935181,
        size.width * 0.6099492,
        size.height * 0.2757444);
    path_6.arcToPoint(Offset(size.width * 0.5880732, size.height * 0.2757444),
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
    path_7.moveTo(size.width * 0.4142895, size.height * 0.4255991);
    path_7.cubicTo(
        size.width * 0.4125831,
        size.height * 0.4486375,
        size.width * 0.4126269,
        size.height * 0.4730236,
        size.width * 0.4295152,
        size.height * 0.4912606);
    path_7.cubicTo(
        size.width * 0.4470161,
        size.height * 0.5102557,
        size.width * 0.4749737,
        size.height * 0.5057069,
        size.width * 0.4986437,
        size.height * 0.5052015);
    path_7.cubicTo(
        size.width * 0.5106755,
        size.height * 0.5049488,
        size.width * 0.5265576,
        size.height * 0.5072653,
        size.width * 0.5336454,
        size.height * 0.4953039);
    path_7.arcToPoint(Offset(size.width * 0.5380207, size.height * 0.4786674),
        radius: Radius.elliptical(
            size.width * 0.04983374, size.height * 0.04797203),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.5398145, size.height * 0.4587036),
        radius:
            Radius.elliptical(size.width * 0.1824904, size.height * 0.1756728),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.5402520,
        size.height * 0.4396664,
        size.width * 0.5398145,
        size.height * 0.4042876,
        size.width * 0.5114193,
        size.height * 0.4051299);
    path_7.cubicTo(
        size.width * 0.5043752,
        size.height * 0.4051299,
        size.width * 0.4972436,
        size.height * 0.4071095,
        size.width * 0.4901995,
        size.height * 0.4079097);
    path_7.cubicTo(
        size.width * 0.4831554,
        size.height * 0.4087099,
        size.width * 0.4756300,
        size.height * 0.4092996,
        size.width * 0.4683234,
        size.height * 0.4096365);
    path_7.arcToPoint(Offset(size.width * 0.4245712, size.height * 0.4090048),
        radius:
            Radius.elliptical(size.width * 0.3416608, size.height * 0.3288969),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.arcToPoint(Offset(size.width * 0.4245712, size.height * 0.4300636),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.4883619, size.height * 0.4291791),
        radius:
            Radius.elliptical(size.width * 0.3412671, size.height * 0.3285179),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.cubicTo(
        size.width * 0.4940060,
        size.height * 0.4285895,
        size.width * 0.4995625,
        size.height * 0.4278735,
        size.width * 0.5051628,
        size.height * 0.4270732);
    path_7.cubicTo(
        size.width * 0.5071754,
        size.height * 0.4267784,
        size.width * 0.5092317,
        size.height * 0.4263151,
        size.width * 0.5112443,
        size.height * 0.4261888);
    path_7.cubicTo(
        size.width * 0.5126006,
        size.height * 0.4261888,
        size.width * 0.5143070,
        size.height * 0.4267784,
        size.width * 0.5134757,
        size.height * 0.4261888);
    path_7.cubicTo(
        size.width * 0.5174134,
        size.height * 0.4288843,
        size.width * 0.5174571,
        size.height * 0.4402140,
        size.width * 0.5178509,
        size.height * 0.4452681);
    path_7.arcToPoint(Offset(size.width * 0.5168883, size.height * 0.4747505),
        radius:
            Radius.elliptical(size.width * 0.1575079, size.height * 0.1516236),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_7.cubicTo(
        size.width * 0.5164946,
        size.height * 0.4772775,
        size.width * 0.5160571,
        size.height * 0.4798467,
        size.width * 0.5155320,
        size.height * 0.4823316);
    path_7.cubicTo(
        size.width * 0.5155320,
        size.height * 0.4832582,
        size.width * 0.5138694,
        size.height * 0.4862907,
        size.width * 0.5157945,
        size.height * 0.4843112);
    path_7.cubicTo(
        size.width * 0.5177196,
        size.height * 0.4823316,
        size.width * 0.5168008,
        size.height * 0.4839742,
        size.width * 0.5157945,
        size.height * 0.4835530);
    path_7.cubicTo(
        size.width * 0.5147882,
        size.height * 0.4831319,
        size.width * 0.5131257,
        size.height * 0.4835530,
        size.width * 0.5120319,
        size.height * 0.4835530);
    path_7.lineTo(size.width * 0.5032814, size.height * 0.4837636);
    path_7.cubicTo(
        size.width * 0.4927371,
        size.height * 0.4837636,
        size.width * 0.4821491,
        size.height * 0.4842690,
        size.width * 0.4716048,
        size.height * 0.4844375);
    path_7.cubicTo(
        size.width * 0.4635107,
        size.height * 0.4844375,
        size.width * 0.4552853,
        size.height * 0.4844375,
        size.width * 0.4488537,
        size.height * 0.4791307);
    path_7.cubicTo(
        size.width * 0.4331467,
        size.height * 0.4661163,
        size.width * 0.4357280,
        size.height * 0.4431201,
        size.width * 0.4368656,
        size.height * 0.4253043);
    path_7.arcToPoint(Offset(size.width * 0.4259275, size.height * 0.4147749),
        radius: Radius.elliptical(
            size.width * 0.01106930, size.height * 0.01065577),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_7.arcToPoint(Offset(size.width * 0.4149895, size.height * 0.4253043),
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
    path_8.moveTo(size.width * 0.5853605, size.height * 0.4255991);
    path_8.cubicTo(
        size.width * 0.5836542,
        size.height * 0.4486375,
        size.width * 0.5836979,
        size.height * 0.4730236,
        size.width * 0.6006300,
        size.height * 0.4912606);
    path_8.cubicTo(
        size.width * 0.6181309,
        size.height * 0.5102557,
        size.width * 0.6460448,
        size.height * 0.5057069,
        size.width * 0.6697147,
        size.height * 0.5052015);
    path_8.cubicTo(
        size.width * 0.6817903,
        size.height * 0.5049488,
        size.width * 0.6976724,
        size.height * 0.5072653,
        size.width * 0.7047165,
        size.height * 0.4953039);
    path_8.arcToPoint(Offset(size.width * 0.7090917, size.height * 0.4786674),
        radius: Radius.elliptical(
            size.width * 0.05084004, size.height * 0.04894074),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.7108418, size.height * 0.4587036),
        radius:
            Radius.elliptical(size.width * 0.1824466, size.height * 0.1756307),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.cubicTo(
        size.width * 0.7112793,
        size.height * 0.4396664,
        size.width * 0.7108418,
        size.height * 0.4042876,
        size.width * 0.6824904,
        size.height * 0.4051299);
    path_8.cubicTo(
        size.width * 0.6754025,
        size.height * 0.4051299,
        size.width * 0.6682709,
        size.height * 0.4071095,
        size.width * 0.6612706,
        size.height * 0.4079097);
    path_8.cubicTo(
        size.width * 0.6542702,
        size.height * 0.4087099,
        size.width * 0.6466573,
        size.height * 0.4092996,
        size.width * 0.6393945,
        size.height * 0.4096365);
    path_8.arcToPoint(Offset(size.width * 0.5956423, size.height * 0.4090048),
        radius:
            Radius.elliptical(size.width * 0.3422296, size.height * 0.3294445),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_8.arcToPoint(Offset(size.width * 0.5956423, size.height * 0.4300636),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.6594767, size.height * 0.4291791),
        radius:
            Radius.elliptical(size.width * 0.3418796, size.height * 0.3291075),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.cubicTo(
        size.width * 0.6650770,
        size.height * 0.4285895,
        size.width * 0.6706773,
        size.height * 0.4278735,
        size.width * 0.6762776,
        size.height * 0.4270732);
    path_8.cubicTo(
        size.width * 0.6782902,
        size.height * 0.4267784,
        size.width * 0.6803028,
        size.height * 0.4263151,
        size.width * 0.6823591,
        size.height * 0.4261888);
    path_8.cubicTo(
        size.width * 0.6837154,
        size.height * 0.4261888,
        size.width * 0.6853780,
        size.height * 0.4267784,
        size.width * 0.6845467,
        size.height * 0.4261888);
    path_8.cubicTo(
        size.width * 0.6885282,
        size.height * 0.4288843,
        size.width * 0.6885719,
        size.height * 0.4402140,
        size.width * 0.6889219,
        size.height * 0.4452681);
    path_8.arcToPoint(Offset(size.width * 0.6879156, size.height * 0.4747505),
        radius:
            Radius.elliptical(size.width * 0.1542265, size.height * 0.1484648),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_8.cubicTo(
        size.width * 0.6875656,
        size.height * 0.4772775,
        size.width * 0.6871281,
        size.height * 0.4798467,
        size.width * 0.6865593,
        size.height * 0.4823316);
    path_8.cubicTo(
        size.width * 0.6865593,
        size.height * 0.4832582,
        size.width * 0.6848967,
        size.height * 0.4862907,
        size.width * 0.6868656,
        size.height * 0.4843112);
    path_8.cubicTo(
        size.width * 0.6888344,
        size.height * 0.4823316,
        size.width * 0.6878281,
        size.height * 0.4839742,
        size.width * 0.6868656,
        size.height * 0.4835530);
    path_8.cubicTo(
        size.width * 0.6859030,
        size.height * 0.4831319,
        size.width * 0.6841530,
        size.height * 0.4835530,
        size.width * 0.6831029,
        size.height * 0.4835530);
    path_8.lineTo(size.width * 0.6743525, size.height * 0.4837636);
    path_8.cubicTo(
        size.width * 0.6637644,
        size.height * 0.4837636,
        size.width * 0.6532202,
        size.height * 0.4842690,
        size.width * 0.6426321,
        size.height * 0.4844375);
    path_8.cubicTo(
        size.width * 0.6345380,
        size.height * 0.4844375,
        size.width * 0.6263563,
        size.height * 0.4844375,
        size.width * 0.6199247,
        size.height * 0.4791307);
    path_8.cubicTo(
        size.width * 0.6041740,
        size.height * 0.4661163,
        size.width * 0.6067991,
        size.height * 0.4431201,
        size.width * 0.6078929,
        size.height * 0.4253043);
    path_8.arcToPoint(Offset(size.width * 0.5969548, size.height * 0.4147749),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.arcToPoint(Offset(size.width * 0.5860168, size.height * 0.4253043),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.2557315, size.height * 0.7251400);
    path_9.quadraticBezierTo(size.width * 0.2547252, size.height * 0.6899718,
        size.width * 0.2544627, size.height * 0.6547193);
    path_9.cubicTo(
        size.width * 0.2544627,
        size.height * 0.6428000,
        size.width * 0.2544627,
        size.height * 0.6309228,
        size.width * 0.2544627,
        size.height * 0.6190035);
    path_9.cubicTo(
        size.width * 0.2544627,
        size.height * 0.6098640,
        size.width * 0.2529314,
        size.height * 0.5990397,
        size.width * 0.2556878,
        size.height * 0.5901529);
    path_9.cubicTo(
        size.width * 0.2581379,
        size.height * 0.5821505,
        size.width * 0.2688134,
        size.height * 0.5820663,
        size.width * 0.2764263,
        size.height * 0.5817294);
    path_9.arcToPoint(Offset(size.width * 0.2918708, size.height * 0.5826138),
        radius: Radius.elliptical(
            size.width * 0.07000350, size.height * 0.06738828),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_9.arcToPoint(Offset(size.width * 0.2992212, size.height * 0.5843406),
        radius: Radius.elliptical(
            size.width * 0.03145782, size.height * 0.03028261),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.cubicTo(
        size.width * 0.2989587,
        size.height * 0.5843406,
        size.width * 0.2970774,
        size.height * 0.5820242,
        size.width * 0.2965086,
        size.height * 0.5823190);
    path_9.arcToPoint(Offset(size.width * 0.2965086, size.height * 0.5870783),
        radius: Radius.elliptical(
            size.width * 0.01907595, size.height * 0.01836331),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.cubicTo(
        size.width * 0.2973836,
        size.height * 0.6089795,
        size.width * 0.2981274,
        size.height * 0.6309228,
        size.width * 0.2988712,
        size.height * 0.6528240);
    path_9.cubicTo(
        size.width * 0.2996587,
        size.height * 0.6776313,
        size.width * 0.3004900,
        size.height * 0.7024386,
        size.width * 0.3015401,
        size.height * 0.7272880);
    path_9.cubicTo(
        size.width * 0.3021089,
        size.height * 0.7407657,
        size.width * 0.3239849,
        size.height * 0.7408499,
        size.width * 0.3234162,
        size.height * 0.7272880);
    path_9.cubicTo(
        size.width * 0.3223224,
        size.height * 0.7020174,
        size.width * 0.3215348,
        size.height * 0.6769574,
        size.width * 0.3207035,
        size.height * 0.6518132);
    path_9.cubicTo(
        size.width * 0.3202660,
        size.height * 0.6391779,
        size.width * 0.3198722,
        size.height * 0.6265426,
        size.width * 0.3193910,
        size.height * 0.6142021);
    path_9.cubicTo(
        size.width * 0.3193910,
        size.height * 0.6083477,
        size.width * 0.3189972,
        size.height * 0.6025355,
        size.width * 0.3187347,
        size.height * 0.5966811);
    path_9.arcToPoint(Offset(size.width * 0.3175534, size.height * 0.5770964),
        radius:
            Radius.elliptical(size.width * 0.1212811, size.height * 0.1167502),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_9.cubicTo(
        size.width * 0.3145782,
        size.height * 0.5631976,
        size.width * 0.2975586,
        size.height * 0.5616813,
        size.width * 0.2853955,
        size.height * 0.5608390);
    path_9.cubicTo(
        size.width * 0.2732324,
        size.height * 0.5599966,
        size.width * 0.2577004,
        size.height * 0.5608390,
        size.width * 0.2469373,
        size.height * 0.5673251);
    path_9.cubicTo(
        size.width * 0.2361743,
        size.height * 0.5738112,
        size.width * 0.2332429,
        size.height * 0.5852672,
        size.width * 0.2326304,
        size.height * 0.5964705);
    path_9.cubicTo(
        size.width * 0.2319303,
        size.height * 0.6091058,
        size.width * 0.2323241,
        size.height * 0.6219939,
        size.width * 0.2323241,
        size.height * 0.6347134);
    path_9.quadraticBezierTo(size.width * 0.2323241, size.height * 0.6798635,
        size.width * 0.2336804, size.height * 0.7250979);
    path_9.cubicTo(
        size.width * 0.2340742,
        size.height * 0.7386177,
        size.width * 0.2559503,
        size.height * 0.7386598,
        size.width * 0.2555565,
        size.height * 0.7250979);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.8334354, size.height * 0.7270775);
    path_10.quadraticBezierTo(size.width * 0.8324291, size.height * 0.6933833,
        size.width * 0.8322104, size.height * 0.6596892);
    path_10.quadraticBezierTo(size.width * 0.8322104, size.height * 0.6428421,
        size.width * 0.8322104, size.height * 0.6259950);
    path_10.arcToPoint(Offset(size.width * 0.8327354, size.height * 0.5949964),
        radius:
            Radius.elliptical(size.width * 0.2395432, size.height * 0.2305943),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_10.arcToPoint(Offset(size.width * 0.8356668, size.height * 0.5875837),
        radius: Radius.elliptical(
            size.width * 0.01347567, size.height * 0.01297224),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_10.arcToPoint(Offset(size.width * 0.8475236, size.height * 0.5840458),
        radius: Radius.elliptical(
            size.width * 0.02270739, size.height * 0.02185907),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_10.arcToPoint(Offset(size.width * 0.8623556, size.height * 0.5835825),
        radius: Radius.elliptical(
            size.width * 0.07306615, size.height * 0.07033652),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_10.arcToPoint(Offset(size.width * 0.8696185, size.height * 0.5843828),
        radius: Radius.elliptical(
            size.width * 0.05766538, size.height * 0.05551110),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_10.lineTo(size.width * 0.8735999, size.height * 0.5852251);
    path_10.cubicTo(
        size.width * 0.8748687,
        size.height * 0.5855199,
        size.width * 0.8787189,
        size.height * 0.5873731,
        size.width * 0.8756563,
        size.height * 0.5848882);
    path_10.cubicTo(
        size.width * 0.8725936,
        size.height * 0.5824032,
        size.width * 0.8747812,
        size.height * 0.5837089,
        size.width * 0.8743000,
        size.height * 0.5851409);
    path_10.arcToPoint(Offset(size.width * 0.8743000, size.height * 0.5882997),
        radius: Radius.elliptical(
            size.width * 0.01185684, size.height * 0.01141389),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.lineTo(size.width * 0.8746937, size.height * 0.5967232);
    path_10.lineTo(size.width * 0.8754375, size.height * 0.6145390);
    path_10.lineTo(size.width * 0.8768813, size.height * 0.6479805);
    path_10.lineTo(size.width * 0.8801628, size.height * 0.7243398);
    path_10.cubicTo(
        size.width * 0.8807315,
        size.height * 0.7378596,
        size.width * 0.9026076,
        size.height * 0.7379438,
        size.width * 0.9020389,
        size.height * 0.7243398);
    path_10.lineTo(size.width * 0.8987137, size.height * 0.6469696);
    path_10.lineTo(size.width * 0.8970511, size.height * 0.6082635);
    path_10.lineTo(size.width * 0.8962636, size.height * 0.5904477);
    path_10.cubicTo(
        size.width * 0.8960011,
        size.height * 0.5835825,
        size.width * 0.8962636,
        size.height * 0.5760435,
        size.width * 0.8911008,
        size.height * 0.5706524);
    path_10.arcToPoint(Offset(size.width * 0.8763563, size.height * 0.5643769),
        radius: Radius.elliptical(
            size.width * 0.02664508, size.height * 0.02564967),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.arcToPoint(Offset(size.width * 0.8561428, size.height * 0.5624816),
        radius: Radius.elliptical(
            size.width * 0.09831117, size.height * 0.09463842),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_10.cubicTo(
        size.width * 0.8442860,
        size.height * 0.5624816,
        size.width * 0.8298915,
        size.height * 0.5641663,
        size.width * 0.8206598,
        size.height * 0.5722950);
    path_10.cubicTo(
        size.width * 0.8123469,
        size.height * 0.5797498,
        size.width * 0.8106405,
        size.height * 0.5910374,
        size.width * 0.8104218,
        size.height * 0.6014404);
    path_10.cubicTo(
        size.width * 0.8101155,
        size.height * 0.6138230,
        size.width * 0.8104218,
        size.height * 0.6262477,
        size.width * 0.8104218,
        size.height * 0.6386725);
    path_10.quadraticBezierTo(size.width * 0.8104218, size.height * 0.6828539,
        size.width * 0.8117781, size.height * 0.7271196);
    path_10.cubicTo(
        size.width * 0.8121719,
        size.height * 0.7406393,
        size.width * 0.8340480,
        size.height * 0.7406815,
        size.width * 0.8336542,
        size.height * 0.7271196);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.5072629, size.height * 0.7338163);
    path_11.quadraticBezierTo(size.width * 0.5045940, size.height * 0.6839068,
        size.width * 0.5035439, size.height * 0.6340395);
    path_11.cubicTo(
        size.width * 0.5032377,
        size.height * 0.6175294,
        size.width * 0.5029314,
        size.height * 0.6010614,
        size.width * 0.5029751,
        size.height * 0.5845934);
    path_11.cubicTo(
        size.width * 0.5029751,
        size.height * 0.5746536,
        size.width * 0.5029751,
        size.height * 0.5622710,
        size.width * 0.5127319,
        size.height * 0.5563745);
    path_11.cubicTo(
        size.width * 0.5224886,
        size.height * 0.5504780,
        size.width * 0.5374956,
        size.height * 0.5516573,
        size.width * 0.5490025,
        size.height * 0.5516994);
    path_11.cubicTo(
        size.width * 0.5659783,
        size.height * 0.5516994,
        size.width * 0.5829541,
        size.height * 0.5521627,
        size.width * 0.5998862,
        size.height * 0.5529209);
    path_11.cubicTo(
        size.width * 0.6036927,
        size.height * 0.5529209,
        size.width * 0.6117431,
        size.height * 0.5521627,
        size.width * 0.6148057,
        size.height * 0.5551531);
    path_11.cubicTo(
        size.width * 0.6178684,
        size.height * 0.5581435,
        size.width * 0.6172121,
        size.height * 0.5687992,
        size.width * 0.6174309,
        size.height * 0.5730110);
    path_11.quadraticBezierTo(size.width * 0.6187872, size.height * 0.5970181,
        size.width * 0.6192685, size.height * 0.6209830);
    path_11.quadraticBezierTo(size.width * 0.6204498, size.height * 0.6773365,
        size.width * 0.6168621, size.height * 0.7336478);
    path_11.cubicTo(
        size.width * 0.6160308,
        size.height * 0.7472097,
        size.width * 0.6379069,
        size.height * 0.7471255,
        size.width * 0.6387382,
        size.height * 0.7336478);
    path_11.quadraticBezierTo(size.width * 0.6421509, size.height * 0.6788948,
        size.width * 0.6412321, size.height * 0.6241419);
    path_11.quadraticBezierTo(size.width * 0.6407070, size.height * 0.5969760,
        size.width * 0.6391320, size.height * 0.5698943);
    path_11.arcToPoint(Offset(size.width * 0.6347567, size.height * 0.5466874),
        radius: Radius.elliptical(
            size.width * 0.06357193, size.height * 0.06119698),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.arcToPoint(Offset(size.width * 0.6162933, size.height * 0.5332519),
        radius: Radius.elliptical(
            size.width * 0.02581379, size.height * 0.02484943),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.arcToPoint(Offset(size.width * 0.5902608, size.height * 0.5314830),
        radius:
            Radius.elliptical(size.width * 0.1782902, size.height * 0.1716295),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.quadraticBezierTo(size.width * 0.5764788, size.height * 0.5309776,
        size.width * 0.5626969, size.height * 0.5307670);
    path_11.cubicTo(
        size.width * 0.5467273,
        size.height * 0.5305143,
        size.width * 0.5295765,
        size.height * 0.5292507,
        size.width * 0.5140007,
        size.height * 0.5332940);
    path_11.arcToPoint(Offset(size.width * 0.4833742, size.height * 0.5625658),
        radius: Radius.elliptical(
            size.width * 0.04182709, size.height * 0.04026450),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_11.cubicTo(
        size.width * 0.4792615,
        size.height * 0.5780651,
        size.width * 0.4811428,
        size.height * 0.5953334,
        size.width * 0.4813616,
        size.height * 0.6111275);
    path_11.quadraticBezierTo(size.width * 0.4821054, size.height * 0.6725351,
        size.width * 0.4854305, size.height * 0.7338163);
    path_11.cubicTo(
        size.width * 0.4861743,
        size.height * 0.7472939,
        size.width * 0.5080504,
        size.height * 0.7473782,
        size.width * 0.5073066,
        size.height * 0.7338163);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.5105880, size.height * 0.1768942);
    path_12.cubicTo(
        size.width * 0.5481712,
        size.height * 0.1726825,
        size.width * 0.5849667,
        size.height * 0.1527187,
        size.width * 0.5957298,
        size.height * 0.1156973);
    path_12.arcToPoint(Offset(size.width * 0.5898232, size.height * 0.06612475),
        radius: Radius.elliptical(
            size.width * 0.06654708, size.height * 0.06406099),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_12.arcToPoint(Offset(size.width * 0.5491337, size.height * 0.03790591),
        radius: Radius.elliptical(
            size.width * 0.05980924, size.height * 0.05757486),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_12.lineTo(size.width * 0.5491337, size.height * 0.05820663);
    path_12.cubicTo(
        size.width * 0.5642282,
        size.height * 0.05580592,
        size.width * 0.5812478,
        size.height * 0.05584804,
        size.width * 0.5954673,
        size.height * 0.06191298);
    path_12.cubicTo(
        size.width * 0.6110868,
        size.height * 0.06860970,
        size.width * 0.6198810,
        size.height * 0.08200312,
        size.width * 0.6230749,
        size.height * 0.09783936);
    path_12.cubicTo(
        size.width * 0.6262688,
        size.height * 0.1136756,
        size.width * 0.6242562,
        size.height * 0.1331340,
        size.width * 0.6143245,
        size.height * 0.1464853);
    path_12.cubicTo(
        size.width * 0.6043927,
        size.height * 0.1598366,
        size.width * 0.5866731,
        size.height * 0.1671651,
        size.width * 0.5705723,
        size.height * 0.1703660);
    path_12.arcToPoint(Offset(size.width * 0.5127756, size.height * 0.1628269),
        radius: Radius.elliptical(
            size.width * 0.08833567, size.height * 0.08503559),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_12.lineTo(size.width * 0.5166696, size.height * 0.1772312);
    path_12.lineTo(size.width * 0.5201260, size.height * 0.1717138);
    path_12.cubicTo(
        size.width * 0.5273889,
        size.height * 0.1600893,
        size.width * 0.5084879,
        size.height * 0.1494756,
        size.width * 0.5012251,
        size.height * 0.1611001);
    path_12.lineTo(size.width * 0.4978124, size.height * 0.1666175);
    path_12.arcToPoint(Offset(size.width * 0.5017063, size.height * 0.1810218),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_12.arcToPoint(Offset(size.width * 0.5685597, size.height * 0.1919303),
        radius:
            Radius.elliptical(size.width * 0.1122681, size.height * 0.1080740),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_12.cubicTo(
        size.width * 0.5902170,
        size.height * 0.1890663,
        size.width * 0.6130557,
        size.height * 0.1799688,
        size.width * 0.6277564,
        size.height * 0.1639220);
    path_12.cubicTo(
        size.width * 0.6432884,
        size.height * 0.1470749,
        size.width * 0.6482762,
        size.height * 0.1226888,
        size.width * 0.6456073,
        size.height * 0.1007455);
    path_12.cubicTo(
        size.width * 0.6429384,
        size.height * 0.07880217,
        size.width * 0.6329629,
        size.height * 0.05930169,
        size.width * 0.6135807,
        size.height * 0.04742450);
    path_12.cubicTo(
        size.width * 0.5928421,
        size.height * 0.03478920,
        size.width * 0.5668533,
        size.height * 0.03424167,
        size.width * 0.5435772,
        size.height * 0.03794803);
    path_12.cubicTo(
        size.width * 0.5331204,
        size.height * 0.03959062,
        size.width * 0.5331204,
        size.height * 0.05660616,
        size.width * 0.5435772,
        size.height * 0.05824875);
    path_12.cubicTo(
        size.width * 0.5698285,
        size.height * 0.06246051,
        size.width * 0.5818603,
        size.height * 0.08874194,
        size.width * 0.5742037,
        size.height * 0.1117803);
    path_12.cubicTo(
        size.width * 0.5654533,
        size.height * 0.1381881,
        size.width * 0.5378019,
        size.height * 0.1529293,
        size.width * 0.5106755,
        size.height * 0.1559196);
    path_12.arcToPoint(Offset(size.width * 0.4997375, size.height * 0.1664491),
        radius: Radius.elliptical(
            size.width * 0.01128806, size.height * 0.01086636),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_12.arcToPoint(Offset(size.width * 0.5105880, size.height * 0.1768942),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
