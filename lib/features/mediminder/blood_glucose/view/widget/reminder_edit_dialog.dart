part of '../blood_glucose_reminder_list_screen.dart';

class _ReminderEditDialog extends StatefulWidget {
  final String title;
  final MedicineForScheduledModel item;

  const _ReminderEditDialog({
    Key? key,
    required this.title,
    required this.item,
  }) : super(key: key);

  @override
  State<_ReminderEditDialog> createState() => _ReminderEditDialogState();
}

class _ReminderEditDialogState extends State<_ReminderEditDialog> {
  late TimeOfDay currentTimeOfDay;

  @override
  void initState() {
    final hourMinutes = widget.item.time?.split(':') ?? ["0", "0"];
    currentTimeOfDay = TimeOfDay(
      hour: int.tryParse(hourMinutes[0]) ?? 0,
      minute: int.tryParse(hourMinutes[1]) ?? 0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      backgroundColor: context.scaffoldBackgroundColor,
      title: GuvenAlert.buildDescription(widget.title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          R.sizes.hSizer16,
          _buildTimeCard(context),
          R.sizes.hSizer4,
        ],
      ),
      actions: [
        GuvenAlert.buildMaterialAction(
          LocaleProvider.current.update,
          () {
            Atom.dismiss(currentTimeOfDay);
          },
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                currentTimeOfDay.xTimeFormat,
                style: context.xHeadline3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //
          GestureDetector(
            onTap: () async {
              var timeOfDay = await Utils.instance.openMaterialTimePicker(
                context,
                TimeOfDay(
                  hour: currentTimeOfDay.hour,
                  minute: currentTimeOfDay.minute,
                ),
              );

              if (timeOfDay != null) {
                if (timeOfDay.hour != currentTimeOfDay.hour ||
                    timeOfDay.minute != currentTimeOfDay.minute) {
                  currentTimeOfDay = timeOfDay;
                  setState(() {});
                }
              }
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                R.image.otherIcon,
                width: R.sizes.iconSize3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
