import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/view/pressure_progres_page.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../view_model/pressure_measurement_view_model.dart';
import 'pressure_tagger/pressure_tagger.dart';

class BpMeasurementList extends StatelessWidget {
  final List<BpMeasurementViewModel> bpMeasurements;
  final ScrollController scrollController;
  const BpMeasurementList({Key key, this.bpMeasurements, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bpMeasurements.isEmpty
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
                bottom: context.HEIGHT * .28 * context.TEXTSCALE),
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
            itemBuilder: (_, BpMeasurementViewModel bpMeasurementViewModel) {
              return measurementList(bpMeasurementViewModel, context);
            },
            callback: (BpMeasurementViewModel data) {
              Provider.of<BpProgressPageVm>(context, listen: false)
                  .fetchScrolledData(data.date);
            },
          );
  }

  Widget measurementList(BpMeasurementViewModel item, BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.40,
      child: GestureDetector(
        onTap: () {
          Atom.show(
            PressureTagger(
              bpModel: item.bpModel,
              isEdit: true,
            ),
            barrierColor: Colors.transparent,
            barrierDismissible: false,
          );
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Text(DateFormat("kk : mm").format(item.date)),
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      '${LocaleProvider.current.delete_measurement_succesfull}')));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    '${LocaleProvider.current.delete_measurement_un_succesfull}'),
                backgroundColor: Colors.red,
              ));
            }
          },
        ),
      ],
    );
  }

  Container _listItem(BuildContext context, BpMeasurementViewModel item) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      height: context.HEIGHT * .07 * context.TEXTSCALE,
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
      child: Row(
        children: [
          Expanded(
            child: _listItemChild(context, LocaleProvider.current.sys,
                item.sys.toString(), 'mm/Hg'),
          ),
          VerticalDivider(),
          Expanded(
            child: _listItemChild(context, LocaleProvider.current.dia,
                item.dia.toString(), 'mm/Hg'),
          ),
          VerticalDivider(),
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
        Text(
          parameter,
          style: context.xHeadline5,
        ),
        Text(
          measurement,
          style: context.xHeadline3,
        ),
        Text(
          unit,
          style: context.xBodyText2,
        ),
      ],
    );
  }
}
