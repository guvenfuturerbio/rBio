part of '../reminder_detail_screen.dart';

class _SmallPillarBody extends StatelessWidget {
  final List<MedicationReminderModel> list;

  const _SmallPillarBody({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = list.first;
    final expandableHoursList = _reminderListToExpandableHours();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
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
              _buildDetailsTitle(context),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.box_code,
                LocaleProvider.current.status,
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.boxCode == null ? '' : model.boxCode.toString(),
                model.usageType.xGetText,
                true,
              ),

              //
              _buildGap(),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.how_often,
                LocaleProvider.current.taken_per_day,
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.reminderPeriod == null
                    ? ''
                    : model.reminderPeriod!.toShortString(),
                model.dailyDose == null ? '' : model.dailyDose.toString(),
                true,
              ),

              //
              _buildGap(),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.once,
                LocaleProvider.current.remaining_drug,
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.oneTimeDose == null ? '' : model.oneTimeDose.toString(),
                model.drugCount == null ? '' : model.drugCount.toString(),
                true,
              ),

              //
              _buildGap(),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.notification,
                "",
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.remainingCountNotification == null
                    ? ''
                    : model.remainingCountNotification.toString(),
                "",
                true,
              ),
            ],
          ),
        ),

        //
        R.sizes.hSizer8,

        //
        if (model.reminderPeriod != ReminderPeriod.oneTime) ...[
          _ExpandableHours(
            list: expandableHoursList,
          ),
        ],
      ],
    );
  }

  List<ExpandableHoursModel> _reminderListToExpandableHours() {
    var expandableHoursList = <ExpandableHoursModel>[];
    for (var item in list) {
      expandableHoursList.add(
        ExpandableHoursModel(
          dateTime:
              TZHelper.instance.fromMillisecondsSinceEpoch(item.scheduledDate),
          notificationId: item.notificationId,
          status: item.status,
          medicationModel: item,
        ),
      );
    }
    return expandableHoursList;
  }
}
