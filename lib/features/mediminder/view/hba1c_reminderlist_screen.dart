import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/utils/tz_helper.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/enums/remindable.dart';
import '../mediminder.dart';

// ignore: must_be_immutable
class Hba1cReminderListScreen extends StatelessWidget {
  Remindable? remindable;

  Hba1cReminderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      remindable = Atom.queryParameters['remindable']!.toRouteToRemindable();
    } catch (e) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<Hba1cReminderListVm>(
      create: (context) => Hba1cReminderListVm(context),
      child: Consumer<Hba1cReminderListVm>(
        builder: (
          BuildContext context,
          Hba1cReminderListVm value,
          Widget? child,
        ) {
          return RbioScaffold(
            extendBodyBehindAppBar: true,
            appbar: _buildAppBar(context),
            body: _buildBody(context, value),
            floatingActionButton: _buildFab(context, value),
          );
        },
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

  Widget _buildBody(BuildContext context, Hba1cReminderListVm vm) {
    if (vm.hba1cForScheduled.isNotEmpty) {
      return _buildList(context, vm, vm.hba1cForScheduled);
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
  }

  Widget _buildList(
    BuildContext context,
    Hba1cReminderListVm vm,
    List<Hba1CForScheduleModel> list,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
        bottom: R.sizes.defaultBottomValue,
      ),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return HbaCard(
          index: index,
          hbaReminder: list[index],
          hbaScheduledVm: vm,
        );
      },
    );
  }

  Widget _buildFab(BuildContext context, Hba1cReminderListVm value) {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
      onPressed: () {
        Atom.to(
          PagePaths.hba1cReminderAdd,
          queryParameters: {
            'remindable': remindable!.toRouteString(),
            'hba1cIdForNotification':
                value.generatedIdForSchedule?.last.toString() ?? '',
          },
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

class HbaCard extends StatelessWidget {
  final int index;
  final Hba1CForScheduleModel hbaReminder;
  final Hba1cReminderListVm hbaScheduledVm;

  const HbaCard({
    Key? key,
    required this.index,
    required this.hbaReminder,
    required this.hbaScheduledVm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: LocaleProvider.current.delete,
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => showConfirmationAlertDialog(context),
        ),
      ],
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: index != 0 ? 8 : 0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
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
            Text(
              TZHelper.instance
                  .fromMillisecondsSinceEpoch(
                      int.parse(hbaReminder.reminderDate ?? ''))
                  .xFormatTime10(),
              style: context.xHeadline3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            Text(
              TZHelper.instance
                  .fromMillisecondsSinceEpoch(
                      int.parse(hbaReminder.reminderDate ?? ''))
                  .xFormatTime8(),
              style: context.xHeadline4.copyWith(
                color: getIt<ITheme>().grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmationAlertDialog(BuildContext context) {
    Atom.show(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: getIt<ITheme>().mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        title: Text(
          LocaleProvider.current.delete_medicine_title,
          style: context.xHeadline1.copyWith(
            color: getIt<ITheme>().textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            LocaleProvider.current.delete_medicine_confirm_message,
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
            onPressed: () {
              hbaScheduledVm.removeScheduledHba1c(hbaReminder);
              Atom.dismiss();
            },
          ),
        ],
      ),
    );
  }
}
