import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/core/utils/stacked_widget/stacked_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../utils/gallery_pop_up/gallery_pop_up.dart';
import '../view_model/scale_progress_page_view_model.dart';
import 'scale_measurements/scale_measurement_vm.dart';
import 'scale_tagger/scale_tagger_pop_up.dart';

class ScaleMeasurementListWidget extends StatefulWidget {
  final List<ScaleMeasurementViewModel>? scaleMeasurements;
  final ScrollController scrollController;
  final bool? useStickyGroupSeparatorsValue;

  const ScaleMeasurementListWidget({
    Key? key,
    this.scaleMeasurements,
    required this.scrollController,
    this.useStickyGroupSeparatorsValue,
  }) : super(key: key);

  @override
  _ScaleMeasurementListWidgetState createState() =>
      _ScaleMeasurementListWidgetState();
}

class _ScaleMeasurementListWidgetState
    extends State<ScaleMeasurementListWidget> {
  @override
  Widget build(BuildContext context) {
    var list = <ScaleMeasurementViewModel>[];
    if (widget.scaleMeasurements != null) {
      list = widget.scaleMeasurements!
          .where((element) =>
              element.getMeasurement(Provider.of<ScaleProgressPageViewModel>(
                      context,
                      listen: false)
                  .currentScaleType) !=
              null)
          .toList();
    }
    return Column(
      children: [
        Expanded(
          child: list.isEmpty
              ? Center(child: Text(LocaleProvider.current.no_measurement))
              : GroupedListView<ScaleMeasurementViewModel, DateTime>(
                  elements: list,
                  scrollDirection: Axis.vertical,
                  order: GroupedListOrder.DESC,
                  controller: widget.scrollController,
                  floatingHeader: true,
                  padding: EdgeInsets.only(
                      bottom: 2 * (context.height * .1) * context.textScale),
                  useStickyGroupSeparators:
                      widget.useStickyGroupSeparatorsValue ?? false,
                  groupBy:
                      (ScaleMeasurementViewModel scaleMeasurementViewModel) =>
                          DateTime(
                              scaleMeasurementViewModel.dateTime.year,
                              scaleMeasurementViewModel.dateTime.month,
                              scaleMeasurementViewModel.dateTime.day),
                  groupHeaderBuilder:
                      (ScaleMeasurementViewModel scaleMeasurementViewModel) {
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
                            DateFormat.yMMMMEEEEd(Intl.getCurrentLocale())
                                .format(scaleMeasurementViewModel.dateTime),
                          ),
                        ),
                      ),
                    );
                  },
                  itemBuilder:
                      (_, ScaleMeasurementViewModel scaleMeasurementViewModel) {
                    return measurementList(scaleMeasurementViewModel, context);
                  },
                  callback: (ScaleMeasurementViewModel data) {
                    if (Provider.of<ScaleProgressPageViewModel>(context,
                            listen: false)
                        .isChartShow) {
                      Provider.of<ScaleProgressPageViewModel>(context,
                              listen: false)
                          .fetchScrolledData(data.dateTime);
                    }
                  },
                ),
        ),
      ],
    );
  }
}

Widget measurementList(
    ScaleMeasurementViewModel scaleMeasurementViewModel, BuildContext context) {
  return Slidable(
    actionPane: const SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    child: GestureDetector(
      onTap: () {
        Atom.show(
            ScaleTagger(
              scaleModel: scaleMeasurementViewModel.scaleModel,
              isUpdate: true,
            ),
            barrierDismissible: false,
            barrierColor: Colors.transparent);
      },
      child: Row(
        children: [
          Text(DateFormat("kk : mm").format(scaleMeasurementViewModel.dateTime),
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
                  _textAndScaleSection(scaleMeasurementViewModel, context),
                  _timeAndImageSection(scaleMeasurementViewModel, context)
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: LocaleProvider.current.delete,
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          try {
            getIt<ScaleStorageImpl>()
                .delete(scaleMeasurementViewModel.scaleModel.key);
          } catch (e) {
            LoggerUtils.instance.e(e);
          }
        },
      ),
    ],
  );
}

Widget _timeAndImageSection(
  ScaleMeasurementViewModel scaleMeasurementViewModel,
  BuildContext context,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      if (scaleMeasurementViewModel.isManuel)
        Text(
          "M",
          style: context.xHeadline3.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),

      //
      (scaleMeasurementViewModel.imageUrl.isEmpty)
          ? SizedBox(
              width: 60 * context.textScale,
              height: 60 * context.textScale,
              child: Card(
                elevation: R.sizes.defaultElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 25,
                  width: 25,
                  child: SvgPicture.asset(
                    R.image.addphotoIcon,
                  ),
                ),
              ),
            )
          : GestureDetector(
              onTap: () =>
                  _galeryView(context, scaleMeasurementViewModel.imageUrl),
              child: SizedBox(
                width: 60 * context.textScale,
                height: 60 * context.textScale,
                child: StackOfCards(
                  children: [
                    ...scaleMeasurementViewModel.imageUrl.map(
                      (e) => Card(
                        elevation: R.sizes.defaultElevation,
                        shape: RoundedRectangleBorder(
                          borderRadius: R.sizes.borderRadiusCircular,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: R.sizes.borderRadiusCircular,
                            child: Image(
                              image: FileImage(
                                File(
                                  getIt<ScaleStorageImpl>()
                                      .getImagePathOfImageURL(e),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ],
  );
}

Expanded _textAndScaleSection(
    ScaleMeasurementViewModel scaleMeasurementViewModel, BuildContext context) {
  return Expanded(
    flex: 4,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  scaleMeasurementViewModel
                          .getMeasurement(
                              Provider.of<ScaleProgressPageViewModel>(context)
                                  .currentScaleType)
                          ?.toStringAsFixed(2) ??
                      '',
                  style: context.xHeadline1),
              Text(scaleMeasurementViewModel.unit.toStr,
                  style: context.xBodyText1),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(scaleMeasurementViewModel.note),
        ),
      ],
    ),
  );
}

Future<dynamic> _galeryView(BuildContext context, List<String> images) {
  return Atom.show(
    GalleryView(
      images: [
        ...images
            .map((e) => getIt<ScaleStorageImpl>().getImagePathOfImageURL(e))
            .toList()
      ],
    ),
    barrierColor: Colors.transparent,
    barrierDismissible: false,
  );
}
