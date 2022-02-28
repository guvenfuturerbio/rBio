import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';

class SmallChronicComponent extends StatelessWidget {
  final String imageUrl;
  final String lastMeasurement;
  final DateTime lastMeasurementDate;
  final Function() callback;

  const SmallChronicComponent({
    Key? key,
    required this.imageUrl,
    required this.lastMeasurementDate,
    required this.lastMeasurement,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: callback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: SvgPicture.asset(
              imageUrl,
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              height: Atom.height * .1,
            ),
          ),

          //
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Text(
                    lastMeasurementDate.xFormatTime10(),
                    style: context.xHeadline3,
                  ),

                  //
                  Text(
                    lastMeasurement.length == 1
                        ? LocaleProvider.current.no_measurement
                        : lastMeasurement,
                    style: context.xHeadline4,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
