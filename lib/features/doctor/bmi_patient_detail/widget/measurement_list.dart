part of '../view/bmi_patient_detail_screen.dart';

class _MeasurementList extends StatefulWidget {
  final List<ScaleMeasurementViewModel> scaleMeasurements;
  final ScrollController scrollController;
  final bool? useStickyGroupSeparatorsValue;
  final SelectedScaleType selected;
  final Function(DateTime) fetchScrolledData;

  const _MeasurementList({
    required this.scaleMeasurements,
    this.selected = SelectedScaleType.weight,
    required this.scrollController,
    this.useStickyGroupSeparatorsValue,
    required this.fetchScrolledData,
  });

  @override
  __MeasurementListState createState() => __MeasurementListState();
}

class __MeasurementListState extends State<_MeasurementList> {
  @override
  Widget build(BuildContext context) {
    log(widget.selected.toStr);
    var list = <ScaleMeasurementViewModel>[];
    if (widget.scaleMeasurements.isNotEmpty) {
      list = widget.scaleMeasurements
          .where((element) => element.getMeasurement(widget.selected) != null)
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
                  useStickyGroupSeparators: true,
                  groupBy:
                      (ScaleMeasurementViewModel scaleMeasurementViewModel) =>
                          DateTime(
                              scaleMeasurementViewModel.date!.year,
                              scaleMeasurementViewModel.date!.month,
                              scaleMeasurementViewModel.date!.day),
                  groupHeaderBuilder:
                      (ScaleMeasurementViewModel bgMeasurementViewModel) {
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
                                .format(bgMeasurementViewModel.date!),
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
                    widget.fetchScrolledData(data.date!);
                  },
                ),
        ),
      ],
    );
  }

  Widget measurementList(ScaleMeasurementViewModel scaleMeasurementViewModel,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        Atom.show(
            ScaleTagger(
              scaleModel: scaleMeasurementViewModel,
            ),
            barrierDismissible: false,
            barrierColor: Colors.transparent);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(DateFormat("kk : mm").format(scaleMeasurementViewModel.date!),
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
    );
  }

  Row _timeAndImageSection(ScaleMeasurementViewModel scaleMeasurementViewModel,
      BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (scaleMeasurementViewModel.isManuel)
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                "M",
                style: context.xHeadline3.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          scaleMeasurementViewModel.imageUrl.isEmpty
              ? SizedBox(
                  width: 60 * context.textScale,
                  height: 60 * context.textScale,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image(
                                  image: FileImage(File(
                                      getIt<ScaleStorageImpl>()
                                          .getImagePathOfImageURL(e))),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
        ]);
  }

  Expanded _textAndScaleSection(
      ScaleMeasurementViewModel scaleMeasurementViewModel,
      BuildContext context) {
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
                        .getMeasurement(widget.selected)!
                        .toStringAsFixed(2),
                    style: context.xHeadline1),
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
}
