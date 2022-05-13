part of '../view/bp_patient_detail_screen.dart';

class _MeasurementList extends StatelessWidget {
  final List<BpMeasurementViewModel>? bpMeasurements;
  final ScrollController? scrollController;
  final Function(DateTime)? fetchScrolledData;
  const _MeasurementList(
      {Key? key,
      this.bpMeasurements,
      this.scrollController,
      this.fetchScrolledData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bpMeasurements!.isEmpty
        ? Center(
            child: Text(LocaleProvider.current.no_measurement),
          )
        : GroupedListView<BpMeasurementViewModel, DateTime>(
            elements: bpMeasurements!,
            order: GroupedListOrder.DESC,
            controller: scrollController,
            scrollDirection: Axis.vertical,
            floatingHeader: true,
            shrinkWrap: true,
            padding: EdgeInsets.only(
                bottom: context.height * .28 * context.textScale),
            useStickyGroupSeparators: true,
            groupBy: (BpMeasurementViewModel bgMeasurementViewModel) =>
                DateTime(
                    bgMeasurementViewModel.date.year,
                    bgMeasurementViewModel.date.month,
                    bgMeasurementViewModel.date.day),
            groupHeaderBuilder:
                (BpMeasurementViewModel bgMeasurementViewModel) {
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
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat.yMMMMEEEEd(Intl.getCurrentLocale())
                          .format(bgMeasurementViewModel.date),
                    ),
                  ),
                ),
              );
            },
            itemBuilder: (_, BpMeasurementViewModel bpMeasurementViewModel) {
              return measurementList(bpMeasurementViewModel, context);
            },
            callback: (BpMeasurementViewModel data) {
              fetchScrolledData!(data.date);
            },
          );
  }

  Widget measurementList(BpMeasurementViewModel item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Atom.show(
          BpTaggerPopUp(
            bpModel: item.bpModel,
            isEdit: true,
          ),
          barrierColor: Colors.transparent,
          barrierDismissible: false,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.isManual)
                Text("M",
                    style: context.xHeadline3
                        .copyWith(fontWeight: FontWeight.w900)),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Text(DateFormat("kk : mm").format(item.date)),
              ),
            ],
          ),
          Expanded(
            child: _listItem(context, item),
          ),
        ],
      ),
    );
  }

  Container _listItem(BuildContext context, BpMeasurementViewModel item) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      height: context.height * .08 * context.textScale,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 5,
              spreadRadius: 0,
              offset: const Offset(5, 5))
        ],
        borderRadius: R.sizes.borderRadiusCircular
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: _listItemChild(context, LocaleProvider.current.sys,
                item.sys.toString(), 'mm/Hg'),
          ),
          const VerticalDivider(),
          Expanded(
            child: _listItemChild(context, LocaleProvider.current.dia,
                item.dia.toString(), 'mm/Hg'),
          ),
          const VerticalDivider(),
          Expanded(
            child: _listItemChild(context, LocaleProvider.current.pulse,
                item.pulse.toString(), 'bpm'),
          ),
        ],
      ),
    );
  }

  Column _listItemChild(
      BuildContext context, String parameter, String measurement, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Text(
            parameter,
            style: context.xBodyText2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            measurement,
            style: context.xHeadline4,
          ),
        ),
        Expanded(
          child: Text(
            unit,
            style: context.xBodyText2,
          ),
        ),
      ],
    );
  }
}
