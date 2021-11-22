import 'package:atom/atom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/core/extension/extension.dart';
import 'package:path/path.dart';

class RbioSmallChronicWidget extends StatelessWidget {
  final String imageUrl;
  final String lastMeasurement;
  final DateTime lastMeasurementDate;
  final Function() callback;

  const RbioSmallChronicWidget(
      {Key key,
      this.imageUrl,
      this.lastMeasurementDate,
      this.lastMeasurement,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: callback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: SvgPicture.asset(
              imageUrl,
              height: Atom.height * .1,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd').format(lastMeasurementDate),
                    style: context.xHeadline3,
                  ),
                  Text(
                    '${lastMeasurement.length == 1 ? 'NoLastMeasurement' : lastMeasurement}',
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
