import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../../../model/bg_measurement/bg_measurement_view_model.dart';
import '../view_model/bg_progress_page_view_model.dart';
import 'blood_glucose_tagger/bg_tagger_pop_up.dart';

class BgMeasurementListWidget extends StatefulWidget {
  final List<BgMeasurementGlucoseViewModel> bgMeasurements;
  final ScrollController scrollController;
  final bool? useStickyGroupSeparatorsValue;

  const BgMeasurementListWidget({
    Key? key,
    required this.bgMeasurements,
    required this.scrollController,
    this.useStickyGroupSeparatorsValue,
  }) : super(key: key);

  @override
  _BgMeasurementListWidgetState createState() =>
      _BgMeasurementListWidgetState();
}

class _BgMeasurementListWidgetState extends State<BgMeasurementListWidget> {
  @override
  Widget build(BuildContext context) {
    return GroupedListView<BgMeasurementGlucoseViewModel, DateTime>(
      elements: widget.bgMeasurements,
      order: GroupedListOrder.DESC,
      controller: widget.scrollController,
      scrollDirection: Axis.vertical,
      floatingHeader: true,
      padding: EdgeInsets.zero,
      useStickyGroupSeparators: widget.useStickyGroupSeparatorsValue ?? false,
      groupBy: (BgMeasurementGlucoseViewModel bgMeasurementViewModel) =>
          DateTime(
              bgMeasurementViewModel.date.year,
              bgMeasurementViewModel.date.month,
              bgMeasurementViewModel.date.day),
      groupHeaderBuilder:
          (BgMeasurementGlucoseViewModel bgMeasurementViewModel) {
        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: (context.height * .07) * context.textScale,
          child: Container(
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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                DateFormat.yMMMMEEEEd(Intl.getCurrentLocale())
                    .format(bgMeasurementViewModel.date),
              ),
            ),
          ),
        );
      },
      itemBuilder: (_, BgMeasurementGlucoseViewModel bgMeasurementViewModel) {
        return measurementList(bgMeasurementViewModel, context);
      },
      callback: (BgMeasurementGlucoseViewModel data) {
        if (Provider.of<BgProgressPageViewModel>(context, listen: false)
            .isChartShow) {
          Provider.of<BgProgressPageViewModel>(context, listen: false)
              .fetchScrolledData(data.date);
        }
      },
    );
  }
}

Widget measurementList(BgMeasurementGlucoseViewModel bgMeasurementViewModel,
    BuildContext context) {
  return Slidable(
    actionPane: const SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    child: GestureDetector(
      onTap: () {
        Atom.show(
            BgTaggerPopUp(
              data: bgMeasurementViewModel.bgMeasurement,
              isEdit: true,
            ),
            barrierColor: Colors.transparent,
            barrierDismissible: false);
      },
      child: Container(
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
        height: context.height * .1 * context.textScale,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: (context.height * .1) * context.textScale,
                    height: (context.height * .1) * context.textScale,
                    decoration: measurementListBoxDecoration(
                        bgMeasurementViewModel), //             <--- BoxDecoration here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bgMeasurementViewModel.result,
                          style: context.xHeadline2,
                        ),
                        Text(
                          "mg/dL",
                          style: context.xCaption,
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
                          margin: const EdgeInsets.only(left: 8, right: 16),
                          width: (context.height * .05) * context.textScale,
                          height: (context.height * .05) * context.textScale,
                          child: SvgPicture.asset(
                            bgMeasurementViewModel.tag == 1
                                ? R.image.beforeMealIconBlack
                                : bgMeasurementViewModel.tag == 2
                                    ? R.image.aftermealIconBlack
                                    : R.image.otherIcon,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (bgMeasurementViewModel.note.length > 10
                                ? "${bgMeasurementViewModel.note.substring(0, 10)}..."
                                : bgMeasurementViewModel.note),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                (bgMeasurementViewModel.imageURL == "")
                    ? Container()
                    : SizedBox(
                        width: 60,
                        height: 60,
                        child: Card(
                          elevation: R.sizes.defaultElevation,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 25,
                            width: 25,
                            child: bgMeasurementViewModel.imageURL == null ||
                                    bgMeasurementViewModel.imageURL == "" ||
                                    Atom.isWeb
                                ? SvgPicture.asset(
                                    R.image.addphotoIcon,
                                  )
                                : PhotoView(
                                    imageProvider: FileImage(File(
                                        getIt<GlucoseStorageImpl>()
                                            .getImagePathOfImageURL(
                                                bgMeasurementViewModel
                                                    .imageURL!))),
                                  ),
                          ),
                        ),
                      ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (bgMeasurementViewModel.isManual)
                        Text(
                          "M",
                          style: context.xHeadline3.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      Text(
                        DateFormat("kk : mm")
                            .format(bgMeasurementViewModel.date),
                        style: context.xBodyText1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: LocaleProvider.current.delete,
        color: Colors.red,
        icon: Icons.delete,
        onTap: () async {
          //_showSnackBar('Delete')

          /// MGH1
          await getIt<GlucoseStorageImpl>()
              .delete(bgMeasurementViewModel.bgMeasurement.key);
        },
      ),
    ],
  );
}

BoxDecoration measurementListBoxDecoration(
    BgMeasurementGlucoseViewModel bgMeasurementViewModel) {
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
