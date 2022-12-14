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
  static const Color borderColor = Color.fromARGB(255, 238, 238, 238);

  BoxBorder get boxBorder => const Border(
        right: BorderSide(
          color: borderColor,
        ),
        bottom: BorderSide(
          color: borderColor,
        ),
      );

  TextStyle get textStyle => context.xHeadline4.copyWith(
        color: Colors.black,
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
            color: getIt<ITheme>().cardBackgroundColor,
          ),
        ),

        //
        TableCalendar<Event>(
          locale: context.watch<LocaleNotifier>().getLocaleStr,
          daysBackgroundColor: getIt<ITheme>().secondaryColor,
          cellBackgroundColor: getIt<ITheme>().cardBackgroundColor,

          //
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarFormat: CalendarFormat.twoWeeks,
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
              color: getIt<ITheme>().secondaryColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
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
              color: Colors.black,
              width: R.sizes.iconSize5,
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
              color: Colors.black,
              width: R.sizes.iconSize5,
            ),
          ),

          enabledDayPredicate: (day) {
            return widget.val.dateContains(day);
          },

          //
          calendarBuilders: CalendarBuilders(
            // #region defaultBuilder
            // Aktif g??nler, bug??n hari??
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
            // Di??er aya ait g??nler
            outsideBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: boxBorder,
                ),
                child: Text(
                  '${day.day}',
                  style: textStyle.copyWith(
                    color: Colors.black.withOpacity(0.25),
                  ),
                ),
              );
            },
            // #endregion

            // #region todayBuilder
            // Bug??n
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
                        ? getIt<ITheme>().textColorSecondary
                        : getIt<ITheme>().textColorPassive,
                  ),
                ),
              );
            },
            // #endregion

            // #region selectedBuilder
            // Se??ili g??n
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: boxBorder,
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: getIt<ITheme>().mainColor,
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
            // minDay ile maxDay d??????nda olanlar
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
            LoggerUtils.instance.i('Month Change : $focusedDay');
            widget.val.getAvailableDates(focusedDay);

            _focusedDay = focusedDay;
          },
        ),
      ],
    );
  }
}
