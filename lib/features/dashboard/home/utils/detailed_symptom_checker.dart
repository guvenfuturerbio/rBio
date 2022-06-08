// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class HomeDetailedCheckupCustomPainter extends CustomPainter {
  final color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8687417, size.height * 0.0001726832);
    path_0.lineTo(size.width * 0.2312158, size.height * 0.0001726832);
    path_0.cubicTo(
        size.width * 0.1096313,
        size.height * 0.08067254,
        size.width * 0.03760112,
        size.height * 0.2293401,
        size.width * 0.01132321,
        size.height * 0.3735854);
    path_0.cubicTo(
        size.width * -0.002301395,
        size.height * 0.4483530,
        size.width * -0.006759802,
        size.height * 0.5264732,
        size.width * 0.01585163,
        size.height * 0.5992318);
    path_0.cubicTo(
        size.width * 0.06067195,
        size.height * 0.7434096,
        size.width * 0.2009739,
        size.height * 0.8389329,
        size.width * 0.3392502,
        size.height * 0.9091476);
    path_0.cubicTo(
        size.width * 0.3982114,
        size.height * 0.9390892,
        size.width * 0.4589796,
        size.height * 0.9667227,
        size.width * 0.5235105,
        size.height * 0.9828159);
    path_0.arcToPoint(Offset(size.width * 0.7158127, size.height * 0.9986733),
        radius:
            Radius.elliptical(size.width * 0.6046150, size.height * 0.5820224),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.cubicTo(
        size.width * 0.8158227,
        size.height * 0.9921324,
        size.width * 0.9159947,
        size.height * 0.9624519,
        size.width * 1.000000,
        size.height * 0.9106891);
    path_0.lineTo(size.width * 1.000000, size.height * 0.1265262);
    path_0.arcToPoint(
        Offset(size.width * 0.8687417, size.height * 0.0001726832),
        radius:
            Radius.elliptical(size.width * 0.1312583, size.height * 0.1263536),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xffbadbc9).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.4522373, size.height * 0.1775815);
    path_1.arcToPoint(Offset(size.width * 0.4535893, size.height * 0.2110863),
        radius: Radius.elliptical(
            size.width * 0.08246083, size.height * 0.07937952),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.4775614, size.height * 0.2356536),
        radius: Radius.elliptical(
            size.width * 0.04010378, size.height * 0.03860523),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.4890027,
        size.height * 0.2400423,
        size.width * 0.5018267,
        size.height * 0.2399665,
        size.width * 0.5139549,
        size.height * 0.2404171);
    path_1.cubicTo(
        size.width * 0.5286821,
        size.height * 0.2409689,
        size.width * 0.5434181,
        size.height * 0.2414448,
        size.width * 0.5581452,
        size.height * 0.2414111);
    path_1.cubicTo(
        size.width * 0.5728724,
        size.height * 0.2413774,
        size.width * 0.5875340,
        size.height * 0.2408046,
        size.width * 0.6021649,
        size.height * 0.2393810);
    path_1.cubicTo(
        size.width * 0.6166295,
        size.height * 0.2379701,
        size.width * 0.6310417,
        size.height * 0.2359442,
        size.width * 0.6455851,
        size.height * 0.2353377);
    path_1.arcToPoint(Offset(size.width * 0.6666302, size.height * 0.2356620),
        radius:
            Radius.elliptical(size.width * 0.1593519, size.height * 0.1533974),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.6728737,
        size.height * 0.2362011,
        size.width * 0.6789335,
        size.height * 0.2378732,
        size.width * 0.6851770,
        size.height * 0.2383828);
    path_1.arcToPoint(Offset(size.width * 0.7026344, size.height * 0.2335435),
        radius: Radius.elliptical(
            size.width * 0.02295707, size.height * 0.02209924),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.7103567, size.height * 0.2161994),
        radius: Radius.elliptical(
            size.width * 0.02775675, size.height * 0.02671957),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.7094467, size.height * 0.1752524),
        radius:
            Radius.elliptical(size.width * 0.1328028, size.height * 0.1278403),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.7069746,
        size.height * 0.1621959,
        size.width * 0.7001623,
        size.height * 0.1501291,
        size.width * 0.6847832,
        size.height * 0.1495900);
    path_1.arcToPoint(Offset(size.width * 0.6692772, size.height * 0.1515021),
        radius:
            Radius.elliptical(size.width * 0.1300770, size.height * 0.1252164),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.6651295, size.height * 0.1513463),
        radius: Radius.elliptical(
            size.width * 0.03911059, size.height * 0.03764915),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6618699, size.height * 0.1489119),
        radius: Radius.elliptical(
            size.width * 0.007569228, size.height * 0.007286389),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.6565496,
        size.height * 0.1424131,
        size.width * 0.6550970,
        size.height * 0.1333957,
        size.width * 0.6520824,
        size.height * 0.1257471);
    path_1.cubicTo(
        size.width * 0.6351807,
        size.height * 0.08274052,
        size.width * 0.5797985,
        size.height * 0.06557329,
        size.width * 0.5393578,
        size.height * 0.08928564);
    path_1.arcToPoint(Offset(size.width * 0.5117673, size.height * 0.1148091),
        radius: Radius.elliptical(
            size.width * 0.09013069, size.height * 0.08676278),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.5047406,
        size.height * 0.1247910,
        size.width * 0.5016604,
        size.height * 0.1357458,
        size.width * 0.4979414,
        size.height * 0.1470587);
    path_1.arcToPoint(Offset(size.width * 0.4931286, size.height * 0.1559456),
        radius: Radius.elliptical(
            size.width * 0.01994251, size.height * 0.01919732),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.4889327,
        size.height * 0.1583800,
        size.width * 0.4800028,
        size.height * 0.1547957,
        size.width * 0.4749406,
        size.height * 0.1548716);
    path_1.cubicTo(
        size.width * 0.4601609,
        size.height * 0.1550822,
        size.width * 0.4472364,
        size.height * 0.1689558,
        size.width * 0.4546612,
        size.height * 0.1827367);
    path_1.cubicTo(
        size.width * 0.4611454,
        size.height * 0.1947698,
        size.width * 0.4800378,
        size.height * 0.1841350,
        size.width * 0.4735493,
        size.height * 0.1721062);
    path_1.lineTo(size.width * 0.4738993, size.height * 0.1757747);
    path_1.arcToPoint(Offset(size.width * 0.4738118, size.height * 0.1762590),
        radius: Radius.elliptical(
            size.width * 0.001246954, size.height * 0.001200359),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.4738905,
        size.height * 0.1763138,
        size.width * 0.4738424,
        size.height * 0.1763685,
        size.width * 0.4738118,
        size.height * 0.1763432);
    path_1.cubicTo(
        size.width * 0.4738512,
        size.height * 0.1763432,
        size.width * 0.4768395,
        size.height * 0.1759852,
        size.width * 0.4775920,
        size.height * 0.1760611);
    path_1.arcToPoint(Offset(size.width * 0.4961826, size.height * 0.1771224),
        radius: Radius.elliptical(
            size.width * 0.05983628, size.height * 0.05760038),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.5067401,
        size.height * 0.1751134,
        size.width * 0.5132768,
        size.height * 0.1669510,
        size.width * 0.5171051,
        size.height * 0.1578577);
    path_1.cubicTo(
        size.width * 0.5202991,
        size.height * 0.1502765,
        size.width * 0.5214804,
        size.height * 0.1420046,
        size.width * 0.5251732,
        size.height * 0.1345918);
    path_1.arcToPoint(Offset(size.width * 0.5413398, size.height * 0.1139246),
        radius: Radius.elliptical(
            size.width * 0.06843807, size.height * 0.06588075),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6282197, size.height * 0.1258355),
        radius: Radius.elliptical(
            size.width * 0.05603854, size.height * 0.05394455),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.6366639,
        size.height * 0.1401556,
        size.width * 0.6367908,
        size.height * 0.1597151,
        size.width * 0.6530450,
        size.height * 0.1689895);
    path_1.arcToPoint(Offset(size.width * 0.6676496, size.height * 0.1726537),
        radius: Radius.elliptical(
            size.width * 0.02857493, size.height * 0.02750717),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.cubicTo(
        size.width * 0.6726681,
        size.height * 0.1726537,
        size.width * 0.6774984,
        size.height * 0.1708848,
        size.width * 0.6824512,
        size.height * 0.1706910);
    path_1.cubicTo(
        size.width * 0.6876184,
        size.height * 0.1704847,
        size.width * 0.6832256,
        size.height * 0.1706363,
        size.width * 0.6841707,
        size.height * 0.1705183);
    path_1.cubicTo(
        size.width * 0.6861308,
        size.height * 0.1702741,
        size.width * 0.6858595,
        size.height * 0.1713017,
        size.width * 0.6848795,
        size.height * 0.1704257);
    path_1.arcToPoint(Offset(size.width * 0.6869709, size.height * 0.1746796),
        radius: Radius.elliptical(
            size.width * 0.008654296, size.height * 0.008330912),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6896923, size.height * 0.1917668),
        radius: Radius.elliptical(
            size.width * 0.08721676, size.height * 0.08395773),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6894429, size.height * 0.2085129),
        radius:
            Radius.elliptical(size.width * 0.1178043, size.height * 0.1134023),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6884060, size.height * 0.2159382),
        radius: Radius.elliptical(
            size.width * 0.06174827, size.height * 0.05944093),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.arcToPoint(Offset(size.width * 0.6876403, size.height * 0.2187349),
        radius: Radius.elliptical(
            size.width * 0.009905625, size.height * 0.009535482),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.6876884,
        size.height * 0.2186759,
        size.width * 0.6884322,
        size.height * 0.2175808,
        size.width * 0.6882003,
        size.height * 0.2175682);
    path_1.cubicTo(
        size.width * 0.6780541,
        size.height * 0.2169659,
        size.width * 0.6676628,
        size.height * 0.2143462,
        size.width * 0.6572015,
        size.height * 0.2141398);
    path_1.cubicTo(
        size.width * 0.6316236,
        size.height * 0.2136428,
        size.width * 0.6062864,
        size.height * 0.2187138,
        size.width * 0.5807785,
        size.height * 0.2198636);
    path_1.arcToPoint(Offset(size.width * 0.4972808, size.height * 0.2185580),
        radius:
            Radius.elliptical(size.width * 0.6078046, size.height * 0.5850928),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_1.cubicTo(
        size.width * 0.4886440,
        size.height * 0.2177956,
        size.width * 0.4789352,
        size.height * 0.2154033,
        size.width * 0.4752294,
        size.height * 0.2069924);
    path_1.cubicTo(
        size.width * 0.4712610,
        size.height * 0.1979918,
        size.width * 0.4729674,
        size.height * 0.1869780,
        size.width * 0.4741137,
        size.height * 0.1775984);
    path_1.arcToPoint(Offset(size.width * 0.4631755, size.height * 0.1670689),
        radius: Radius.elliptical(
            size.width * 0.01099944, size.height * 0.01058843),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.arcToPoint(Offset(size.width * 0.4522373, size.height * 0.1775984),
        radius: Radius.elliptical(
            size.width * 0.01120071, size.height * 0.01078217),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color;
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.4416885, size.height * 0.1886332);
    path_2.arcToPoint(Offset(size.width * 0.4182239, size.height * 0.1971537),
        radius: Radius.elliptical(
            size.width * 0.04069007, size.height * 0.03916960),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.3863675, size.height * 0.1969052),
        radius:
            Radius.elliptical(size.width * 0.2537660, size.height * 0.2442836),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.cubicTo(
        size.width * 0.3660619,
        size.height * 0.1960965,
        size.width * 0.3416172,
        size.height * 0.1958438,
        size.width * 0.3269119,
        size.height * 0.2118275);
    path_2.cubicTo(
        size.width * 0.3169800,
        size.height * 0.2226266,
        size.width * 0.3144599,
        size.height * 0.2364033,
        size.width * 0.3142936,
        size.height * 0.2504201);
    path_2.cubicTo(
        size.width * 0.3140923,
        size.height * 0.2675284,
        size.width * 0.3145430,
        size.height * 0.2846662,
        size.width * 0.3147005,
        size.height * 0.3017744);
    path_2.quadraticBezierTo(size.width * 0.3151730, size.height * 0.3531835,
        size.width * 0.3157899, size.height * 0.4045799);
    path_2.quadraticBezierTo(size.width * 0.3170019, size.height * 0.5063324,
        size.width * 0.3187695, size.height * 0.6080807);
    path_2.quadraticBezierTo(size.width * 0.3196446, size.height * 0.6594645,
        size.width * 0.3206946, size.height * 0.7108778);
    path_2.cubicTo(
        size.width * 0.3212722,
        size.height * 0.7385071,
        size.width * 0.3246324,
        size.height * 0.7672694,
        size.width * 0.3482107,
        size.height * 0.7860918);
    path_2.cubicTo(
        size.width * 0.3675320,
        size.height * 0.8015280,
        size.width * 0.3922610,
        size.height * 0.8072434,
        size.width * 0.4167407,
        size.height * 0.8096315);
    path_2.cubicTo(
        size.width * 0.4459238,
        size.height * 0.8124787,
        size.width * 0.4756319,
        size.height * 0.8105202,
        size.width * 0.5048937,
        size.height * 0.8100527);
    path_2.lineTo(size.width * 0.7179434, size.height * 0.8064769);
    path_2.cubicTo(
        size.width * 0.7346132,
        size.height * 0.8061947,
        size.width * 0.7513093,
        size.height * 0.8061610,
        size.width * 0.7679747,
        size.height * 0.8056008);
    path_2.arcToPoint(Offset(size.width * 0.8058296, size.height * 0.7994474),
        radius:
            Radius.elliptical(size.width * 0.1146585, size.height * 0.1103740),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.arcToPoint(Offset(size.width * 0.8334726, size.height * 0.7759793),
        radius: Radius.elliptical(
            size.width * 0.04836430, size.height * 0.04655708),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.cubicTo(
        size.width * 0.8401362,
        size.height * 0.7616888,
        size.width * 0.8385479,
        size.height * 0.7449553,
        size.width * 0.8387229,
        size.height * 0.7296497);
    path_2.lineTo(size.width * 0.8413481, size.height * 0.5234407);
    path_2.lineTo(size.width * 0.8439952, size.height * 0.3172569);
    path_2.lineTo(size.width * 0.8446427, size.height * 0.2668124);
    path_2.cubicTo(
        size.width * 0.8448308,
        size.height * 0.2522859,
        size.width * 0.8463053,
        size.height * 0.2367571,
        size.width * 0.8399043,
        size.height * 0.2231572);
    path_2.cubicTo(
        size.width * 0.8334332,
        size.height * 0.2094015,
        size.width * 0.8192748,
        size.height * 0.2028691,
        size.width * 0.8051646,
        size.height * 0.1983077);
    path_2.arcToPoint(Offset(size.width * 0.7567128, size.height * 0.1869359),
        radius:
            Radius.elliptical(size.width * 0.3023010, size.height * 0.2910049),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.arcToPoint(Offset(size.width * 0.7061521, size.height * 0.1828926),
        radius:
            Radius.elliptical(size.width * 0.3317728, size.height * 0.3193755),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.cubicTo(
        size.width * 0.6920724,
        size.height * 0.1828294,
        size.width * 0.6920549,
        size.height * 0.2038883,
        size.width * 0.7061521,
        size.height * 0.2039515);
    path_2.arcToPoint(Offset(size.width * 0.8009118, size.height * 0.2191139),
        radius:
            Radius.elliptical(size.width * 0.2949549, size.height * 0.2839333),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.8150264, size.height * 0.2257728),
        radius: Radius.elliptical(
            size.width * 0.04604103, size.height * 0.04432062),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.8225519, size.height * 0.2407667),
        radius: Radius.elliptical(
            size.width * 0.02258518, size.height * 0.02174124),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.8228494, size.height * 0.2604863),
        radius:
            Radius.elliptical(size.width * 0.1516689, size.height * 0.1460015),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.lineTo(size.width * 0.8225519, size.height * 0.2857191);
    path_2.lineTo(size.width * 0.8200405, size.height * 0.4813439);
    path_2.lineTo(size.width * 0.8175029, size.height * 0.6791378);
    path_2.lineTo(size.width * 0.8168816, size.height * 0.7275354);
    path_2.cubicTo(
        size.width * 0.8167853,
        size.height * 0.7350197,
        size.width * 0.8167678,
        size.height * 0.7425125,
        size.width * 0.8165797,
        size.height * 0.7499968);
    path_2.arcToPoint(Offset(size.width * 0.8124582, size.height * 0.7693289),
        radius: Radius.elliptical(
            size.width * 0.03988064, size.height * 0.03839042),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.cubicTo(
        size.width * 0.8075841,
        size.height * 0.7771123,
        size.width * 0.7979497,
        size.height * 0.7804312,
        size.width * 0.7888754,
        size.height * 0.7823434);
    path_2.arcToPoint(Offset(size.width * 0.7527138, size.height * 0.7848115),
        radius:
            Radius.elliptical(size.width * 0.1838229, size.height * 0.1769540),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.lineTo(size.width * 0.5483577, size.height * 0.7882399);
    path_2.cubicTo(
        size.width * 0.5155038,
        size.height * 0.7887916,
        size.width * 0.4826323,
        size.height * 0.7896508,
        size.width * 0.4497740,
        size.height * 0.7898698);
    path_2.cubicTo(
        size.width * 0.4272895,
        size.height * 0.7900214,
        size.width * 0.4041968,
        size.height * 0.7889095,
        size.width * 0.3828892,
        size.height * 0.7813873);
    path_2.arcToPoint(Offset(size.width * 0.3577445, size.height * 0.7658037),
        radius: Radius.elliptical(
            size.width * 0.06420718, size.height * 0.06180795),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.3439798, size.height * 0.7351419),
        radius: Radius.elliptical(
            size.width * 0.05788053, size.height * 0.05571771),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.3421860, size.height * 0.6919795),
        radius:
            Radius.elliptical(size.width * 0.3739024, size.height * 0.3599308),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.quadraticBezierTo(size.width * 0.3416959, size.height * 0.6668014,
        size.width * 0.3412322, size.height * 0.6416318);
    path_2.quadraticBezierTo(size.width * 0.3394514, size.height * 0.5440827,
        size.width * 0.3381695, size.height * 0.4465251);
    path_2.quadraticBezierTo(size.width * 0.3375219, size.height * 0.3972219,
        size.width * 0.3370056, size.height * 0.3479145);
    path_2.cubicTo(
        size.width * 0.3366688,
        size.height * 0.3154332,
        size.width * 0.3357587,
        size.height * 0.2828846,
        size.width * 0.3361306,
        size.height * 0.2504033);
    path_2.arcToPoint(Offset(size.width * 0.3386420, size.height * 0.2328064),
        radius: Radius.elliptical(
            size.width * 0.05158013, size.height * 0.04965274),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.arcToPoint(Offset(size.width * 0.3418753, size.height * 0.2272174),
        radius: Radius.elliptical(
            size.width * 0.02537660, size.height * 0.02442836),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.cubicTo(
        size.width * 0.3408734,
        size.height * 0.2285146,
        size.width * 0.3432142,
        size.height * 0.2257938,
        size.width * 0.3431135,
        size.height * 0.2258949);
    path_2.cubicTo(
        size.width * 0.3433979,
        size.height * 0.2256043,
        size.width * 0.3463381,
        size.height * 0.2230772,
        size.width * 0.3450824,
        size.height * 0.2240080);
    path_2.arcToPoint(Offset(size.width * 0.3668188, size.height * 0.2178083),
        radius: Radius.elliptical(
            size.width * 0.03736923, size.height * 0.03597286),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_2.cubicTo(
        size.width * 0.3878551,
        size.height * 0.2167385,
        size.width * 0.4089221,
        size.height * 0.2206344,
        size.width * 0.4298228,
        size.height * 0.2166795);
    path_2.arcToPoint(Offset(size.width * 0.4571201, size.height * 0.2035093),
        radius: Radius.elliptical(
            size.width * 0.05592478, size.height * 0.05383504),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_2.cubicTo(
        size.width * 0.4674895,
        size.height * 0.1942981,
        size.width * 0.4519923,
        size.height * 0.1794347,
        size.width * 0.4416491,
        size.height * 0.1886164);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = color;
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.5849000, size.height * 0.3187311);
    path_3.cubicTo(
        size.width * 0.5715730,
        size.height * 0.3054597,
        size.width * 0.5570295,
        size.height * 0.2924580,
        size.width * 0.5372095,
        size.height * 0.2900488);
    path_3.arcToPoint(Offset(size.width * 0.4934305, size.height * 0.3163051),
        radius: Radius.elliptical(
            size.width * 0.03981501, size.height * 0.03832725),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.cubicTo(
        size.width * 0.4803047,
        size.height * 0.3525812,
        size.width * 0.5110979,
        size.height * 0.3876064,
        size.width * 0.5361638,
        size.height * 0.4108133);
    path_3.quadraticBezierTo(size.width * 0.5468526, size.height * 0.4207068,
        size.width * 0.5584034, size.height * 0.4297032);
    path_3.cubicTo(
        size.width * 0.5663182,
        size.height * 0.4358650,
        size.width * 0.5747188,
        size.height * 0.4438885,
        size.width * 0.5858189,
        size.height * 0.4408392);
    path_3.arcToPoint(Offset(size.width * 0.6081896, size.height * 0.4280269),
        radius: Radius.elliptical(
            size.width * 0.07981379, size.height * 0.07683139),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.arcToPoint(Offset(size.width * 0.6292741, size.height * 0.4113356),
        radius:
            Radius.elliptical(size.width * 0.1995126, size.height * 0.1920574),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.cubicTo(
        size.width * 0.6528350,
        size.height * 0.3896744,
        size.width * 0.6733594,
        size.height * 0.3574669,
        size.width * 0.6677372,
        size.height * 0.3249013);
    path_3.cubicTo(
        size.width * 0.6647795,
        size.height * 0.3077720,
        size.width * 0.6517368,
        size.height * 0.2927107,
        size.width * 0.6326824,
        size.height * 0.2925380);
    path_3.cubicTo(
        size.width * 0.6093753,
        size.height * 0.2923274,
        size.width * 0.5967352,
        size.height * 0.3120133,
        size.width * 0.5777683,
        size.height * 0.3210602);
    path_3.cubicTo(
        size.width * 0.5651501,
        size.height * 0.3270746,
        size.width * 0.5762195,
        size.height * 0.3452443,
        size.width * 0.5888072,
        size.height * 0.3392425);
    path_3.cubicTo(
        size.width * 0.6018761,
        size.height * 0.3330090,
        size.width * 0.6110248,
        size.height * 0.3207654,
        size.width * 0.6244569,
        size.height * 0.3153111);
    path_3.arcToPoint(Offset(size.width * 0.6390922, size.height * 0.3155048),
        radius: Radius.elliptical(
            size.width * 0.01546223, size.height * 0.01488445),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.arcToPoint(Offset(size.width * 0.6452439, size.height * 0.3246865),
        radius: Radius.elliptical(
            size.width * 0.01827115, size.height * 0.01758842),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.cubicTo(
        size.width * 0.6516843,
        size.height * 0.3465878,
        size.width * 0.6378059,
        size.height * 0.3711552,
        size.width * 0.6225537,
        size.height * 0.3877243);
    path_3.arcToPoint(Offset(size.width * 0.5929987, size.height * 0.4126455),
        radius:
            Radius.elliptical(size.width * 0.1606383, size.height * 0.1546357),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_3.quadraticBezierTo(size.width * 0.5888334, size.height * 0.4153958,
        size.width * 0.5845281, size.height * 0.4179355);
    path_3.arcToPoint(Offset(size.width * 0.5802885, size.height * 0.4203657),
        radius: Radius.elliptical(
            size.width * 0.03617916, size.height * 0.03482725),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_3.lineTo(size.width * 0.5800041, size.height * 0.4205299);
    path_3.quadraticBezierTo(size.width * 0.5840337, size.height * 0.4216081,
        size.width * 0.5808048, size.height * 0.4200161);
    path_3.cubicTo(
        size.width * 0.5750907,
        size.height * 0.4145408,
        size.width * 0.5678583,
        size.height * 0.4101395,
        size.width * 0.5618030,
        size.height * 0.4049632);
    path_3.cubicTo(
        size.width * 0.5417686,
        size.height * 0.3878507,
        size.width * 0.5155432,
        size.height * 0.3652545,
        size.width * 0.5127649,
        size.height * 0.3378315);
    path_3.cubicTo(
        size.width * 0.5115267,
        size.height * 0.3256173,
        size.width * 0.5157488,
        size.height * 0.3111751,
        size.width * 0.5307035,
        size.height * 0.3106781);
    path_3.cubicTo(
        size.width * 0.5468308,
        size.height * 0.3101390,
        size.width * 0.5591734,
        size.height * 0.3234146,
        size.width * 0.5694203,
        size.height * 0.3336155);
    path_3.cubicTo(
        size.width * 0.5792209,
        size.height * 0.3433784,
        size.width * 0.5946832,
        size.height * 0.3284771,
        size.width * 0.5848869,
        size.height * 0.3187269);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = color;
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4640068, size.height * 0.4523963);
    path_4.arcToPoint(Offset(size.width * 0.4450706, size.height * 0.5285917),
        radius: Radius.elliptical(
            size.width * 0.04535849, size.height * 0.04366358),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.4602309,
        size.height * 0.5405111,
        size.width * 0.4829955,
        size.height * 0.5421579,
        size.width * 0.4955307,
        size.height * 0.5258077);
    path_4.arcToPoint(Offset(size.width * 0.5048281, size.height * 0.5031146),
        radius: Radius.elliptical(
            size.width * 0.05482221, size.height * 0.05277367),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.5013279, size.height * 0.4755106),
        radius: Radius.elliptical(
            size.width * 0.04799678, size.height * 0.04620329),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.4934130,
        size.height * 0.4595479,
        size.width * 0.4706310,
        size.height * 0.4507158,
        size.width * 0.4544512,
        size.height * 0.4607693);
    path_4.arcToPoint(Offset(size.width * 0.4654900, size.height * 0.4789558),
        radius: Radius.elliptical(
            size.width * 0.01093819, size.height * 0.01052946),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.4672401, size.height * 0.4779534),
        radius: Radius.elliptical(
            size.width * 0.01080693, size.height * 0.01040311),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.4680802,
        size.height * 0.4771111,
        size.width * 0.4656344,
        size.height * 0.4781682,
        size.width * 0.4668420,
        size.height * 0.4781050);
    path_4.arcToPoint(Offset(size.width * 0.4687540, size.height * 0.4775786),
        radius: Radius.elliptical(
            size.width * 0.009686861, size.height * 0.009324893),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.4703072,
        size.height * 0.4771195,
        size.width * 0.4684739,
        size.height * 0.4773595,
        size.width * 0.4682071,
        size.height * 0.4776080);
    path_4.cubicTo(
        size.width * 0.4686446,
        size.height * 0.4771869,
        size.width * 0.4708322,
        size.height * 0.4775828,
        size.width * 0.4714098,
        size.height * 0.4775870);
    path_4.cubicTo(
        size.width * 0.4737987,
        size.height * 0.4776080,
        size.width * 0.4700972,
        size.height * 0.4769636,
        size.width * 0.4713179,
        size.height * 0.4775870);
    path_4.arcToPoint(Offset(size.width * 0.4736980, size.height * 0.4781808),
        radius: Radius.elliptical(
            size.width * 0.01233390, size.height * 0.01187302),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.cubicTo(
        size.width * 0.4740480,
        size.height * 0.4782693,
        size.width * 0.4757675,
        size.height * 0.4787831,
        size.width * 0.4743368,
        size.height * 0.4783325);
    path_4.cubicTo(
        size.width * 0.4727180,
        size.height * 0.4778271,
        size.width * 0.4751506,
        size.height * 0.4787536,
        size.width * 0.4752994,
        size.height * 0.4788084);
    path_4.cubicTo(
        size.width * 0.4762926,
        size.height * 0.4793096,
        size.width * 0.4771807,
        size.height * 0.4799666,
        size.width * 0.4781564,
        size.height * 0.4804931);
    path_4.cubicTo(
        size.width * 0.4764063,
        size.height * 0.4795581,
        size.width * 0.4774083,
        size.height * 0.4798613,
        size.width * 0.4779245,
        size.height * 0.4803331);
    path_4.cubicTo(
        size.width * 0.4784408,
        size.height * 0.4808048,
        size.width * 0.4789615,
        size.height * 0.4812302,
        size.width * 0.4794515,
        size.height * 0.4817103);
    path_4.cubicTo(
        size.width * 0.4799415,
        size.height * 0.4821905,
        size.width * 0.4803966,
        size.height * 0.4826917,
        size.width * 0.4808516,
        size.height * 0.4832013);
    path_4.cubicTo(
        size.width * 0.4799284,
        size.height * 0.4821778,
        size.width * 0.4802347,
        size.height * 0.4823042,
        size.width * 0.4808516,
        size.height * 0.4833361);
    path_4.cubicTo(
        size.width * 0.4812323,
        size.height * 0.4839721,
        size.width * 0.4816042,
        size.height * 0.4845996,
        size.width * 0.4819804,
        size.height * 0.4852482);
    path_4.cubicTo(
        size.width * 0.4821642,
        size.height * 0.4855641,
        size.width * 0.4827417,
        size.height * 0.4870846,
        size.width * 0.4821248,
        size.height * 0.4854546);
    path_4.arcToPoint(Offset(size.width * 0.4833149, size.height * 0.4892452),
        radius: Radius.elliptical(
            size.width * 0.03400465, size.height * 0.03273400),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.4832886,
        size.height * 0.4891399,
        size.width * 0.4838968,
        size.height * 0.4922945,
        size.width * 0.4836649,
        size.height * 0.4907614);
    path_4.cubicTo(
        size.width * 0.4834330,
        size.height * 0.4892284,
        size.width * 0.4837787,
        size.height * 0.4924462,
        size.width * 0.4837699,
        size.height * 0.4923240);
    path_4.cubicTo(
        size.width * 0.4838618,
        size.height * 0.4940087,
        size.width * 0.4837393,
        size.height * 0.4956471,
        size.width * 0.4836955,
        size.height * 0.4973234);
    path_4.cubicTo(
        size.width * 0.4836955,
        size.height * 0.4976646,
        size.width * 0.4834768,
        size.height * 0.4994293,
        size.width * 0.4837305,
        size.height * 0.4975340);
    path_4.cubicTo(
        size.width * 0.4836387,
        size.height * 0.4982037,
        size.width * 0.4835074,
        size.height * 0.4988733,
        size.width * 0.4833761,
        size.height * 0.4995346);
    path_4.quadraticBezierTo(size.width * 0.4829386, size.height * 0.5017837,
        size.width * 0.4822561, size.height * 0.5039780);
    path_4.cubicTo(
        size.width * 0.4818185,
        size.height * 0.5054437,
        size.width * 0.4812891,
        size.height * 0.5068715,
        size.width * 0.4807422,
        size.height * 0.5083035);
    path_4.cubicTo(
        size.width * 0.4806197,
        size.height * 0.5086236,
        size.width * 0.4798672,
        size.height * 0.5101441,
        size.width * 0.4806547,
        size.height * 0.5085352);
    path_4.cubicTo(
        size.width * 0.4802172,
        size.height * 0.5094112,
        size.width * 0.4798059,
        size.height * 0.5102873,
        size.width * 0.4793421,
        size.height * 0.5111465);
    path_4.arcToPoint(Offset(size.width * 0.4772420, size.height * 0.5144317),
        radius: Radius.elliptical(
            size.width * 0.02811115, size.height * 0.02706072),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.4786902,
        size.height * 0.5125406,
        size.width * 0.4741793,
        size.height * 0.5167440,
        size.width * 0.4763144,
        size.height * 0.5153456);
    path_4.cubicTo(
        size.width * 0.4757938,
        size.height * 0.5156868,
        size.width * 0.4752513,
        size.height * 0.5159732,
        size.width * 0.4747131,
        size.height * 0.5162849);
    path_4.cubicTo(
        size.width * 0.4741749,
        size.height * 0.5165965,
        size.width * 0.4730067,
        size.height * 0.5167060,
        size.width * 0.4747700,
        size.height * 0.5162849);
    path_4.cubicTo(
        size.width * 0.4742231,
        size.height * 0.5164196,
        size.width * 0.4735318,
        size.height * 0.5166050,
        size.width * 0.4729892,
        size.height * 0.5167945);
    path_4.cubicTo(
        size.width * 0.4707578,
        size.height * 0.5175695,
        size.width * 0.4744024,
        size.height * 0.5169377,
        size.width * 0.4721886,
        size.height * 0.5169545);
    path_4.cubicTo(
        size.width * 0.4713966,
        size.height * 0.5169545,
        size.width * 0.4706135,
        size.height * 0.5170051,
        size.width * 0.4698172,
        size.height * 0.5169545);
    path_4.cubicTo(
        size.width * 0.4694803,
        size.height * 0.5169545,
        size.width * 0.4674676,
        size.height * 0.5167819,
        size.width * 0.4688896,
        size.height * 0.5169545);
    path_4.cubicTo(
        size.width * 0.4705610,
        size.height * 0.5171441,
        size.width * 0.4674939,
        size.height * 0.5166555,
        size.width * 0.4674983,
        size.height * 0.5166555);
    path_4.cubicTo(
        size.width * 0.4668726,
        size.height * 0.5165123,
        size.width * 0.4662469,
        size.height * 0.5163438,
        size.width * 0.4656344,
        size.height * 0.5161585);
    path_4.cubicTo(
        size.width * 0.4650219,
        size.height * 0.5159732,
        size.width * 0.4644137,
        size.height * 0.5157626,
        size.width * 0.4638099,
        size.height * 0.5155436);
    path_4.cubicTo(
        size.width * 0.4656869,
        size.height * 0.5162133,
        size.width * 0.4641731,
        size.height * 0.5156910,
        size.width * 0.4638099,
        size.height * 0.5154762);
    path_4.cubicTo(
        size.width * 0.4631317,
        size.height * 0.5150929,
        size.width * 0.4624317,
        size.height * 0.5147644,
        size.width * 0.4617623,
        size.height * 0.5143685);
    path_4.cubicTo(
        size.width * 0.4614910,
        size.height * 0.5142127,
        size.width * 0.4591371,
        size.height * 0.5126838,
        size.width * 0.4601915,
        size.height * 0.5134251);
    path_4.cubicTo(
        size.width * 0.4612460,
        size.height * 0.5141663,
        size.width * 0.4597540,
        size.height * 0.5130502,
        size.width * 0.4594959,
        size.height * 0.5128438);
    path_4.cubicTo(
        size.width * 0.4589140,
        size.height * 0.5123553,
        size.width * 0.4583496,
        size.height * 0.5118499,
        size.width * 0.4578026,
        size.height * 0.5113192);
    path_4.arcToPoint(Offset(size.width * 0.4553306, size.height * 0.5086615),
        radius: Radius.elliptical(
            size.width * 0.03696671, size.height * 0.03558537),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.4566432,
        size.height * 0.5102031,
        size.width * 0.4556019,
        size.height * 0.5089943,
        size.width * 0.4553787,
        size.height * 0.5086615);
    path_4.cubicTo(
        size.width * 0.4549762,
        size.height * 0.5080213,
        size.width * 0.4545256,
        size.height * 0.5073980,
        size.width * 0.4541318,
        size.height * 0.5067747);
    path_4.cubicTo(
        size.width * 0.4537380,
        size.height * 0.5061513,
        size.width * 0.4533574,
        size.height * 0.5054816,
        size.width * 0.4530030,
        size.height * 0.5048162);
    path_4.cubicTo(
        size.width * 0.4528761,
        size.height * 0.5045719,
        size.width * 0.4518435,
        size.height * 0.5023312,
        size.width * 0.4523948,
        size.height * 0.5036327);
    path_4.cubicTo(
        size.width * 0.4530117,
        size.height * 0.5050984,
        size.width * 0.4519573,
        size.height * 0.5023691,
        size.width * 0.4519573,
        size.height * 0.5023691);
    path_4.cubicTo(
        size.width * 0.4517604,
        size.height * 0.5018048,
        size.width * 0.4515810,
        size.height * 0.5012319,
        size.width * 0.4514191,
        size.height * 0.5006549);
    path_4.cubicTo(
        size.width * 0.4510910,
        size.height * 0.4995051,
        size.width * 0.4508460,
        size.height * 0.4983427,
        size.width * 0.4506228,
        size.height * 0.4971676);
    path_4.cubicTo(
        size.width * 0.4510603,
        size.height * 0.4994335,
        size.width * 0.4506884,
        size.height * 0.4974792,
        size.width * 0.4506228,
        size.height * 0.4968643);
    path_4.cubicTo(
        size.width * 0.4505703,
        size.height * 0.4961231,
        size.width * 0.4505397,
        size.height * 0.4953776,
        size.width * 0.4505441,
        size.height * 0.4946363);
    path_4.cubicTo(
        size.width * 0.4505441,
        size.height * 0.4940382,
        size.width * 0.4505441,
        size.height * 0.4934444,
        size.width * 0.4506009,
        size.height * 0.4928505);
    path_4.cubicTo(
        size.width * 0.4506578,
        size.height * 0.4922566,
        size.width * 0.4511829,
        size.height * 0.4896959,
        size.width * 0.4506403,
        size.height * 0.4921134);
    path_4.arcToPoint(Offset(size.width * 0.4517516, size.height * 0.4879016),
        radius: Radius.elliptical(
            size.width * 0.04489908, size.height * 0.04322134),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.4519398,
        size.height * 0.4873499,
        size.width * 0.4521892,
        size.height * 0.4868108,
        size.width * 0.4523642,
        size.height * 0.4862591);
    path_4.cubicTo(
        size.width * 0.4515635,
        size.height * 0.4884997,
        size.width * 0.4525523,
        size.height * 0.4859684,
        size.width * 0.4527536,
        size.height * 0.4855936);
    path_4.arcToPoint(Offset(size.width * 0.4550944, size.height * 0.4818493),
        radius: Radius.elliptical(
            size.width * 0.04423842, size.height * 0.04258536),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_4.cubicTo(
        size.width * 0.4561969,
        size.height * 0.4802278,
        size.width * 0.4552912,
        size.height * 0.4815545,
        size.width * 0.4550156,
        size.height * 0.4818788);
    path_4.cubicTo(
        size.width * 0.4555931,
        size.height * 0.4812007,
        size.width * 0.4561882,
        size.height * 0.4805352,
        size.width * 0.4568095,
        size.height * 0.4798993);
    path_4.cubicTo(
        size.width * 0.4578552,
        size.height * 0.4788337,
        size.width * 0.4589971,
        size.height * 0.4778607,
        size.width * 0.4601215,
        size.height * 0.4769005);
    path_4.cubicTo(
        size.width * 0.4584546,
        size.height * 0.4782946,
        size.width * 0.4599553,
        size.height * 0.4770310,
        size.width * 0.4604453,
        size.height * 0.4767025);
    path_4.quadraticBezierTo(size.width * 0.4613816, size.height * 0.4760834,
        size.width * 0.4623529, size.height * 0.4755190);
    path_4.cubicTo(
        size.width * 0.4630049,
        size.height * 0.4751484,
        size.width * 0.4636655,
        size.height * 0.4747946,
        size.width * 0.4643393,
        size.height * 0.4744661);
    path_4.cubicTo(
        size.width * 0.4647418,
        size.height * 0.4742639,
        size.width * 0.4651487,
        size.height * 0.4740701,
        size.width * 0.4655600,
        size.height * 0.4738890);
    path_4.quadraticBezierTo(size.width * 0.4639237, size.height * 0.4745208,
        size.width * 0.4650394, size.height * 0.4741038);
    path_4.cubicTo(
        size.width * 0.4666320,
        size.height * 0.4736026,
        size.width * 0.4681764,
        size.height * 0.4730972,
        size.width * 0.4698215,
        size.height * 0.4727392);
    path_4.arcToPoint(Offset(size.width * 0.4774608, size.height * 0.4597838),
        radius: Radius.elliptical(
            size.width * 0.01103007, size.height * 0.01061791),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.arcToPoint(Offset(size.width * 0.4640068, size.height * 0.4524300),
        radius: Radius.elliptical(
            size.width * 0.01117883, size.height * 0.01076111),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = color;
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4675683, size.height * 0.5843220);
    path_5.arcToPoint(Offset(size.width * 0.4486277, size.height * 0.6605175),
        radius: Radius.elliptical(
            size.width * 0.04535849, size.height * 0.04366358),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4637924,
        size.height * 0.6724368,
        size.width * 0.4865570,
        size.height * 0.6740836,
        size.width * 0.4990921,
        size.height * 0.6577335);
    path_5.arcToPoint(Offset(size.width * 0.5083896, size.height * 0.6350404),
        radius: Radius.elliptical(
            size.width * 0.05489659, size.height * 0.05284527),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.5048894, size.height * 0.6074363),
        radius: Radius.elliptical(
            size.width * 0.04802741, size.height * 0.04623277),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4969701,
        size.height * 0.5914737,
        size.width * 0.4741881,
        size.height * 0.5826415,
        size.width * 0.4580083,
        size.height * 0.5926951);
    path_5.arcToPoint(Offset(size.width * 0.4708103, size.height * 0.6098792),
        radius: Radius.elliptical(
            size.width * 0.01098194, size.height * 0.01057158),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4716548,
        size.height * 0.6090368,
        size.width * 0.4692046,
        size.height * 0.6100898,
        size.width * 0.4704122,
        size.height * 0.6100266);
    path_5.arcToPoint(Offset(size.width * 0.4723286, size.height * 0.6095043),
        radius: Radius.elliptical(
            size.width * 0.009424345, size.height * 0.009072186),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4738818,
        size.height * 0.6090452,
        size.width * 0.4720485,
        size.height * 0.6092853,
        size.width * 0.4717817,
        size.height * 0.6095338);
    path_5.cubicTo(
        size.width * 0.4722192,
        size.height * 0.6091126,
        size.width * 0.4744068,
        size.height * 0.6095085,
        size.width * 0.4749844,
        size.height * 0.6095338);
    path_5.cubicTo(
        size.width * 0.4773733,
        size.height * 0.6095338,
        size.width * 0.4736718,
        size.height * 0.6089105,
        size.width * 0.4748881,
        size.height * 0.6095338);
    path_5.arcToPoint(Offset(size.width * 0.4772726, size.height * 0.6101277),
        radius: Radius.elliptical(
            size.width * 0.01246079, size.height * 0.01199516),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.cubicTo(
        size.width * 0.4776226,
        size.height * 0.6102161,
        size.width * 0.4793421,
        size.height * 0.6107299,
        size.width * 0.4779070,
        size.height * 0.6102793);
    path_5.cubicTo(
        size.width * 0.4762926,
        size.height * 0.6097739,
        size.width * 0.4787208,
        size.height * 0.6107005,
        size.width * 0.4788740,
        size.height * 0.6107552);
    path_5.cubicTo(
        size.width * 0.4798628,
        size.height * 0.6112564,
        size.width * 0.4807553,
        size.height * 0.6119135,
        size.width * 0.4817267,
        size.height * 0.6124399);
    path_5.cubicTo(
        size.width * 0.4799765,
        size.height * 0.6115049,
        size.width * 0.4809785,
        size.height * 0.6118082,
        size.width * 0.4814991,
        size.height * 0.6122799);
    path_5.cubicTo(
        size.width * 0.4820198,
        size.height * 0.6127516,
        size.width * 0.4825361,
        size.height * 0.6131770,
        size.width * 0.4830261,
        size.height * 0.6136571);
    path_5.cubicTo(
        size.width * 0.4835161,
        size.height * 0.6141373,
        size.width * 0.4839668,
        size.height * 0.6146385,
        size.width * 0.4844262,
        size.height * 0.6151481);
    path_5.cubicTo(
        size.width * 0.4835030,
        size.height * 0.6141246,
        size.width * 0.4838093,
        size.height * 0.6142510,
        size.width * 0.4844262,
        size.height * 0.6152829);
    path_5.lineTo(size.width * 0.4855507, size.height * 0.6171950);
    path_5.cubicTo(
        size.width * 0.4857388,
        size.height * 0.6175109,
        size.width * 0.4863163,
        size.height * 0.6190314,
        size.width * 0.4856994,
        size.height * 0.6174014);
    path_5.arcToPoint(Offset(size.width * 0.4868895, size.height * 0.6211920),
        radius: Radius.elliptical(
            size.width * 0.03400465, size.height * 0.03273400),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.4868632,
        size.height * 0.6210825,
        size.width * 0.4874714,
        size.height * 0.6242414,
        size.width * 0.4872351,
        size.height * 0.6227083);
    path_5.cubicTo(
        size.width * 0.4869989,
        size.height * 0.6211752,
        size.width * 0.4873489,
        size.height * 0.6243930,
        size.width * 0.4873445,
        size.height * 0.6242666);
    path_5.cubicTo(
        size.width * 0.4874320,
        size.height * 0.6259513,
        size.width * 0.4873095,
        size.height * 0.6275939,
        size.width * 0.4872658,
        size.height * 0.6292702);
    path_5.cubicTo(
        size.width * 0.4872658,
        size.height * 0.6296114,
        size.width * 0.4870514,
        size.height * 0.6313551,
        size.width * 0.4873008,
        size.height * 0.6294808);
    path_5.cubicTo(
        size.width * 0.4872133,
        size.height * 0.6301505,
        size.width * 0.4870820,
        size.height * 0.6308202,
        size.width * 0.4869464,
        size.height * 0.6314814);
    path_5.quadraticBezierTo(size.width * 0.4865088, size.height * 0.6337305,
        size.width * 0.4858263, size.height * 0.6359248);
    path_5.cubicTo(
        size.width * 0.4853888,
        size.height * 0.6373905,
        size.width * 0.4848594,
        size.height * 0.6388183,
        size.width * 0.4843124,
        size.height * 0.6402461);
    path_5.cubicTo(
        size.width * 0.4841899,
        size.height * 0.6405704,
        size.width * 0.4834374,
        size.height * 0.6420909,
        size.width * 0.4842293,
        size.height * 0.6404820);
    path_5.cubicTo(
        size.width * 0.4837918,
        size.height * 0.6413580,
        size.width * 0.4833805,
        size.height * 0.6422341,
        size.width * 0.4829167,
        size.height * 0.6430933);
    path_5.arcToPoint(Offset(size.width * 0.4808210, size.height * 0.6463785),
        radius: Radius.elliptical(
            size.width * 0.02756424, size.height * 0.02653425),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.4822692,
        size.height * 0.6444874,
        size.width * 0.4777583,
        size.height * 0.6486866,
        size.width * 0.4798934,
        size.height * 0.6472925);
    path_5.cubicTo(
        size.width * 0.4793728,
        size.height * 0.6476336,
        size.width * 0.4788302,
        size.height * 0.6479200,
        size.width * 0.4782877,
        size.height * 0.6482317);
    path_5.cubicTo(
        size.width * 0.4777452,
        size.height * 0.6485434,
        size.width * 0.4765857,
        size.height * 0.6486529,
        size.width * 0.4783489,
        size.height * 0.6482317);
    path_5.cubicTo(
        size.width * 0.4778020,
        size.height * 0.6483622,
        size.width * 0.4771107,
        size.height * 0.6485518,
        size.width * 0.4765638,
        size.height * 0.6487413);
    path_5.cubicTo(
        size.width * 0.4743368,
        size.height * 0.6495163,
        size.width * 0.4779770,
        size.height * 0.6488845,
        size.width * 0.4757675,
        size.height * 0.6489014);
    path_5.cubicTo(
        size.width * 0.4749756,
        size.height * 0.6489014,
        size.width * 0.4741881,
        size.height * 0.6489519,
        size.width * 0.4733961,
        size.height * 0.6489014);
    path_5.cubicTo(
        size.width * 0.4730592,
        size.height * 0.6489014,
        size.width * 0.4710466,
        size.height * 0.6487287,
        size.width * 0.4724642,
        size.height * 0.6489014);
    path_5.cubicTo(
        size.width * 0.4741399,
        size.height * 0.6490909,
        size.width * 0.4710685,
        size.height * 0.6485981,
        size.width * 0.4710772,
        size.height * 0.6486023);
    path_5.cubicTo(
        size.width * 0.4704472,
        size.height * 0.6484549,
        size.width * 0.4698259,
        size.height * 0.6482906,
        size.width * 0.4692134,
        size.height * 0.6481053);
    path_5.cubicTo(
        size.width * 0.4686008,
        size.height * 0.6479200,
        size.width * 0.4679927,
        size.height * 0.6477094,
        size.width * 0.4673889,
        size.height * 0.6474904);
    path_5.cubicTo(
        size.width * 0.4692615,
        size.height * 0.6481601,
        size.width * 0.4677520,
        size.height * 0.6476378,
        size.width * 0.4673889,
        size.height * 0.6474230);
    path_5.cubicTo(
        size.width * 0.4667151,
        size.height * 0.6470397,
        size.width * 0.4660107,
        size.height * 0.6467112,
        size.width * 0.4653412,
        size.height * 0.6463153);
    path_5.cubicTo(
        size.width * 0.4650744,
        size.height * 0.6461553,
        size.width * 0.4627161,
        size.height * 0.6446306,
        size.width * 0.4637749,
        size.height * 0.6453677);
    path_5.cubicTo(
        size.width * 0.4648337,
        size.height * 0.6461047,
        size.width * 0.4633374,
        size.height * 0.6449928,
        size.width * 0.4630792,
        size.height * 0.6447907);
    path_5.cubicTo(
        size.width * 0.4624973,
        size.height * 0.6443021,
        size.width * 0.4619329,
        size.height * 0.6437967,
        size.width * 0.4613860,
        size.height * 0.6432660);
    path_5.arcToPoint(Offset(size.width * 0.4589096, size.height * 0.6406084),
        radius: Radius.elliptical(
            size.width * 0.03702359, size.height * 0.03564013),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.4602222,
        size.height * 0.6421499,
        size.width * 0.4591852,
        size.height * 0.6409411,
        size.width * 0.4589621,
        size.height * 0.6405873);
    path_5.cubicTo(
        size.width * 0.4585596,
        size.height * 0.6399471,
        size.width * 0.4581089,
        size.height * 0.6393238,
        size.width * 0.4577108,
        size.height * 0.6387004);
    path_5.cubicTo(
        size.width * 0.4573126,
        size.height * 0.6380771,
        size.width * 0.4569407,
        size.height * 0.6374074,
        size.width * 0.4565863,
        size.height * 0.6367419);
    path_5.cubicTo(
        size.width * 0.4564594,
        size.height * 0.6364976,
        size.width * 0.4554225,
        size.height * 0.6342570,
        size.width * 0.4559738,
        size.height * 0.6355584);
    path_5.cubicTo(
        size.width * 0.4565951,
        size.height * 0.6370199,
        size.width * 0.4555363,
        size.height * 0.6342949,
        size.width * 0.4555363,
        size.height * 0.6342949);
    path_5.cubicTo(
        size.width * 0.4553437,
        size.height * 0.6337263,
        size.width * 0.4551644,
        size.height * 0.6331577,
        size.width * 0.4549981,
        size.height * 0.6325807);
    path_5.cubicTo(
        size.width * 0.4546700,
        size.height * 0.6314309,
        size.width * 0.4544249,
        size.height * 0.6302642,
        size.width * 0.4542062,
        size.height * 0.6290933);
    path_5.cubicTo(
        size.width * 0.4546437,
        size.height * 0.6313593,
        size.width * 0.4542674,
        size.height * 0.6294050,
        size.width * 0.4542062,
        size.height * 0.6287901);
    path_5.cubicTo(
        size.width * 0.4541537,
        size.height * 0.6280488,
        size.width * 0.4541274,
        size.height * 0.6273033,
        size.width * 0.4541274,
        size.height * 0.6265620);
    path_5.cubicTo(
        size.width * 0.4541274,
        size.height * 0.6259640,
        size.width * 0.4541274,
        size.height * 0.6253701,
        size.width * 0.4541843,
        size.height * 0.6247762);
    path_5.cubicTo(
        size.width * 0.4542412,
        size.height * 0.6241824,
        size.width * 0.4547706,
        size.height * 0.6216216,
        size.width * 0.4542280,
        size.height * 0.6240392);
    path_5.arcToPoint(Offset(size.width * 0.4553394, size.height * 0.6198063),
        radius: Radius.elliptical(
            size.width * 0.04369588, size.height * 0.04206310),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.4555275,
        size.height * 0.6192546,
        size.width * 0.4557506,
        size.height * 0.6187155,
        size.width * 0.4559475,
        size.height * 0.6181637);
    path_5.cubicTo(
        size.width * 0.4551469,
        size.height * 0.6204044,
        size.width * 0.4561400,
        size.height * 0.6178731,
        size.width * 0.4563413,
        size.height * 0.6174983);
    path_5.arcToPoint(Offset(size.width * 0.4586777, size.height * 0.6137540),
        radius: Radius.elliptical(
            size.width * 0.04317523, size.height * 0.04156190),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_5.cubicTo(
        size.width * 0.4597803,
        size.height * 0.6121283,
        size.width * 0.4588746,
        size.height * 0.6134592,
        size.width * 0.4586033,
        size.height * 0.6137835);
    path_5.cubicTo(
        size.width * 0.4591765,
        size.height * 0.6131054,
        size.width * 0.4597715,
        size.height * 0.6124399,
        size.width * 0.4603972,
        size.height * 0.6118039);
    path_5.cubicTo(
        size.width * 0.4614385,
        size.height * 0.6107384,
        size.width * 0.4625848,
        size.height * 0.6097654,
        size.width * 0.4637093,
        size.height * 0.6088052);
    path_5.cubicTo(
        size.width * 0.4620423,
        size.height * 0.6101993,
        size.width * 0.4635430,
        size.height * 0.6089357,
        size.width * 0.4640330,
        size.height * 0.6086072);
    path_5.cubicTo(
        size.width * 0.4646543,
        size.height * 0.6081860,
        size.width * 0.4652931,
        size.height * 0.6077985,
        size.width * 0.4659407,
        size.height * 0.6074237);
    path_5.cubicTo(
        size.width * 0.4665882,
        size.height * 0.6070488,
        size.width * 0.4672532,
        size.height * 0.6066993,
        size.width * 0.4679270,
        size.height * 0.6063707);
    path_5.cubicTo(
        size.width * 0.4683252,
        size.height * 0.6061644,
        size.width * 0.4687321,
        size.height * 0.6059748,
        size.width * 0.4691477,
        size.height * 0.6057937);
    path_5.cubicTo(
        size.width * 0.4680583,
        size.height * 0.6062149,
        size.width * 0.4678833,
        size.height * 0.6062865,
        size.width * 0.4686227,
        size.height * 0.6060085);
    path_5.cubicTo(
        size.width * 0.4702197,
        size.height * 0.6055073,
        size.width * 0.4717642,
        size.height * 0.6050019,
        size.width * 0.4734093,
        size.height * 0.6046397);
    path_5.arcToPoint(Offset(size.width * 0.4810485, size.height * 0.5916885),
        radius: Radius.elliptical(
            size.width * 0.01102570, size.height * 0.01061370),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.arcToPoint(Offset(size.width * 0.4675945, size.height * 0.5843347),
        radius: Radius.elliptical(
            size.width * 0.01118321, size.height * 0.01076532),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = color;
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.5607485, size.height * 0.4995936);
    path_6.lineTo(size.width * 0.7236532, size.height * 0.4960178);
    path_6.cubicTo(
        size.width * 0.7377109,
        size.height * 0.4957061,
        size.width * 0.7377591,
        size.height * 0.4746472,
        size.width * 0.7236532,
        size.height * 0.4749588);
    path_6.lineTo(size.width * 0.5607485, size.height * 0.4785346);
    path_6.cubicTo(
        size.width * 0.5466951,
        size.height * 0.4788421,
        size.width * 0.5466426,
        size.height * 0.4999010,
        size.width * 0.5607485,
        size.height * 0.4995936);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = color;
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.5571870, size.height * 0.5389990);
    path_7.lineTo(size.width * 0.7200917, size.height * 0.5354232);
    path_7.cubicTo(
        size.width * 0.7341495,
        size.height * 0.5351158,
        size.width * 0.7342020,
        size.height * 0.5140526,
        size.width * 0.7200917,
        size.height * 0.5143643);
    path_7.lineTo(size.width * 0.5571870, size.height * 0.5179401);
    path_7.cubicTo(
        size.width * 0.5431337,
        size.height * 0.5182476,
        size.width * 0.5430812,
        size.height * 0.5393065,
        size.width * 0.5571870,
        size.height * 0.5389990);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = color;
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.5625293, size.height * 0.6195242);
    path_8.lineTo(size.width * 0.7254339, size.height * 0.6159483);
    path_8.cubicTo(
        size.width * 0.7394873,
        size.height * 0.6156409,
        size.width * 0.7395398,
        size.height * 0.5945820,
        size.width * 0.7254339,
        size.height * 0.5948894);
    path_8.lineTo(size.width * 0.5625293, size.height * 0.5984652);
    path_8.cubicTo(
        size.width * 0.5484715,
        size.height * 0.5987727,
        size.width * 0.5484234,
        size.height * 0.6198358,
        size.width * 0.5625293,
        size.height * 0.6195242);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = color;
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.5589678, size.height * 0.6589296);
    path_9.lineTo(size.width * 0.7218724, size.height * 0.6553538);
    path_9.cubicTo(
        size.width * 0.7359302,
        size.height * 0.6550464,
        size.width * 0.7359783,
        size.height * 0.6339874,
        size.width * 0.7218724,
        size.height * 0.6342949);
    path_9.lineTo(size.width * 0.5589678, size.height * 0.6378707);
    path_9.cubicTo(
        size.width * 0.5449144,
        size.height * 0.6381782,
        size.width * 0.5448619,
        size.height * 0.6592413,
        size.width * 0.5589678,
        size.height * 0.6589296);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = color;
    canvas.drawPath(path_9, paint_9_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
