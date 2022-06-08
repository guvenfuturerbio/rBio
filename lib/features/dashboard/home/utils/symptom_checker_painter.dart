// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class HomeSymptomCheckerCustomPainter extends CustomPainter {
  final color = Colors.black;

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
    paint_0_fill.color = const Color(0xffebcaf3).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5034127, size.height * 0.3139452);
    path_1.cubicTo(
        size.width * 0.4584792,
        size.height * 0.3196732,
        size.width * 0.4131957,
        size.height * 0.3219475,
        size.width * 0.3680434,
        size.height * 0.3252748);
    path_1.cubicTo(
        size.width * 0.3453798,
        size.height * 0.3269595,
        size.width * 0.3228036,
        size.height * 0.3289812,
        size.width * 0.3002713,
        size.height * 0.3318452);
    path_1.cubicTo(
        size.width * 0.2811516,
        size.height * 0.3342459,
        size.width * 0.2595817,
        size.height * 0.3369835,
        size.width * 0.2454935,
        size.height * 0.3511772);
    path_1.cubicTo(
        size.width * 0.2339429,
        size.height * 0.3628017,
        size.width * 0.2287802,
        size.height * 0.3823864,
        size.width * 0.2377494,
        size.height * 0.3968328);
    path_1.cubicTo(
        size.width * 0.2490812,
        size.height * 0.4152382,
        size.width * 0.2732324,
        size.height * 0.4128796,
        size.width * 0.2922209,
        size.height * 0.4119109);
    path_1.quadraticBezierTo(size.width * 0.3263476, size.height * 0.4100998,
        size.width * 0.3603868, size.height * 0.4061829);
    path_1.cubicTo(
        size.width * 0.3719811,
        size.height * 0.4048772,
        size.width * 0.3835317,
        size.height * 0.4033189,
        size.width * 0.3950823,
        size.height * 0.4017184);
    path_1.cubicTo(
        size.width * 0.4019076,
        size.height * 0.4007497,
        size.width * 0.4105705,
        size.height * 0.3993598,
        size.width * 0.4149457,
        size.height * 0.4056353);
    path_1.cubicTo(
        size.width * 0.4197585,
        size.height * 0.4125848,
        size.width * 0.4205898,
        size.height * 0.4224824,
        size.width * 0.4222086,
        size.height * 0.4304427);
    path_1.quadraticBezierTo(size.width * 0.4254900, size.height * 0.4464895,
        size.width * 0.4283777, size.height * 0.4626627);
    path_1.cubicTo(
        size.width * 0.4321841,
        size.height * 0.4839321,
        size.width * 0.4355093,
        size.height * 0.5052858,
        size.width * 0.4382219,
        size.height * 0.5266815);
    path_1.quadraticBezierTo(size.width * 0.4466223, size.height * 0.5922588,
        size.width * 0.4485037, size.height * 0.6583414);
    path_1.quadraticBezierTo(size.width * 0.4494225, size.height * 0.6911090,
        size.width * 0.4488099, size.height * 0.7238765);
    path_1.cubicTo(
        size.width * 0.4483724,
        size.height * 0.7449353,
        size.width * 0.4462286,
        size.height * 0.7663311,
        size.width * 0.4464911,
        size.height * 0.7875163);
    path_1.cubicTo(
        size.width * 0.4467536,
        size.height * 0.8073959,
        size.width * 0.4520476,
        size.height * 0.8275702,
        size.width * 0.4690672,
        size.height * 0.8402055);
    path_1.arcToPoint(Offset(size.width * 0.5181572, size.height * 0.8413006),
        radius: Radius.elliptical(
            size.width * 0.03937697, size.height * 0.03790591),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.5303203,
        size.height * 0.8320768,
        size.width * 0.5359205,
        size.height * 0.8168723,
        size.width * 0.5383269,
        size.height * 0.8025944);
    path_1.cubicTo(
        size.width * 0.5416083,
        size.height * 0.7833046,
        size.width * 0.5409520,
        size.height * 0.7634250,
        size.width * 0.5415208,
        size.height * 0.7439666);
    path_1.lineTo(size.width * 0.5434459, size.height * 0.6765784);
    path_1.cubicTo(
        size.width * 0.5438834,
        size.height * 0.6621320,
        size.width * 0.5434459,
        size.height * 0.6455376,
        size.width * 0.5504900,
        size.height * 0.6326075);
    path_1.arcToPoint(Offset(size.width * 0.5621281, size.height * 0.6221623),
        radius: Radius.elliptical(
            size.width * 0.02008225, size.height * 0.01933201),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.5483024, size.height * 0.6120120);
    path_1.lineTo(size.width * 0.5658033, size.height * 0.7641410);
    path_1.cubicTo(
        size.width * 0.5680347,
        size.height * 0.7834730,
        size.width * 0.5689972,
        size.height * 0.8036053,
        size.width * 0.5784477,
        size.height * 0.8212526);
    path_1.cubicTo(
        size.width * 0.5866731,
        size.height * 0.8367098,
        size.width * 0.6039552,
        size.height * 0.8476182,
        size.width * 0.6221999,
        size.height * 0.8423114);
    path_1.cubicTo(
        size.width * 0.6393070,
        size.height * 0.8372994,
        size.width * 0.6481449,
        size.height * 0.8207050,
        size.width * 0.6520389,
        size.height * 0.8050373);
    path_1.cubicTo(
        size.width * 0.6569391,
        size.height * 0.7849471,
        size.width * 0.6552765,
        size.height * 0.7636777,
        size.width * 0.6553640,
        size.height * 0.7432085);
    path_1.lineTo(size.width * 0.6562828, size.height * 0.5913322);
    path_1.lineTo(size.width * 0.6566766, size.height * 0.5148465);
    path_1.cubicTo(
        size.width * 0.6566766,
        size.height * 0.4906709,
        size.width * 0.6561953,
        size.height * 0.4663690,
        size.width * 0.6571141,
        size.height * 0.4421935);
    path_1.cubicTo(
        size.width * 0.6576391,
        size.height * 0.4273681,
        size.width * 0.6603518,
        size.height * 0.4092153,
        size.width * 0.6789902,
        size.height * 0.4084993);
    path_1.arcToPoint(Offset(size.width * 0.7151295, size.height * 0.4111106),
        radius:
            Radius.elliptical(size.width * 0.2863581, size.height * 0.2756602),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.7547690, size.height * 0.4146485);
    path_1.lineTo(size.width * 0.7933147, size.height * 0.4181022);
    path_1.cubicTo(
        size.width * 0.8041652,
        size.height * 0.4190709,
        size.width * 0.8151908,
        size.height * 0.4205450,
        size.width * 0.8260413,
        size.height * 0.4205450);
    path_1.cubicTo(
        size.width * 0.8435422,
        size.height * 0.4205450,
        size.width * 0.8643245,
        size.height * 0.4159963,
        size.width * 0.8721999,
        size.height * 0.3988965);
    path_1.cubicTo(
        size.width * 0.8813441,
        size.height * 0.3790170,
        size.width * 0.8673434,
        size.height * 0.3609906,
        size.width * 0.8503238,
        size.height * 0.3504191);
    path_1.cubicTo(
        size.width * 0.8333042,
        size.height * 0.3398475,
        size.width * 0.8112968,
        size.height * 0.3346249,
        size.width * 0.7913896,
        size.height * 0.3298656);
    path_1.cubicTo(
        size.width * 0.7069041,
        size.height * 0.3095649,
        size.width * 0.6176934,
        size.height * 0.3070379,
        size.width * 0.5310641,
        size.height * 0.3120077);
    path_1.cubicTo(
        size.width * 0.5217448,
        size.height * 0.3125132,
        size.width * 0.5124256,
        size.height * 0.3131870,
        size.width * 0.5031502,
        size.height * 0.3139030);
    path_1.arcToPoint(Offset(size.width * 0.4922121, size.height * 0.3244325),
        radius: Radius.elliptical(
            size.width * 0.01120056, size.height * 0.01078213),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.5031502, size.height * 0.3349619),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.5832167,
        size.height * 0.3286021,
        size.width * 0.6650333,
        size.height * 0.3285600,
        size.width * 0.7444872,
        size.height * 0.3418692);
    path_1.arcToPoint(Offset(size.width * 0.8063528, size.height * 0.3555995),
        radius:
            Radius.elliptical(size.width * 0.5438397, size.height * 0.5235227),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.8216661,
        size.height * 0.3598113,
        size.width * 0.8409608,
        size.height * 0.3649918,
        size.width * 0.8504113,
        size.height * 0.3785958);
    path_1.arcToPoint(Offset(size.width * 0.8507613, size.height * 0.3924946),
        radius: Radius.elliptical(
            size.width * 0.01159433, size.height * 0.01116118),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.8344855, size.height * 0.3990650),
        radius: Radius.elliptical(
            size.width * 0.02485124, size.height * 0.02392284),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.8082342, size.height * 0.3983490),
        radius:
            Radius.elliptical(size.width * 0.1242125, size.height * 0.1195721),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.lineTo(size.width * 0.7707823, size.height * 0.3950217);
    path_1.lineTo(size.width * 0.6969723, size.height * 0.3884935);
    path_1.cubicTo(
        size.width * 0.6862531,
        size.height * 0.3875247,
        size.width * 0.6750963,
        size.height * 0.3863033,
        size.width * 0.6646832,
        size.height * 0.3897991);
    path_1.arcToPoint(Offset(size.width * 0.6431572, size.height * 0.4076149),
        radius: Radius.elliptical(
            size.width * 0.03907070, size.height * 0.03761109),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.6339254,
        size.height * 0.4244619,
        size.width * 0.6351505,
        size.height * 0.4442151,
        size.width * 0.6350630,
        size.height * 0.4623679);
    path_1.lineTo(size.width * 0.6347130, size.height * 0.5348945);
    path_1.lineTo(size.width * 0.6340130, size.height * 0.6804953);
    path_1.lineTo(size.width * 0.6336629, size.height * 0.7517163);
    path_1.cubicTo(
        size.width * 0.6336629,
        size.height * 0.7700375,
        size.width * 0.6351943,
        size.height * 0.7885693,
        size.width * 0.6292877,
        size.height * 0.8058796);
    path_1.arcToPoint(Offset(size.width * 0.6200998, size.height * 0.8204102),
        radius: Radius.elliptical(
            size.width * 0.03176409, size.height * 0.03057743),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.6209310,
        size.height * 0.8197785,
        size.width * 0.6183497,
        size.height * 0.8214632,
        size.width * 0.6176496,
        size.height * 0.8218001);
    path_1.cubicTo(
        size.width * 0.6186997,
        size.height * 0.8212947,
        size.width * 0.6157245,
        size.height * 0.8223898,
        size.width * 0.6149370,
        size.height * 0.8225582);
    path_1.arcToPoint(Offset(size.width * 0.6072804, size.height * 0.8217159),
        radius: Radius.elliptical(
            size.width * 0.01378194, size.height * 0.01326707),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6018113, size.height * 0.8175041),
        radius: Radius.elliptical(
            size.width * 0.01771964, size.height * 0.01705766),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.5965173, size.height * 0.8090806),
        radius: Radius.elliptical(
            size.width * 0.03832692, size.height * 0.03689508),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.5906545, size.height * 0.7876006),
        radius: Radius.elliptical(
            size.width * 0.08431047, size.height * 0.08116076),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.5872856,
        size.height * 0.7659100,
        size.width * 0.5853168,
        size.height * 0.7420713,
        size.width * 0.5827354,
        size.height * 0.7195805);
    path_1.lineTo(size.width * 0.5743787, size.height * 0.6476856);
    path_1.lineTo(size.width * 0.5703098, size.height * 0.6122647);
    path_1.cubicTo(
        size.width * 0.5695660,
        size.height * 0.6058628,
        size.width * 0.5638344,
        size.height * 0.5996294,
        size.width * 0.5564403,
        size.height * 0.6020722);
    path_1.cubicTo(
        size.width * 0.5209135,
        size.height * 0.6132334,
        size.width * 0.5223136,
        size.height * 0.6560671,
        size.width * 0.5214386,
        size.height * 0.6852125);
    path_1.lineTo(size.width * 0.5195572, size.height * 0.7503685);
    path_1.cubicTo(
        size.width * 0.5190760,
        size.height * 0.7672156,
        size.width * 0.5200385,
        size.height * 0.7849471,
        size.width * 0.5165821,
        size.height * 0.8011624);
    path_1.arcToPoint(Offset(size.width * 0.5101068, size.height * 0.8188098),
        radius: Radius.elliptical(
            size.width * 0.05687784, size.height * 0.05475298),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.4995187, size.height * 0.8276123),
        radius: Radius.elliptical(
            size.width * 0.01872594, size.height * 0.01802637),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.4843367,
        size.height * 0.8318241,
        size.width * 0.4732674,
        size.height * 0.8164090,
        size.width * 0.4702485,
        size.height * 0.8040686);
    path_1.arcToPoint(Offset(size.width * 0.4687172, size.height * 0.7764394),
        radius:
            Radius.elliptical(size.width * 0.1033864, size.height * 0.09952407),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.4691547,
        size.height * 0.7664575,
        size.width * 0.4697235,
        size.height * 0.7565177,
        size.width * 0.4701173,
        size.height * 0.7464937);
    path_1.quadraticBezierTo(size.width * 0.4712986, size.height * 0.7147791,
        size.width * 0.4709485, size.height * 0.6830645);
    path_1.arcToPoint(Offset(size.width * 0.4446972, size.height * 0.4309902),
        radius:
            Radius.elliptical(size.width * 1.465130, size.height * 1.410395),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.4413721,
        size.height * 0.4144801,
        size.width * 0.4392282,
        size.height * 0.3928316,
        size.width * 0.4219898,
        size.height * 0.3839447);
    path_1.cubicTo(
        size.width * 0.4123644,
        size.height * 0.3789327,
        size.width * 0.4016888,
        size.height * 0.3797330,
        size.width * 0.3913633,
        size.height * 0.3812492);
    path_1.cubicTo(
        size.width * 0.3810378,
        size.height * 0.3827654,
        size.width * 0.3701873,
        size.height * 0.3841553,
        size.width * 0.3595992,
        size.height * 0.3854610);
    path_1.quadraticBezierTo(size.width * 0.3271789, size.height * 0.3891252,
        size.width * 0.2946272, size.height * 0.3909363);
    path_1.cubicTo(
        size.width * 0.2852205,
        size.height * 0.3914417,
        size.width * 0.2745450,
        size.height * 0.3931264,
        size.width * 0.2652695,
        size.height * 0.3911890);
    path_1.arcToPoint(Offset(size.width * 0.2554253, size.height * 0.3821337),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.2538502,
        size.height * 0.3676031,
        size.width * 0.2685509,
        size.height * 0.3596007,
        size.width * 0.2816766,
        size.height * 0.3563998);
    path_1.cubicTo(
        size.width * 0.3012338,
        size.height * 0.3515562,
        size.width * 0.3221911,
        size.height * 0.3504612,
        size.width * 0.3422296,
        size.height * 0.3486501);
    path_1.cubicTo(
        size.width * 0.3849755,
        size.height * 0.3448595,
        size.width * 0.4278964,
        size.height * 0.3430485,
        size.width * 0.4706423,
        size.height * 0.3389209);
    path_1.quadraticBezierTo(size.width * 0.4872681, size.height * 0.3373626,
        size.width * 0.5038064, size.height * 0.3352146);
    path_1.arcToPoint(Offset(size.width * 0.5147445, size.height * 0.3246852),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.5038064, size.height * 0.3141558),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color;
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5710973, size.height * 0.1498968);
    path_2.cubicTo(
        size.width * 0.5504900,
        size.height * 0.1234469,
        size.width * 0.5110256,
        size.height * 0.1227309,
        size.width * 0.4859118,
        size.height * 0.1437055);
    path_2.cubicTo(
        size.width * 0.4607980,
        size.height * 0.1646801,
        size.width * 0.4539727,
        size.height * 0.2015752,
        size.width * 0.4645607,
        size.height * 0.2309733);
    path_2.cubicTo(
        size.width * 0.4751488,
        size.height * 0.2603715,
        size.width * 0.5015751,
        size.height * 0.2829466,
        size.width * 0.5348705,
        size.height * 0.2839995);
    path_2.arcToPoint(Offset(size.width * 0.6048740, size.height * 0.2353536),
        radius: Radius.elliptical(
            size.width * 0.06869093, size.height * 0.06612475),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.arcToPoint(Offset(size.width * 0.6016363, size.height * 0.1800952),
        radius:
            Radius.elliptical(size.width * 0.1076741, size.height * 0.1036516),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.cubicTo(
        size.width * 0.5961673,
        size.height * 0.1627848,
        size.width * 0.5885107,
        size.height * 0.1432422,
        size.width * 0.5693472,
        size.height * 0.1366297);
    path_2.arcToPoint(Offset(size.width * 0.5635282, size.height * 0.1569305),
        radius: Radius.elliptical(
            size.width * 0.01093805, size.height * 0.01052942),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.cubicTo(
        size.width * 0.5731099,
        size.height * 0.1602578,
        size.width * 0.5772664,
        size.height * 0.1757992,
        size.width * 0.5800228,
        size.height * 0.1840542);
    path_2.arcToPoint(Offset(size.width * 0.5852293, size.height * 0.2222971),
        radius: Radius.elliptical(
            size.width * 0.09817991, size.height * 0.09451207),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.5438397, size.height * 0.2626458),
        radius: Radius.elliptical(
            size.width * 0.04607105, size.height * 0.04434991),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.4897182, size.height * 0.2339637),
        radius: Radius.elliptical(
            size.width * 0.05390270, size.height * 0.05188898),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.4926059, size.height * 0.1681759),
        radius: Radius.elliptical(
            size.width * 0.06702835, size.height * 0.06452428),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.5215261, size.height * 0.1499389),
        radius: Radius.elliptical(
            size.width * 0.04217711, size.height * 0.04060144),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.cubicTo(
        size.width * 0.5323766,
        size.height * 0.1486333,
        size.width * 0.5454585,
        size.height * 0.1517500,
        size.width * 0.5521526,
        size.height * 0.1605526);
    path_2.arcToPoint(Offset(size.width * 0.5671159, size.height * 0.1643432),
        radius: Radius.elliptical(
            size.width * 0.01128806, size.height * 0.01086636),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.arcToPoint(Offset(size.width * 0.5710536, size.height * 0.1498968),
        radius: Radius.elliptical(
            size.width * 0.01111306, size.height * 0.01069789),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = color;
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.7919146, size.height * 0.3333193);
    path_3.cubicTo(
        size.width * 0.7556003,
        size.height * 0.2849682,
        size.width * 0.7049790,
        size.height * 0.2484943,
        size.width * 0.6495450,
        size.height * 0.2224235);
    path_3.cubicTo(
        size.width * 0.6331379,
        size.height * 0.2146738,
        size.width * 0.6162933,
        size.height * 0.2077665,
        size.width * 0.5992300,
        size.height * 0.2013646);
    path_3.arcToPoint(Offset(size.width * 0.5857543, size.height * 0.2086931),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.5934109, size.height * 0.2216653),
        radius: Radius.elliptical(
            size.width * 0.01120056, size.height * 0.01078213),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.cubicTo(
        size.width * 0.6477949,
        size.height * 0.2415028,
        size.width * 0.7002100,
        size.height * 0.2695531,
        size.width * 0.7421684,
        size.height * 0.3090595);
    path_3.arcToPoint(Offset(size.width * 0.7734512, size.height * 0.3437645),
        radius:
            Radius.elliptical(size.width * 0.2920021, size.height * 0.2810934),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.arcToPoint(Offset(size.width * 0.7884144, size.height * 0.3475551),
        radius: Radius.elliptical(
            size.width * 0.01124431, size.height * 0.01082424),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.7923084, size.height * 0.3331508),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = color;
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.6461323, size.height * 0.7484311);
    path_4.arcToPoint(Offset(size.width * 0.7864456, size.height * 0.6467169),
        radius:
            Radius.elliptical(size.width * 0.2843892, size.height * 0.2737649),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.8418358, size.height * 0.4964832),
        radius:
            Radius.elliptical(size.width * 0.3041215, size.height * 0.2927600),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.8308103, size.height * 0.4070673),
        radius:
            Radius.elliptical(size.width * 0.2607193, size.height * 0.2509792),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.8266538,
        size.height * 0.3941793,
        size.width * 0.8055215,
        size.height * 0.3996968,
        size.width * 0.8097217,
        size.height * 0.4126690);
    path_4.arcToPoint(Offset(size.width * 0.8076654, size.height * 0.5588173),
        radius:
            Radius.elliptical(size.width * 0.2542002, size.height * 0.2447037),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.arcToPoint(Offset(size.width * 0.7232674, size.height * 0.6827697),
        radius:
            Radius.elliptical(size.width * 0.2833392, size.height * 0.2727541),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.arcToPoint(Offset(size.width * 0.6401383, size.height * 0.7281304),
        radius:
            Radius.elliptical(size.width * 0.2504375, size.height * 0.2410816),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.6270126,
        size.height * 0.7323422,
        size.width * 0.6325691,
        size.height * 0.7528114,
        size.width * 0.6459573,
        size.height * 0.7484311);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = color;
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.2751575, size.height * 0.3988965);
    path_5.arcToPoint(Offset(size.width * 0.2493875, size.height * 0.4918081),
        radius:
            Radius.elliptical(size.width * 0.4496850, size.height * 0.4328855),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.2444872,
        size.height * 0.5233964,
        size.width * 0.2440497,
        size.height * 0.5557427,
        size.width * 0.2554690,
        size.height * 0.5861517);
    path_5.cubicTo(
        size.width * 0.2751138,
        size.height * 0.6385882,
        size.width * 0.3191285,
        size.height * 0.6818010,
        size.width * 0.3671246,
        size.height * 0.7114939);
    path_5.arcToPoint(Offset(size.width * 0.4556790, size.height * 0.7501579),
        radius:
            Radius.elliptical(size.width * 0.3434547, size.height * 0.3306238),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4691985,
        size.height * 0.7539906,
        size.width * 0.4749737,
        size.height * 0.7336899,
        size.width * 0.4614981,
        size.height * 0.7298572);
    path_5.arcToPoint(Offset(size.width * 0.3252975, size.height * 0.6515183),
        radius:
            Radius.elliptical(size.width * 0.3106405, size.height * 0.2990355),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.arcToPoint(Offset(size.width * 0.2794890, size.height * 0.5877522),
        radius:
            Radius.elliptical(size.width * 0.2239674, size.height * 0.2156004),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.2674571,
        size.height * 0.5607126,
        size.width * 0.2659695,
        size.height * 0.5316093,
        size.width * 0.2697322,
        size.height * 0.5026745);
    path_5.arcToPoint(Offset(size.width * 0.2962461, size.height * 0.4043297),
        radius:
            Radius.elliptical(size.width * 0.4284652, size.height * 0.4124584),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.arcToPoint(Offset(size.width * 0.2887644, size.height * 0.3916944),
        radius: Radius.elliptical(
            size.width * 0.01102555, size.height * 0.01061365),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.2752888, size.height * 0.3990650),
        radius: Radius.elliptical(
            size.width * 0.01120056, size.height * 0.01078213),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = color;
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4681484, size.height * 0.1970265);
    path_6.cubicTo(
        size.width * 0.3991075,
        size.height * 0.2232237,
        size.width * 0.3449422,
        size.height * 0.2744388,
        size.width * 0.3073154,
        size.height * 0.3350882);
    path_6.cubicTo(
        size.width * 0.3000525,
        size.height * 0.3467548,
        size.width * 0.3189972,
        size.height * 0.3573685,
        size.width * 0.3262163,
        size.height * 0.3457019);
    path_6.cubicTo(
        size.width * 0.3606930,
        size.height * 0.2901487,
        size.width * 0.4104830,
        size.height * 0.2412501,
        size.width * 0.4740112,
        size.height * 0.2173693);
    path_6.arcToPoint(Offset(size.width * 0.4816678, size.height * 0.2043971),
        radius: Radius.elliptical(
            size.width * 0.01128806, size.height * 0.01086636),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.arcToPoint(Offset(size.width * 0.4681484, size.height * 0.1970265),
        radius: Radius.elliptical(
            size.width * 0.01106930, size.height * 0.01065577),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = color;
    canvas.drawPath(path_6, paint_6_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
