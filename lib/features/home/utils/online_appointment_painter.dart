// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class HomeOnlineAppointmentCustomPainter extends CustomPainter {
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
    paint_0_fill.color = const Color(0xffffe57b).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2353430, size.height * 0.3084277);
    path_1.arcToPoint(Offset(size.width * 0.2328929, size.height * 0.5036853),
        radius:
            Radius.elliptical(size.width * 1.508750, size.height * 1.452386),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.2345555,
        size.height * 0.5319463,
        size.width * 0.2349055,
        size.height * 0.5622289,
        size.width * 0.2441810,
        size.height * 0.5893948);
    path_1.arcToPoint(Offset(size.width * 0.2944085, size.height * 0.6444005),
        radius: Radius.elliptical(
            size.width * 0.09362968, size.height * 0.09013183),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.3181222,
        size.height * 0.6548456,
        size.width * 0.3442860,
        size.height * 0.6579202,
        size.width * 0.3700998,
        size.height * 0.6590153);
    path_1.cubicTo(
        size.width * 0.4025201,
        size.height * 0.6604473,
        size.width * 0.4350718,
        size.height * 0.6602367,
        size.width * 0.4675359,
        size.height * 0.6600261);
    path_1.cubicTo(
        size.width * 0.5340392,
        size.height * 0.6595207,
        size.width * 0.6010676,
        size.height * 0.6577518,
        size.width * 0.6673521,
        size.height * 0.6516026);
    path_1.cubicTo(
        size.width * 0.6835404,
        size.height * 0.6501285,
        size.width * 0.7001225,
        size.height * 0.6473908,
        size.width * 0.7142982,
        size.height * 0.6393885);
    path_1.arcToPoint(Offset(size.width * 0.7413808, size.height * 0.6105378),
        radius: Radius.elliptical(
            size.width * 0.07035352, size.height * 0.06772522),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.7535002,
        size.height * 0.5861096,
        size.width * 0.7537627,
        size.height * 0.5580171,
        size.width * 0.7524064,
        size.height * 0.5314830);
    path_1.lineTo(size.width * 0.7359555, size.height * 0.5405804);
    path_1.lineTo(size.width * 0.7959398, size.height * 0.5710315);
    path_1.lineTo(size.width * 0.8249475, size.height * 0.5857305);
    path_1.cubicTo(
        size.width * 0.8346605,
        size.height * 0.5906583,
        size.width * 0.8442422,
        size.height * 0.5961757,
        size.width * 0.8543490,
        size.height * 0.6002190);
    path_1.cubicTo(
        size.width * 0.8644557,
        size.height * 0.6042623,
        size.width * 0.8744750,
        size.height * 0.6049783,
        size.width * 0.8833567,
        size.height * 0.5992503);
    path_1.arcToPoint(Offset(size.width * 0.8956510, size.height * 0.5764225),
        radius: Radius.elliptical(
            size.width * 0.03150158, size.height * 0.03032473),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.8956510, size.height * 0.5495936),
        radius:
            Radius.elliptical(size.width * 0.1975411, size.height * 0.1901613),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.8946447, size.height * 0.5171630);
    path_1.lineTo(size.width * 0.8907508, size.height * 0.3884092);
    path_1.lineTo(size.width * 0.8888257, size.height * 0.3245588);
    path_1.cubicTo(
        size.width * 0.8885632,
        size.height * 0.3155035,
        size.width * 0.8896570,
        size.height * 0.3049741,
        size.width * 0.8864193,
        size.height * 0.2963400);
    path_1.arcToPoint(Offset(size.width * 0.8636682, size.height * 0.2815146),
        radius: Radius.elliptical(
            size.width * 0.02349492, size.height * 0.02261719),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.8533864,
        size.height * 0.2815146,
        size.width * 0.8431047,
        size.height * 0.2857263,
        size.width * 0.8336542,
        size.height * 0.2891379);
    path_1.cubicTo(
        size.width * 0.8227599,
        size.height * 0.2929706,
        size.width * 0.8120406,
        size.height * 0.2972244,
        size.width * 0.8014526,
        size.height * 0.3017732);
    path_1.arcToPoint(Offset(size.width * 0.7401995, size.height * 0.3336984),
        radius:
            Radius.elliptical(size.width * 0.4690672, size.height * 0.4515436),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.lineTo(size.width * 0.7563003, size.height * 0.3455755);
    path_1.arcToPoint(Offset(size.width * 0.7203360, size.height * 0.2367435),
        radius:
            Radius.elliptical(size.width * 0.1163371, size.height * 0.1119909),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.6864718,
        size.height * 0.2088194,
        size.width * 0.6407945,
        size.height * 0.2037232,
        size.width * 0.5978299,
        size.height * 0.2040601);
    path_1.cubicTo(
        size.width * 0.5469023,
        size.height * 0.2045234,
        size.width * 0.4958435,
        size.height * 0.2080192,
        size.width * 0.4449160,
        size.height * 0.2101672);
    path_1.lineTo(size.width * 0.3644557, size.height * 0.2135787);
    path_1.arcToPoint(Offset(size.width * 0.3052153, size.height * 0.2198122),
        radius:
            Radius.elliptical(size.width * 0.3243350, size.height * 0.3122183),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.2853955,
        size.height * 0.2240239,
        size.width * 0.2651820,
        size.height * 0.2324475,
        size.width * 0.2513126,
        size.height * 0.2471044);
    path_1.cubicTo(
        size.width * 0.2331992,
        size.height * 0.2664785,
        size.width * 0.2303990,
        size.height * 0.2917070,
        size.width * 0.2294365,
        size.height * 0.3166828);
    path_1.cubicTo(
        size.width * 0.2288239,
        size.height * 0.3302447,
        size.width * 0.2507000,
        size.height * 0.3302026,
        size.width * 0.2513126,
        size.height * 0.3166828);
    path_1.cubicTo(
        size.width * 0.2521439,
        size.height * 0.2984459,
        size.width * 0.2529314,
        size.height * 0.2783136,
        size.width * 0.2655758,
        size.height * 0.2635303);
    path_1.cubicTo(
        size.width * 0.2756388,
        size.height * 0.2518216,
        size.width * 0.2903833,
        size.height * 0.2453776,
        size.width * 0.3053465,
        size.height * 0.2415028);
    path_1.arcToPoint(Offset(size.width * 0.3551365, size.height * 0.2350166),
        radius:
            Radius.elliptical(size.width * 0.2355618, size.height * 0.2267616),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.3796815,
        size.height * 0.2338795,
        size.width * 0.4042265,
        size.height * 0.2329529,
        size.width * 0.4287714,
        size.height * 0.2318999);
    path_1.cubicTo(
        size.width * 0.4778614,
        size.height * 0.2298362,
        size.width * 0.5269513,
        size.height * 0.2276882,
        size.width * 0.5759975,
        size.height * 0.2257086);
    path_1.cubicTo(
        size.width * 0.6139307,
        size.height * 0.2242766,
        size.width * 0.6557578,
        size.height * 0.2233500,
        size.width * 0.6897532,
        size.height * 0.2417133);
    path_1.arcToPoint(Offset(size.width * 0.7350368, size.height * 0.3401845),
        radius: Radius.elliptical(
            size.width * 0.09397970, size.height * 0.09046877),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.7329366,
        size.height * 0.3486080,
        size.width * 0.7426934,
        size.height * 0.3570315,
        size.width * 0.7510938,
        size.height * 0.3520617);
    path_1.arcToPoint(Offset(size.width * 0.8487924, size.height * 0.3064482),
        radius:
            Radius.elliptical(size.width * 0.4563353, size.height * 0.4392874),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.8596430, size.height * 0.3032473),
        radius:
            Radius.elliptical(size.width * 0.1006300, size.height * 0.09687066),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.8650683, size.height * 0.3026155),
        radius: Radius.elliptical(
            size.width * 0.03268288, size.height * 0.03146190),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.8665121,
        size.height * 0.3035000,
        size.width * 0.8662933,
        size.height * 0.3068273,
        size.width * 0.8663371,
        size.height * 0.3083014);
    path_1.cubicTo(
        size.width * 0.8665558,
        size.height * 0.3130607,
        size.width * 0.8666433,
        size.height * 0.3178621,
        size.width * 0.8668183,
        size.height * 0.3226635);
    path_1.lineTo(size.width * 0.8685247, size.height * 0.3802384);
    path_1.lineTo(size.width * 0.8720249, size.height * 0.4953881);
    path_1.lineTo(size.width * 0.8737749, size.height * 0.5529630);
    path_1.arcToPoint(Offset(size.width * 0.8739937, size.height * 0.5752853),
        radius:
            Radius.elliptical(size.width * 0.1465261, size.height * 0.1410521),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.8731624,
        size.height * 0.5809291,
        size.width * 0.8714123,
        size.height * 0.5837089,
        size.width * 0.8652433,
        size.height * 0.5818557);
    path_1.cubicTo(
        size.width * 0.8554865,
        size.height * 0.5789917,
        size.width * 0.8462111,
        size.height * 0.5728425,
        size.width * 0.8371981,
        size.height * 0.5682517);
    path_1.lineTo(size.width * 0.8081467, size.height * 0.5535526);
    path_1.lineTo(size.width * 0.7472436, size.height * 0.5225961);
    path_1.arcToPoint(Offset(size.width * 0.7307490, size.height * 0.5316936),
        radius: Radius.elliptical(
            size.width * 0.01106930, size.height * 0.01065577),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.7318428,
        size.height * 0.5531736,
        size.width * 0.7322804,
        size.height * 0.5757065,
        size.width * 0.7244050,
        size.height * 0.5961757);
    path_1.arcToPoint(Offset(size.width * 0.7078666, size.height * 0.6186244),
        radius: Radius.elliptical(
            size.width * 0.05250263, size.height * 0.05054121),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6748337, size.height * 0.6299962),
        radius: Radius.elliptical(
            size.width * 0.06908470, size.height * 0.06650381),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.6601330,
        size.height * 0.6319757,
        size.width * 0.6451698,
        size.height * 0.6324812,
        size.width * 0.6303815,
        size.height * 0.6334077);
    path_1.quadraticBezierTo(size.width * 0.6065803, size.height * 0.6348819,
        size.width * 0.5826916, size.height * 0.6360190);
    path_1.quadraticBezierTo(size.width * 0.5339517, size.height * 0.6382934,
        size.width * 0.4850805, size.height * 0.6389252);
    path_1.quadraticBezierTo(size.width * 0.4373906, size.height * 0.6395569,
        size.width * 0.3896132, size.height * 0.6386725);
    path_1.cubicTo(
        size.width * 0.3656808,
        size.height * 0.6382092,
        size.width * 0.3414858,
        size.height * 0.6374932,
        size.width * 0.3183409,
        size.height * 0.6307964);
    path_1.cubicTo(
        size.width * 0.2964648,
        size.height * 0.6244788,
        size.width * 0.2780014,
        size.height * 0.6118856,
        size.width * 0.2684634,
        size.height * 0.5913743);
    path_1.cubicTo(
        size.width * 0.2577004,
        size.height * 0.5682517,
        size.width * 0.2574379,
        size.height * 0.5408331,
        size.width * 0.2557753,
        size.height * 0.5161100);
    path_1.arcToPoint(Offset(size.width * 0.2574379, size.height * 0.3084277),
        radius:
            Radius.elliptical(size.width * 1.504550, size.height * 1.448343),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.2464998, size.height * 0.2978983),
        radius: Radius.elliptical(
            size.width * 0.01098180, size.height * 0.01057154),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.2355618, size.height * 0.3084277),
        radius: Radius.elliptical(
            size.width * 0.01115681, size.height * 0.01074001),
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
