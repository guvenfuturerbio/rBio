import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../../../core/packages/table_calendar/table_calendar.dart';

class CreateAppointmentEventsScreen extends StatefulWidget {
  const CreateAppointmentEventsScreen({Key key}) : super(key: key);

  @override
  _CreateAppointmentEventsScreenState createState() =>
      _CreateAppointmentEventsScreenState();
}

class _CreateAppointmentEventsScreenState
    extends State<CreateAppointmentEventsScreen> {
  ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  static const Color borderColor = Color.fromARGB(255, 238, 238, 238);

  BoxBorder get boxBorder => Border(
        right: BorderSide(
          color: borderColor,
        ),
        bottom: BorderSide(
          color: borderColor,
        ),
      );

  TextStyle get textStyle => Theme.of(context).textTheme.bodyText1.copyWith(
        color: Colors.black,
        fontSize: 18,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(
        title: RbioAppBar.textTitle(
            context, LocaleProvider.of(context).create_appointment_events),
      ),

      //
      body: Padding(
        padding: R.sizes.screenPadding,
        child: Column(
          children: [
            //
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
                bottom: Radius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: getIt<ITheme>().secondaryColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(15),
                  ),
                ),
                child: TableCalendar<Event>(
                  backgroundColor: getIt<ITheme>().secondaryColor,
                  foregroundColor: getIt<ITheme>().cardBackgroundColor,

                  //
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),

                    //
                    leftChevronMargin: EdgeInsets.zero,
                    leftChevronPadding: EdgeInsets.zero,
                    leftChevronVisible: true,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: 38,
                    ),

                    //
                    rightChevronMargin: EdgeInsets.zero,
                    rightChevronPadding: EdgeInsets.zero,
                    rightChevronVisible: true,
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 38,
                    ),
                  ),

                  //
                  calendarBuilders: CalendarBuilders(
                    // #region headerTitleBuilder
                    headerTitleBuilder: (context, day) {
                      return GestureDetector(
                        onTap: () {},
                        child: Text(
                          DateFormat.yMMMM('en_US').format(day),
                          style: context.xHeadline3,
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    // #endregion

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
                            color: Colors.black.withOpacity(0.25),
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
                          style: textStyle,
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
                          padding: EdgeInsets.all(15),
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
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {},
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),

            //
            const SizedBox(height: 8.0),

            //
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index]}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.millisecondsSinceEpoch;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
