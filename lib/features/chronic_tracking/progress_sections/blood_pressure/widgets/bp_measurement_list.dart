import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../viewmodel/bp_measurement_vm.dart';
import '../viewmodel/bp_progres_vm.dart';
import 'tagger/bp_tagger_pop_up.dart';

class BpMeasurementList extends StatelessWidget {
  final List<BpMeasurementViewModel>? bpMeasurements;
  final ScrollController? scrollController;

  const BpMeasurementList({
    Key? key,
    this.bpMeasurements,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bpMeasurements == null || bpMeasurements!.isEmpty
        ? Center(
            child: Text(LocaleProvider.current.no_measurement),
          )
        : GroupedListView<BpMeasurementViewModel, DateTime>(
            elements: bpMeasurements ?? <BpMeasurementViewModel>[],
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
                    borderRadius: BorderRadius.circular(20),
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
              if (Provider.of<BpProgressVm>(context, listen: false)
                  .isChartShow) {
                Provider.of<BpProgressVm>(context, listen: false)
                    .fetchScrolledData(data.date);
              }
            },
          );
  }

  Widget measurementList(BpMeasurementViewModel item, BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.40,
      child: GestureDetector(
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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item.isManual)
                  Text(
                    "M",
                    style: context.xHeadline3.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
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
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: LocaleProvider.current.delete,
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            try {
              await getIt<BloodPressureStorageImpl>().delete(item.bpModel.key);
              Utils.instance.showSuccessSnackbar(
                context,
                LocaleProvider.current.delete_measurement_succesfull,
              );
            } catch (e) {
              Utils.instance.showSnackbar(
                context,
                LocaleProvider.current.delete_measurement_un_succesfull,
                backColor: Colors.red,
              );
            }
          },
        ),
      ],
    );
  }

  Widget _listItem(BuildContext context, BpMeasurementViewModel item) {
    return Container(
      height: context.height * .08 * context.textScale,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        children: [
          //
          Expanded(
            child: _listItemChild(context, LocaleProvider.current.sys,
                item.sys.toString(), 'mm/Hg'),
          ),

          //
          const VerticalDivider(),

          //
          Expanded(
            child: _listItemChild(context, LocaleProvider.current.dia,
                item.dia.toString(), 'mm/Hg'),
          ),

          //
          const VerticalDivider(),

          //
          Expanded(
            child: _listItemChild(context, LocaleProvider.current.pulse,
                item.pulse.toString(), 'bpm'),
          ),
        ],
      ),
    );
  }

  Widget _listItemChild(
    BuildContext context,
    String parameter,
    String measurement,
    String unit,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //
        Expanded(
          child: Text(
            parameter,
            style: context.xBodyText2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        //
        Expanded(
          flex: 2,
          child: Text(
            measurement,
            style: context.xHeadline4,
          ),
        ),

        //
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
