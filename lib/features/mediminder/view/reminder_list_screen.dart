import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/utils/tz_helper.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../mediminder.dart';
import '../widgets/reminder_edit_dialog.dart';

class ReminderListScreen extends StatelessWidget {
  Remindable? remindable;

  ReminderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      remindable = Atom.queryParameters['remindable']!.toRouteToRemindable();
    } catch (e) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<ReminderListVm>(
      create: (context) => ReminderListVm(context),
      child: RbioScaffold(
        extendBodyBehindAppBar: true,
        appbar: _buildAppBar(context),
        body: _buildBody(),
        floatingActionButton: _buildFab(context),
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        remindable!.toShortTitle(),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<ReminderListVm>(
      builder: (
        BuildContext context,
        ReminderListVm vm,
        Widget? child,
      ) {
        final medicineList = vm.medicineForScheduled;
        if (medicineList.isNotEmpty) {
          final filterList = medicineList
              .where((element) =>
                  element.remindable?.xRemindableKeys == remindable)
              .toList();
          if (filterList.isEmpty) {
            return RbioEmptyText(
              title: LocaleProvider.current.there_are_no_reminders,
            );
          }

          final filterMapList = filterList.groupBy((item) => item.createdDate);
          return _buildList(vm, filterMapList);
        } else {
          return RbioEmptyText(
            title: LocaleProvider.current.there_are_no_reminders,
          );
        }
      },
    );
  }

  Widget _buildList(
    ReminderListVm vm,
    Map<int?, List<MedicineForScheduledModel>> filterList,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
        bottom: R.sizes.defaultBottomValue,
      ),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: filterList.length,
      itemBuilder: (BuildContext context, int index) {
        int? key = filterList.keys.elementAt(index);
        if (key == null) return const SizedBox();

        return MedicineCard(
          index: index,
          createdDate: key,
          medicineList: filterList[key],
          reminderListVm: vm,
          remindable: remindable!,
        );
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
      onPressed: () {
        Atom.to(
          PagePaths.medicationAdd,
          queryParameters: {'remindable': remindable!.toRouteString()},
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          R.image.add,
          color: getIt<ITheme>().iconSecondaryColor,
        ),
      ),
    );
  }
}

class MedicineCard extends StatefulWidget {
  final int index;
  final int createdDate;
  final List<MedicineForScheduledModel>? medicineList;
  final ReminderListVm reminderListVm;
  final Remindable remindable;

  const MedicineCard({
    Key? key,
    required this.index,
    required this.createdDate,
    required this.medicineList,
    required this.reminderListVm,
    required this.remindable,
  }) : super(key: key);

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  bool _isExpanded = false;
  late String title;

