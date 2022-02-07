import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/widgets/rbio_animated_cliprect.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/enums/remindable.dart';
import '../mediminder.dart';

// ignore: must_be_immutable
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

    return ChangeNotifierProvider<MedicationVm>(
      create: (context) => MedicationVm(context),
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
    return Consumer<MedicationVm>(
      builder: (
        BuildContext context,
        MedicationVm vm,
        Widget? child,
      ) {
        final medicineList = vm.medicineForScheduled;
        if (medicineList.isNotEmpty &&
            medicineList.any(
              (element) => element.remindable != null
                  ? element.remindable!.xRemindableKeys == remindable
                  : false,
            )) {
          final filterList = medicineList.groupBy((item) => item.createdDate);
          return _buildList(vm, filterList);
        } else {
          return Center(
            heightFactor: 5,
            child: Text(
              LocaleProvider.current.there_are_no_reminders,
              textAlign: TextAlign.center,
              style: context.xHeadline3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildList(
    MedicationVm vm,
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
          medicationVm: vm,
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
  final MedicationVm medicationVm;
  final Remindable remindable;

  const MedicineCard({
    Key? key,
    required this.index,
    required this.createdDate,
    required this.medicineList,
    required this.medicationVm,
    required this.remindable,
  }) : super(key: key);

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
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
                          widget.medicationVm
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
                            widget.remindable == Remindable.bloodGlucose
                                ? "${widget.remindable.toShortTitle()} - ${widget.index + 1}"
                                : widget.medicineList?.first.name ?? '',
                            style: context.xHeadline4,
                          ),
                        ),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          R.image.arrow_down_icon,
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
                    widget.medicationVm.removeMedicine(item);
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
                    Text(
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

                    //
                    Text(
                      widget.medicationVm.getSubTitle(item),
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
}
