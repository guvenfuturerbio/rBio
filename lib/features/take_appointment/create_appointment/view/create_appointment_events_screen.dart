import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  ValueNotifier<bool> completeNotifier = ValueNotifier(false);

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
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
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

      // _selectedEvents.value = _getEventsForDay(selectedDay);
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
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.of(context).create_appointment_events,
        ),
      ),

      //
      body: Column(
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
                  leftChevronMargin: EdgeInsets.only(
                    top: 8,
                    left: 12,
                    bottom: 8,
                  ),
                  leftChevronPadding: EdgeInsets.zero,
                  leftChevronVisible: true,
                  leftChevronIcon: SvgPicture.asset(
                    R.image.arrow_left_icon,
                    color: Colors.black,
                    width: R.sizes.iconSize5,
                  ),

                  //
                  rightChevronMargin: EdgeInsets.only(
                    top: 8,
                    right: 12,
                    bottom: 8,
                  ),
                  rightChevronPadding: EdgeInsets.zero,
                  rightChevronVisible: true,
                  rightChevronIcon: SvgPicture.asset(
                    R.image.arrow_right_icon,
                    color: Colors.black,
                    width: R.sizes.iconSize5,
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
            child: ListBody(
              completeNotifier: completeNotifier,
            ),
          ),
        ],
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

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class ListBody extends StatelessWidget {
  final ValueNotifier<bool> completeNotifier;

  const ListBody({
    Key key,
    @required this.completeNotifier,
  }) : super(key: key);

  static const List<String> list = <String>[
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //
        Positioned.fill(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    SizedBox(height: 4),

                    //
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        '11 Ekim',
                        style: context.xHeadline2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //
                    _buildTimeCard(context, list[index]),
                  ],
                );
              }

              return _buildTimeCard(context, list[index]);
            },
          ),
        ),

        //
        Align(),

        //
        Align(
          alignment: Alignment.bottomRight,
          child: ValueListenableBuilder(
            valueListenable: completeNotifier,
            builder: (BuildContext context, bool value, Widget child) {
              return RbioSwitcher(
                showFirstChild: value,
                child1: child,
                child2: Visibility(
                  visible: value,
                  child: child,
                ),
              );
            },
            child: RbioElevatedButton(
              onTap: () {},
              title: "Devam Et",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeCard(BuildContext context, String value) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          completeNotifier.value = !completeNotifier.value;
        },
        child: Container(
          decoration: BoxDecoration(
            color: getIt<ITheme>().cardBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 5,
          ),
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline2.copyWith(),
          ),
        ),
      ),
    );
  }
}
