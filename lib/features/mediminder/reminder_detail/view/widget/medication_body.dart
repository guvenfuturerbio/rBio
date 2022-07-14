part of '../reminder_detail_screen.dart';

class _MedicationBody extends StatelessWidget {
  final List<MedicationReminderModel> list;

  const _MedicationBody({
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
            color: getIt<IAppConfig>().theme.cardBackgroundColor,
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailsTitle(context),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.status,
                LocaleProvider.current.taken_per_day,
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.usageType == null ? '' : model.usageType!.toShortString(),
                model.dailyDose == null ? '' : model.dailyDose!.toString(),
                true,
              ),

              //
              _buildGap(),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.how_often,
                LocaleProvider.current.once,
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.reminderPeriod == null
                    ? ''
                    : model.reminderPeriod!.toShortString(),
                model.oneTimeDose == null ? '' : model.oneTimeDose!.toString(),
                true,
              ),
            ],
          ),
        ),

        //
        R.widgets.hSizer8,

        //
        R.widgets.hSizer8,

        //
        if (model.reminderPeriod != ReminderPeriod.oneTime)
          _ExpandableHours(
            list: expandableHoursList,
          ),
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
