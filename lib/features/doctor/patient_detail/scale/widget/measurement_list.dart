import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../../../core/core.dart';
import '../../../../../core/data/service/model/patient_scale_measurement.dart';
import 'tagger_popup.dart';

class MeasurementList extends StatefulWidget {
  final List<PatientScaleMeasurement> scaleMeasurements;

  final bool? useStickyGroupSeparatorsValue;
  const MeasurementList({
    required this.scaleMeasurements,
    this.useStickyGroupSeparatorsValue,
  });

  @override
  MeasurementListState createState() => MeasurementListState();
}

class MeasurementListState extends State<MeasurementList> {
  @override
  Widget build(BuildContext context) {
    var list = <PatientScaleMeasurement>[];
    if (widget.scaleMeasurements.isNotEmpty) {
      list = widget.scaleMeasurements;
    }
    return Expanded(
      child: list.isEmpty
          ? Center(child: Text(LocaleProvider.current.no_measurement))
          : GroupedListView<PatientScaleMeasurement, DateTime>(
              elements: list,
              scrollDirection: Axis.vertical,
              order: GroupedListOrder.DESC,
              floatingHeader: true,
              padding: EdgeInsets.only(
                  bottom: 2 * (context.height * .1) * context.textScale),
              useStickyGroupSeparators: true,
              groupBy: (PatientScaleMeasurement scaleMeasurement) =>
                  DateTime.parse(scaleMeasurement.occurrenceTime!),
              groupHeaderBuilder: (PatientScaleMeasurement scaleMeasurement) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: (context.height * .07) * context.textScale,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 5,
                            spreadRadius: 0,
                            offset: const Offset(5, 5))
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(
                            DateTime.parse(scaleMeasurement.occurrenceTime!)),
                      ),
                    ),
                  ),
                );
              },
              itemBuilder: (_, PatientScaleMeasurement scaleMeasurement) {
                return measurementList(scaleMeasurement, context);
              },
            ),
    );
  }

  Widget measurementList(
      PatientScaleMeasurement scaleMeasurement, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Atom.show(ScaleTagger(
          scaleModel: scaleMeasurement,
        ));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              DateFormat("kk : mm")
                  .format(DateTime.parse(scaleMeasurement.occurrenceTime!)),
              style: context.xBodyText1),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: (context.height * .08) * context.textScale,
              margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                color: Colors.green,
                gradient: const LinearGradient(
                    colors: [Colors.white, Colors.white],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: const Offset(5, 5))
                ],
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textAndScaleSection(scaleMeasurement, context),
                  _manualIcon(scaleMeasurement, context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _manualIcon(
      PatientScaleMeasurement scaleMeasurement, BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (scaleMeasurement.isManuel!)
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                "M",
                style: context.xHeadline3.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
        ]);
  }

  Expanded _textAndScaleSection(
    PatientScaleMeasurement scaleMeasurement,
    BuildContext context,
  ) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    scaleMeasurement.weight!.toStringAsFixed(2) +
                        ' ' +
                        scaleMeasurement.scaleUnit!.getScaleUnit(),
                    style: context.xHeadline1),
                Text(', BMI: ' + scaleMeasurement.bmi!.toStringAsFixed(2),
                    style: context.xHeadline1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
