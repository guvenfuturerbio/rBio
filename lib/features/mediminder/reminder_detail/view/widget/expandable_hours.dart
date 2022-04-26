part of '../reminder_detail_screen.dart';

class _ExpandableHours extends StatefulWidget {
  final List<ExpandableHoursModel> list;

  const _ExpandableHours({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  __ExpandableHoursState createState() => __ExpandableHoursState();
}

class __ExpandableHoursState extends State<_ExpandableHours> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Text(
                      LocaleProvider.current.hours,
                      style: context.xHeadline3.copyWith(
                        fontWeight: FontWeight.bold,
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

          //
          SizedBox(
            width: double.infinity,
            child: RbioAnimatedClipRect(
              open: _isExpanded,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 250),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  bottom: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (var i = 0; i < widget.list.length; i++) ...[
                      _buildTimeCard(i, widget.list[i]),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(
    int index,
    ExpandableHoursModel model,
  ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: index == 0 ? 0 : 4),
      decoration: BoxDecoration(
        color: getIt<IAppConfig>().theme.cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //
          Expanded(
            child: Text(
              model.dateTime.xFormatTime8(),
              style: context.xHeadline3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          CupertinoSwitch(
            value: model.status,
            onChanged: (value) {
              context.read<ReminderDetailCubit>().changeTimeStatus(
                    ReminderChangeTimeStatus(
                      notificationId: model.notificationId,
                      value: value,
                      dateTime: model.dateTime,
                      list: widget.list,
                      bloodGlucoseModel: model.bloodGlucoseModel,
                      medicationModel: model.medicationModel,
                    ),
                  );
            },
            activeColor: getIt<IAppConfig>().theme.mainColor,
          ),
        ],
      ),
    );
  }
}

class ExpandableHoursModel {
  final tz.TZDateTime dateTime;
  final int notificationId;
  final bool status;
  final BloodGlucoseReminderModel? bloodGlucoseModel;
  final MedicationReminderModel? medicationModel;

  ExpandableHoursModel({
    required this.dateTime,
    required this.notificationId,
    required this.status,
    this.bloodGlucoseModel,
    this.medicationModel,
  });
}
