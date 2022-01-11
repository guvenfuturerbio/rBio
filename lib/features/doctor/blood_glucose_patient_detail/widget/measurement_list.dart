part of '../view/blood_glucose_patient_detail_screen.dart';

class _MeasurementList extends StatefulWidget {
  final List<BgMeasurementViewModel> bgMeasurements;
  final ScrollController scrollController;
  final bool useStickyGroupSeparatorsValue;

  _MeasurementList({
    this.bgMeasurements,
    this.scrollController,
    this.useStickyGroupSeparatorsValue,
  });

  @override
  __MeasurementListState createState() => __MeasurementListState();
}

class __MeasurementListState extends State<_MeasurementList> {
  @override
  Widget build(BuildContext context) {
    return GroupedListView<BgMeasurementViewModel, DateTime>(
      elements: widget.bgMeasurements ?? <BgMeasurementViewModel>[],
      order: GroupedListOrder.DESC,
      controller: widget.scrollController,
      scrollDirection: Axis.vertical,
      floatingHeader: true,
      padding: EdgeInsets.zero,
      useStickyGroupSeparators: widget.useStickyGroupSeparatorsValue ?? false,
      groupBy: (BgMeasurementViewModel bgMeasurementViewModel) => DateTime(
        bgMeasurementViewModel.date.year,
        bgMeasurementViewModel.date.month,
        bgMeasurementViewModel.date.day,
      ),
      groupHeaderBuilder: (BgMeasurementViewModel bgMeasurementViewModel) {
        return Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: (context.HEIGHT * .1) * context.TEXTSCALE,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: R.sizes.borderRadiusCircular,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(bgMeasurementViewModel.date)}',
                style: context.xBodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
      itemBuilder: (BuildContext context,
          BgMeasurementViewModel bgMeasurementViewModel) {
        return _buildCard(bgMeasurementViewModel, context);
      },
      callback: (BgMeasurementViewModel data) {
        var prov =
            Provider.of<BloodGlucosePatientDetailVm>(context, listen: false);

        if (prov.selected == TimePeriodFilter.DAILY.toShortString()) {
          prov.fetchScrolledData(data.date);
        }
      },
    );
  }
}

Widget _buildCard(
  BgMeasurementViewModel bgMeasurementViewModel,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () => showDialog(
      context: context,
      builder: (BuildContext context) {
        return _TaggerPopUp(
          data: bgMeasurementViewModel,
        );
      },
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Text(
          DateFormat("kk : mm").format(bgMeasurementViewModel.date),
          style: context.xBodyText1.copyWith(
            color: getIt<ITheme>().textColorPassive,
          ),
        ),

        //
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: (context.HEIGHT * .08) * context.TEXTSCALE,
            margin: const EdgeInsets.only(left: 4, right: 8, top: 8),
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //
                      Container(
                        alignment: Alignment.center,
                        width: (context.HEIGHT * .05) * context.TEXTSCALE,
                        height: (context.HEIGHT * .05) * context.TEXTSCALE,
                        decoration: measurementListBoxDecoration(
                            bgMeasurementViewModel),
                        child: Text(
                          bgMeasurementViewModel.result,
                          maxLines: 2,
                          style: context.xHeadline5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      //
                      SizedBox(
                        width: 12,
                      ),

                      //
                      SizedBox(
                        width: (context.HEIGHT * .02),
                        height: (context.HEIGHT * .02),
                        child: SvgPicture.asset(
                          bgMeasurementViewModel.tag == 1
                              ? R.image.beforeMeal
                              : bgMeasurementViewModel.tag == 2
                                  ? R.image.afterMeal
                                  : R.image.other,
                        ),
                      ),

                      //
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            //
                            Expanded(
                              child: Text(
                                bgMeasurementViewModel.note == null
                                    ? ""
                                    : (bgMeasurementViewModel.note.length > 10
                                        ? "${bgMeasurementViewModel.note.substring(0, 10)}..."
                                        : bgMeasurementViewModel.note),
                                style: context.xHeadline5,
                              ),
                            ),

                            //
                            Expanded(
                              child: Text(
                                bgMeasurementViewModel.isManual ? 'M' : 'A',
                                style: context.xHeadline5,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //
                      SizedBox(width: 8),

                      //
                      if (bgMeasurementViewModel.imageURL != null &&
                          bgMeasurementViewModel.imageURL != '') ...[
                        Image.network(bgMeasurementViewModel.imageURL),
                      ] else ...[
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

BoxDecoration measurementListBoxDecoration(
  BgMeasurementViewModel bgMeasurementViewModel,
) {
  return BoxDecoration(
    shape: bgMeasurementViewModel.tag == 1 || bgMeasurementViewModel.tag == 2
        ? BoxShape.circle
        : BoxShape.rectangle,
    color: bgMeasurementViewModel.tag == 1
        ? Colors.transparent
        : bgMeasurementViewModel.resultColor,
    border: Border.all(
      color: bgMeasurementViewModel.resultColor,
      width: 5.0,
    ),
  );
}
