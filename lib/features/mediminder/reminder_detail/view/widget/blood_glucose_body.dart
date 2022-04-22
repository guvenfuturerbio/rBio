part of '../reminder_detail_screen.dart';

class _BloodGlucoseBody extends StatelessWidget {
  final List<BloodGlucoseReminderModel> list;

  const _BloodGlucoseBody({
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
              //
              _buildDetailsTitle(context),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.tag,
                LocaleProvider.current.how_often,
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.usageType == null ? '' : model.usageType!.toShortString(),
                model.reminderPeriod == null
                    ? ''
                    : model.reminderPeriod!.toShortString(),
                true,
              ),

              //
              _buildGap(),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.how_many_times_a_day,
                "",
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.dailyDose == null ? '' : model.dailyDose.toString(),
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
          bloodGlucoseModel: item,
        ),
      );
    }
    return expandableHoursList;
  }
}
