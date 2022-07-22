part of '../view/create_appointment_events_screen.dart';

class _TableCalendar extends StatefulWidget {
  final DateTime focusedDay;
  final CreateAppointmentEventsVm val;
  final ValueNotifier<_EventSelectedModel?> completeNotifier;

  const _TableCalendar({
    Key? key,
    required this.focusedDay,
    required this.val,
    required this.completeNotifier,
  }) : super(key: key);

  @override
  State<_TableCalendar> createState() => _TableCalendarState();
}

class _TableCalendarState extends State<_TableCalendar> {
  Color get borderColor => getIt<IAppConfig>().theme.scaffoldBackgroundColor;

  BoxBorder get boxBorder => Border(
        right: BorderSide(
          color: borderColor,
        ),
        bottom: BorderSide(
          color: borderColor,
        ),
      );

  TextStyle get textStyle => context.xHeadline4.copyWith(
        color: context.xTextInverseColor,
      );

  late DateTime _focusedDay;
  late DateTime _selectedDay;

  void _onDaySelected(
    CreateAppointmentEventsVm value,
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        widget.completeNotifier.value = null;

        if (widget.val.dateContains(selectedDay)) {
          value.setSelectedDate(_selectedDay, true);
        }
      });
    }
  }

  @override
  void initState() {
    _focusedDay = widget.focusedDay;
    _selectedDay = _focusedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //
        Positioned.fill(
          child: Container(
            color: context.xCardColor,
          ),
        ),

        //
        TableCalendar<Event>(
          locale: context.watch<LocaleNotifier>().getLocaleStr,
          daysBackgroundColor: getIt<IAppConfig>().theme.secondaryBackColor,
          cellBackgroundColor: context.xCardColor,

          //
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarFormat: CalendarFormat.month,
          rangeSelectionMode: RangeSelectionMode.toggledOff,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: const CalendarStyle(
            // Use `CalendarStyle` to customize the UI
            outsideDaysVisible: true,
          ),
          daysOfWeekVisible: true,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: context.xBodyText1,
            weekendStyle: context.xBodyText1,
          ),

          //
          headerStyle: HeaderStyle(
            headerMargin: EdgeInsets.zero,
            headerPadding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: getIt<IAppConfig>().theme.secondaryBackColor,
              borderRadius: BorderRadius.vertical(
                top: R.sizes.radiusCircular,
              ),
            ),

            //
            leftChevronMargin: const EdgeInsets.only(
              top: 8,
              left: 12,
              bottom: 8,
            ),
            leftChevronPadding: EdgeInsets.zero,
            leftChevronVisible: true,
            leftChevronIcon: SvgPicture.asset(
              R.image.arrowLeft,
              width: R.sizes.iconSize5,
              color: context.xTextOnPrimaryColor,
            ),

            //
            rightChevronMargin: const EdgeInsets.only(
              top: 8,
              right: 12,
              bottom: 8,
            ),
            rightChevronPadding: EdgeInsets.zero,
            rightChevronVisible: true,
            rightChevronIcon: SvgPicture.asset(
              R.image.arrowRightIcon,
              width: R.sizes.iconSize5,
              color: context.xTextOnPrimaryColor,
            ),
          ),

          enabledDayPredicate: (day) {
            return widget.val.dateContains(day);
          },

          //
          calendarBuilders: CalendarBuilders(
            // #region defaultBuilder
            // Aktif günler, bugün hariç
            defaultBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: boxBorder,
                ),
                child: Text(
                  '${day.day}',
                  style: textStyle,
                ),
              );
            },
            // #endregion

            // #region outsideBuilder
            // Diğer aya ait günler
            outsideBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: boxBorder,
                ),
                child: Text(
                  '${day.day}',
                  style: textStyle.copyWith(
                    color: widget.val.dateContains(day)
                        ? context.xTextInverseColor
                        : context.xAppColors.textDisabledColor,
                  ),
                ),
              );
            },
            // #endregion

            // #region todayBuilder
            // Bugün
            todayBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: boxBorder,
                ),
                child: Text(
                  '${day.day}',
                  style: textStyle.copyWith(
                    color: widget.val.dateContains(day)
                        ? context.xTextOnPrimaryColor
                        : context.xAppColors.textDisabledColor,
                  ),
                ),
              );
            },
            // #endregion

            // #region selectedBuilder
            // Seçili gün
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: boxBorder,
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: context.xPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: textStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
            // #endregion

            // #region disabledBuilder
            // minDay ile maxDay dışında olanlar
            disabledBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: boxBorder,
                ),
                child: Text(
                  '${day.day}',
                  style: textStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
              );
            },
            // #endregion
          ),

          //
          onDaySelected: (
            DateTime selectedDay,
            DateTime focusedDay,
          ) =>
              _onDaySelected(widget.val, selectedDay, focusedDay),
          onFormatChanged: (format) {},
          onPageChanged: (focusedDay) {
            bool isAvailable = false;
            for (var element in widget.val.availableDates) {
              if (element.month == focusedDay.month) {
                isAvailable = true;
                break;
              }
            }
            var newDate =
                DateTime(focusedDay.year, focusedDay.month + 1, focusedDay.day);
            if (!isAvailable && kLastDay.isAfter(newDate)) {
              widget.val.getAvailableDates(newDate, false);
            } else {
              widget.val.getAvailableDates(focusedDay, false);
            }
            _focusedDay = focusedDay;
          },
        ),
      ],
    );
  }
}
