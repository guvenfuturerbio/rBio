import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../extension/size_extension.dart';
import '../models/bg_measurements_view_model.dart';
import '../pages/patient_detail_page/patient_detail_page_view_model.dart';
import '../resources/resources.dart';

class BgMeasurementListWidget extends StatefulWidget {
  final List<BgMeasurementViewModel> bgMeasurements;
  final ScrollController scrollController;
  final bool useStickyGroupSeparatorsValue;
  BgMeasurementListWidget(
      {this.bgMeasurements,
      this.scrollController,
      this.useStickyGroupSeparatorsValue});
  @override
  _BgMeasurementListWidgetState createState() =>
      _BgMeasurementListWidgetState();
}

class _BgMeasurementListWidgetState extends State<BgMeasurementListWidget> {
  @override
  Widget build(BuildContext context) {
    return GroupedListView<BgMeasurementViewModel, DateTime>(
      elements: widget.bgMeasurements ?? <BgMeasurementViewModel>[],
      order: GroupedListOrder.DESC,
      padding: EdgeInsets.zero,
      controller: widget.scrollController,
      scrollDirection: Axis.vertical,
      reverse: false,
      floatingHeader: true,
      shrinkWrap: false,
      useStickyGroupSeparators: true,
      groupBy: (BgMeasurementViewModel bgMeasurementViewModel) => DateTime(
          bgMeasurementViewModel.date.year,
          bgMeasurementViewModel.date.month,
          bgMeasurementViewModel.date.day),
      groupHeaderBuilder: (BgMeasurementViewModel bgMeasurementViewModel) {
        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: (context.HEIGHT * .05) * context.TEXTSCALE,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(5, 5))
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(bgMeasurementViewModel.date)}',
              ),
            ),
          ),
        );
      },
      itemBuilder: (_, BgMeasurementViewModel bgMeasurementViewModel) {
        return measurementList(bgMeasurementViewModel, context);
      },
      callback: (BgMeasurementViewModel data) {
        Provider.of<PatientDetailPageViewModel>(context, listen: false)
            .fetchScrolledData(data.date);
      },
    );
  }
}

Widget measurementList(
    BgMeasurementViewModel bgMeasurementViewModel, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
    decoration: BoxDecoration(
      color: Colors.green,
      gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(5, 5))
      ],
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
    ),
    padding: const EdgeInsets.all(10),
    height: (context.HEIGHT * .1) * context.TEXTSCALE,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: (context.HEIGHT * .07) * context.TEXTSCALE,
                height: (context.HEIGHT * .07) * context.TEXTSCALE,
                decoration: measurementListBoxDecoration(
                    bgMeasurementViewModel), //             <--- BoxDecoration here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(bgMeasurementViewModel.result),
                    Text(
                      "mg/dL",
                      style: TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 16),
                      width: (context.HEIGHT * .03) * context.TEXTSCALE,
                      height: (context.HEIGHT * .03) * context.TEXTSCALE,
                      child: SvgPicture.asset(bgMeasurementViewModel.tag == 1
                          ? R.image.beforeMeal
                          : bgMeasurementViewModel.tag == 2
                              ? R.image.afterMeal
                              : R.image.other),
                    ),
                    Expanded(
                      child: Text(bgMeasurementViewModel.note == null
                          ? ""
                          : (bgMeasurementViewModel.note.length > 10
                              ? "${bgMeasurementViewModel.note.substring(0, 10)}..."
                              : bgMeasurementViewModel.note)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*Icon(Icons.timer),*/
              Text(DateFormat("kk : mm").format(bgMeasurementViewModel.date)),
            ],
          ),
        )
      ],
    ),
  );
}

BoxDecoration measurementListBoxDecoration(
    BgMeasurementViewModel bgMeasurementViewModel) {
  return BoxDecoration(
    shape: bgMeasurementViewModel.tag == 1 || bgMeasurementViewModel.tag == 2
        ? BoxShape.circle
        : BoxShape.rectangle,
    color: bgMeasurementViewModel.tag == 1
        ? Colors.transparent
        : bgMeasurementViewModel.resultColor,
    border: Border.all(
      color: bgMeasurementViewModel
          .resultColor, //                   <--- border color
      width: 5.0,
    ),
  );
}
