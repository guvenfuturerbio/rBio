import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../../core/core.dart';
import '../viewmodel/scale_progress_vm.dart';
import 'tagger/scale_tagger_pop_up.dart';

class ScaleMeasurementList extends StatelessWidget {
  final List<ScaleEntity>? scaleMeasurements;
  final ScrollController scrollController;
  final bool? useStickyGroupSeparatorsValue;

  const ScaleMeasurementList({
    Key? key,
    this.scaleMeasurements,
    required this.scrollController,
    this.useStickyGroupSeparatorsValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <ScaleEntity>[];
    if (scaleMeasurements != null) {
      list = scaleMeasurements!
          .where((element) =>
              element.getMeasurement(
                  Provider.of<ScaleProgressVm>(context, listen: false)
                      .currentScaleType) !=
              null)
          .toList();
    }

    return list.isEmpty
        ? Center(child: Text(LocaleProvider.current.no_measurement))
        : GroupedListView<ScaleEntity, DateTime>(
            elements: list,
            scrollDirection: Axis.vertical,
            order: GroupedListOrder.DESC,
            controller: scrollController,
            floatingHeader: true,
            padding: EdgeInsets.only(
              bottom: 2 * (context.height * .1) * context.textScale,
            ),
            useStickyGroupSeparators: useStickyGroupSeparatorsValue ?? false,
            groupBy: (ScaleEntity scaleMeasurementViewModel) => DateTime(
              scaleMeasurementViewModel.dateTime.year,
              scaleMeasurementViewModel.dateTime.month,
              scaleMeasurementViewModel.dateTime.day,
            ),
            groupHeaderBuilder: (ScaleEntity scaleMeasurementViewModel) {
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
            itemBuilder: (_, ScaleEntity scaleMeasurementViewModel) {
              return measurementList(context, scaleMeasurementViewModel);
            },
            callback: (ScaleEntity data) {
              if (Provider.of<ScaleProgressVm>(context, listen: false)
                  .isChartShow) {
                Provider.of<ScaleProgressVm>(context, listen: false)
                    .fetchScrolledData(data.dateTime);
              }
            },
          );
  }
}

Widget measurementList(
  BuildContext context,
  ScaleEntity scaleMeasurementViewModel,
) {
  return Slidable(
    actionPane: const SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    child: GestureDetector(
      onTap: () {
        Atom.show(
          ScaleTaggerPopUp(
            scaleModel: scaleMeasurementViewModel,
            isUpdate: true,
          ),
          barrierDismissible: false,
          barrierColor: Colors.transparent,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Text(
            DateFormat("kk : mm").format(scaleMeasurementViewModel.dateTime),
            style: context.xBodyText1,
          ),

          //
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: (context.height * .08) * context.textScale,
              margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                color: getIt<ITheme>().cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
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
            // TODO
            // getIt<ScaleStorageImpl>().delete(scaleMeasurementViewModel.scaleModel.key);
          } catch (e) {
            LoggerUtils.instance.e(e);
          }
        },
      ),
    ],
  );
}

Widget _timeAndImageSection(
  ScaleEntity scaleMeasurementViewModel,
  BuildContext context,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      if (scaleMeasurementViewModel.isManuel) ...[
        Text(
          "M",
          style: context.xHeadline3.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
      ],

      //
      (scaleMeasurementViewModel.images.isEmpty)
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
                  _galeryView(context, scaleMeasurementViewModel.images),
              child: SizedBox(
                width: 60 * context.textScale,
                height: 60 * context.textScale,
                child: StackOfCards(
                  children: [
                    ...scaleMeasurementViewModel.images.map(
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
                                File(e),
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
  ScaleEntity scaleMeasurementViewModel,
  BuildContext context,
) {
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
                          .getMeasurement(Provider.of<ScaleProgressVm>(context)
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