  @override
  void initState() {
    title = widget.remindable == Remindable.bloodGlucose
        ? "${widget.remindable.toShortTitle()} - ${widget.index + 1}"
        : widget.medicineList?.first.name ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: R.sizes.borderRadiusCircular,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: widget.index != 0 ? 8 : 0,
        ),
        decoration: BoxDecoration(
          color: getIt<ITheme>().cardBackgroundColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                }
              },
              child: Slidable(
                key: ValueKey(widget.index),
                actionPane: const SlidableDrawerActionPane(),
                actionExtentRatio: 0.3,
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: LocaleProvider.current.delete,
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      showConfirmationAlertDialog(
                        context,
                        LocaleProvider.current.delete_medicine_title,
                        LocaleProvider
                            .current.delete_medicine_confirm_all_message,
                        () {
                          widget.reminderListVm
                              .removeAllMedicines(widget.createdDate);
                          Atom.dismiss();
                        },
                      );
                    },
                  ),
                ],
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                          ),
                          child: Text(
                            title,
                            style: context.xHeadline4,
                          ),
                        ),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          R.image.arrowDown,
                          width: R.sizes.iconSize3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //
            SizedBox(
              width: double.infinity,
              child: RbioAnimatedClipRect(
                open: _isExpanded,
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 250),
                child: Column(
                  children: [
                    for (var index = 0;
                        index < (widget.medicineList?.length ?? 0);
                        index++) ...[
                      if (widget.medicineList?[index] != null) ...[
                        _buildCard(
                          widget.medicineList![index],
                          index != widget.medicineList!.length - 1,
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(MedicineForScheduledModel item, bool isBottomLine) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        R.sizes.hSizer8,

        //
        Slidable(
          key: ValueKey(item.notificationId),
          actionPane: const SlidableDrawerActionPane(),
          actionExtentRatio: 0.3,
          actions: <Widget>[
            IconSlideAction(
              caption: LocaleProvider.current.edit,
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {
                showEditDialog(title, item);
              },
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: LocaleProvider.current.delete,
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                showConfirmationAlertDialog(
                  context,
                  LocaleProvider.current.delete_medicine_title,
                  LocaleProvider.current.delete_medicine_confirm_message,
                  () {
                    widget.reminderListVm.removeMedicine(item);
                    Atom.dismiss();
                  },
                );
              },
            ),
          ],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              R.sizes.wSizer24,

              //
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Row(
                      children: [
                        //
                        Flexible(
                          child: Text(
                            widget.remindable == Remindable.bloodGlucose
                                ? "${item.time}" +
                                    (item.remindable!.xRemindableKeys ==
                                            Remindable.medication
                                        ? " " "${item.name}"
                                        : " ")
                                : "${item.time}",
                            style: context.xHeadline1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        //
                        _getPeriodTitle(item),
                      ],
                    ),

                    //
                    Text(
                      widget.reminderListVm.getSubTitle(item),
                      style: context.xHeadline4.copyWith(
                        color: getIt<ITheme>().textColorPassive,
                      ),
                    ),
                  ],
                ),
              ),

              //
              // GestureDetector(
              //   onTap: () => showConfirmationAlertDialog(
              //     context,
              //     LocaleProvider.current.delete_medicine_title,
              //     LocaleProvider.current.delete_medicine_confirm_message,
              //     TextButton(
              //       style: TextButton.styleFrom(
              //           primary: getIt<ITheme>().textColor),
              //       child: Text(LocaleProvider.current.Ok),
              //       onPressed: () {
              //         widget.medicationVm.removeMedicine(item);
              //         Atom.dismiss();
              //       },
              //     ),
              //   ),
              //   child: Container(
              //     height: 32,
              //     width: 32,
              //     decoration: new BoxDecoration(
              //       color: getIt<ITheme>().mainColor,
              //       shape: BoxShape.circle,
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.all(5),
              //       child: SvgPicture.asset(R.image.delete_white_garbage),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),

        //
        R.sizes.hSizer8,

        //
        if (isBottomLine)
          Container(
            color: getIt<ITheme>().textColorPassive,
            height: 0.25,
          )
        else
          Container(),
      ],
    );
  }

  void showConfirmationAlertDialog(
    BuildContext context,
    String title,
    String text,
    VoidCallback onTap,
  ) {
    Atom.show(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: getIt<ITheme>().mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        title: Text(
          title,
          style: context.xHeadline1.copyWith(
            color: getIt<ITheme>().textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: context.xHeadline3.copyWith(
              color: getIt<ITheme>().textColor,
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: getIt<ITheme>().cardBackgroundColor,
            ),
            child: Text(LocaleProvider.current.Ok),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  Future<void> showEditDialog(
    String title,
    MedicineForScheduledModel item,
  ) async {
    final result = await Atom.show(
      ReminderEditDialog(
        title: title,
        item: item,
      ),
    );

    if (result != null) {
      if (result is TimeOfDay) {
        final itemTimeOfDay = item.time.xToTimeOfDay;
        if (!result.xIsEqual(itemTimeOfDay)) {
          widget.reminderListVm.updateMedicineForScheduledModel(result, item);
        }
      }
    }
  }

  Widget _getPeriodTitle(MedicineForScheduledModel item) {
    if (item.medicinePeriod!.xMedicinePeriodKeys == MedicinePeriod.oneTime) {
      return Text(
        TZHelper.instance
            .fromMillisecondsSinceEpoch(item.scheduledDate ?? 0)
            .xFormatTime1(),
        style: context.xHeadline5,
      );
    } else {
      return const SizedBox();
    }
  }
}
