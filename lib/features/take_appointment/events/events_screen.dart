import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../../core/packages/table_calendar/table_calendar.dart';
import 'events_vm.dart';

class EventsScreen extends StatefulWidget {
  int tenantId;
  int departmentId;
  int resourceId;
  String doctorName;
  String departmentName;
  bool fromOnlineSelect;
  String imageUrl;

  EventsScreen({
    this.tenantId,
    this.departmentId,
    this.resourceId,
    this.doctorName,
    this.departmentName,
    this.fromOnlineSelect,
    this.imageUrl,
  });

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  @override
  Widget build(BuildContext context) {
    try {
      widget.tenantId = int.parse(Atom.queryParameters['tenantId']);
      widget.departmentId = int.parse(Atom.queryParameters['departmentId']);
      widget.resourceId = int.parse(Atom.queryParameters['resourceId']);
      widget.doctorName = Uri.decodeFull(Atom.queryParameters['doctorName']);
      widget.departmentName =
          Uri.decodeFull(Atom.queryParameters['departmentName']);
      widget.fromOnlineSelect =
          Atom.queryParameters['fromOnlineSelect'] == 'true' ? true : false;
      widget.imageUrl = Atom.queryParameters['imageUrl'];
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<EventsScreenVm>(
      create: (context) => EventsScreenVm(
        context: context,
        tenantId: widget.tenantId,
        departmentId: widget.departmentId,
        resourceId: widget.resourceId,
        fromOnlineSelect: widget.fromOnlineSelect,
      ),
      child: Consumer<EventsScreenVm>(
        builder: (BuildContext context, EventsScreenVm value, Widget child) {
          return Scaffold(
            appBar: MainAppBar(
                context: context,
                title: getTitleBar(context),
                leading: ButtonBackWhite(context)),
            body: _buildBody(value, context),
          );
        },
      ),
    );
  }

  Widget _buildBody(EventsScreenVm value, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 16,
          left: Atom.size.width < 800
              ? Atom.size.width * 0.03
              : Atom.size.width * 0.10,
          right: Atom.size.width < 800
              ? Atom.size.width * 0.03
              : Atom.size.width * 0.10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildCircleImage(),

            //
            _buildDoctorName(),

            //
            _buildCalendar(value, context),

            //
            _buildSelectionType(context, value),

            //
            if (value.progress == LoadingProgress.DONE) ...[
              if (value.closestAppointments.isNotEmpty) ...[
                Column(
                  children: [
                    //
                    Text(
                      LocaleProvider.of(context).no_suitable_appo,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),

                    //
                    SizedBox(
                      height: 10,
                    ),

                    //
                    Text(
                      LocaleProvider.of(context).closest_available_appointments,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),

                    //
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.closestAppointments.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: closestAppointments(
                            closestAppointment:
                                value.closestAppointments[index],
                            onPressed: () {
                              setState(
                                () {
                                  value.setSelectedClosestDate(
                                      value.closestAppointments[index]);
                                },
                              );
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ] else ...[
                if (value.ayranciSlots.length != 0 ||
                    value.cayyoluSlots.length != 0 ||
                    value.onlineSlots.length != 0) ...[
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(value.ayranciSlots.length,
                                  (index) {
                                return _buttonAppointment(
                                    text: value.ayranciSlots[index].from,
                                    color: R.color.ayranci,
                                    title: "Ayrancı",
                                    onPressed: () {
                                      Atom.to(PagePaths.APPOINTMENT_SUMMARY,
                                          queryParameters: {
                                            'tenantId': R
                                                .dynamicVar.tenantAyranciId
                                                .toString(),
                                            'departmentId':
                                                widget.departmentId.toString(),
                                            'resourceId':
                                                widget.resourceId.toString(),
                                            'doctorName': Uri.encodeFull(
                                                widget.doctorName),
                                            'departmentName': Uri.encodeFull(
                                                widget.departmentName),
                                            'from':
                                                value.ayranciSlots[index].from,
                                            'to': value.ayranciSlots[index].to,
                                            'forOnline': 'false',
                                            'imageUrl': widget.imageUrl
                                          });
                                    });
                              })),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              value.cayyoluSlots.length,
                              (index) {
                                return _buttonAppointment(
                                  text: value.cayyoluSlots[index].from,
                                  color: R.color.cayyolu,
                                  title: "Çayyolu",
                                  onPressed: () {
                                    Atom.to(
                                      PagePaths.APPOINTMENT_SUMMARY,
                                      queryParameters: {
                                        'tenantId': R.dynamicVar.tenantCayyoluId
                                            .toString(),
                                        'departmentId':
                                            widget.departmentId.toString(),
                                        'resourceId':
                                            widget.resourceId.toString(),
                                        'doctorName':
                                            Uri.encodeFull(widget.doctorName),
                                        'departmentName': Uri.encodeFull(
                                            widget.departmentName),
                                        'from': value.cayyoluSlots[index].from,
                                        'to': value.cayyoluSlots[index].to,
                                        'forOnline': 'false',
                                        'imageUrl': widget.imageUrl
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              value.onlineSlots.length,
                              (index) {
                                return _buttonAppointment(
                                  text: value.onlineSlots[index].from,
                                  color: R.color.online_appointment,
                                  title: "Online",
                                  onPressed: () {
                                    Atom.to(
                                      PagePaths.APPOINTMENT_SUMMARY,
                                      queryParameters: {
                                        'tenantId': R.dynamicVar.tenantAyranciId
                                            .toString(),
                                        'departmentId':
                                            widget.departmentId.toString(),
                                        'resourceId':
                                            widget.resourceId.toString(),
                                        'doctorName':
                                            Uri.encodeFull(widget.doctorName),
                                        'departmentName': Uri.encodeFull(
                                            widget.departmentName),
                                        'from': value.onlineSlots[index].from,
                                        'to': value.onlineSlots[index].to,
                                        'forOnline': 'true',
                                        'imageUrl': widget.imageUrl
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (!value.onlineSelected &&
                            !value.cayyoluSelected &&
                            !value.ayranciSelected)
                        ? SizedBox()
                        : Column(
                            children: [
                              Text(
                                LocaleProvider.current.appo_suitability,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                LocaleProvider.current.phone_guven,
                                style: TextStyle(
                                  color: R.color.blue,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ],
            ] else ...[
              if (value.progress == LoadingProgress.LOADING) ...[
                Container(
                  margin: EdgeInsets.all(16),
                  child: RbioLoading(),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Container _buildSelectionType(BuildContext context, EventsScreenVm value) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              LocaleProvider.of(context).select_appo_type,
              style: TextStyle(color: R.color.blue),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: filterButton(
                  selected: value.ayranciSelected,
                  color: R.color.ayranci,
                  text: "Ayrancı",
                  onPressed: () {
                    value.toggleAyranciSelected();
                  },
                ),
              ),
              Expanded(
                child: filterButton(
                  selected: value.cayyoluSelected,
                  color: R.color.cayyolu,
                  text: "Çayyolu",
                  onPressed: () {
                    value.toggleCayyoluSelected();
                  },
                ),
              ),
              Expanded(
                child: filterButton(
                  selected: value.onlineSelected,
                  color: R.color.online_appointment,
                  text: "Online",
                  onPressed: () {
                    value.toggleOnlineSelected();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildCalendar(EventsScreenVm value, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 90,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: R.color.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            TableCalendar(
              backgroundColor: getIt<ITheme>().secondaryColor,
              foregroundColor: getIt<ITheme>().cardBackgroundColor,

              //
              focusedDay: value.selectedDate,
              lastDay: DateTime.now().add(Duration(days: 365)),
              firstDay: DateTime.now().subtract(Duration(days: 30)),
              calendarFormat: _calendarFormat,
              calendarStyle: CalendarStyle(
                holidayTextStyle: TextStyle(color: Colors.white),
                todayTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: R.color.light_blue),
                /*   todayDecoration: BoxDecoration(
                                    color: Colors.transparent),*/
                weekendTextStyle: TextStyle(color: R.color.black),
                selectedTextStyle: TextStyle(color: Colors.green),
                selectedDecoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
              headerStyle: HeaderStyle(
                rightChevronIcon:
                    new Icon(Icons.chevron_right, color: R.color.white),
                leftChevronIcon:
                    new Icon(Icons.chevron_left, color: R.color.white),
                titleTextStyle: TextStyle(color: R.color.white),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: R.color.blue),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: R.color.white),
                  weekendStyle: TextStyle(color: R.color.white)),
              selectedDayPredicate: (date) {
                if (DateTime(date.year, date.month, date.day)
                        .millisecondsSinceEpoch ==
                    DateTime(value.selectedDate.year, value.selectedDate.month,
                            value.selectedDate.day)
                        .millisecondsSinceEpoch)
                  return true;
                else
                  return false;
              },
              onDaySelected: (date, event) {
                value.setSelectedDate(date);
              },
              calendarBuilders: CalendarBuilders(
                //
                selectedBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                //
                defaultBuilder: (context, day, focusedDay) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                    ),
                  ),
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),

                // TODAY
                todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: R.color.light_blue),
                    )),
              ),
              availableCalendarFormats: {
                CalendarFormat.twoWeeks: LocaleProvider.of(context).two_week,
                CalendarFormat.month: LocaleProvider.of(context).month,
                CalendarFormat.week: LocaleProvider.of(context).week,
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDoctorName() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        widget?.doctorName ?? "-",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: R.color.black),
      ),
    );
  }

  Image _buildCircleImage() {
    return Image.network(
      widget.imageUrl ?? "",
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return CustomCircleAvatar(
          size: 120,
          child: SvgPicture.asset(
            R.image.doctor_avatar,
            fit: BoxFit.fill,
          ),
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null)
          return CustomCircleAvatar(
              child: Container(
                child: child,
              ),
              size: 120);
        return Container(
            child: Stack(
          alignment: Alignment.center,
          children: [
            RbioLoading(),
            Center(
                child: Container(
              width: 120,
              height: 120,
            ))
          ],
        ));
      },
    );
  }

  Widget _buttonAppointment({
    String title,
    String text,
    Color color,
    Function onPressed,
  }) {
    return Center(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                Text(
                  text.substring(11, 16),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  title ?? "-",
                  style: TextStyle(
                    color: R.color.white,
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: color,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: R.color.dark_black.withAlpha(25),
                  offset: Offset(2, 2))
            ],
          ),
        ),
        onTap: () {
          onPressed();
        },
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(
        title: LocaleProvider.of(context).title_book_appointment);
  }

  Widget filterButton(
      {bool selected, Color color, String text, Function onPressed}) {
    return Center(
      child: InkWell(
        child: Container(
          width: 104,
          height: 46,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selected
                    ? Icon(Icons.check_box, color: R.color.white)
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: color,
                      ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  text,
                  style: TextStyle(color: selected ? Colors.white : color),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: selected ? color : Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: R.color.dark_black.withAlpha(25),
                    offset: Offset(2, 2))
              ]),
        ),
        onTap: () {
          onPressed();
        },
      ),
    );
  }

  Widget closestAppointments({
    ClosestAppointment closestAppointment,
    Function onPressed,
  }) {
    var parsedDate = DateTime.parse(closestAppointment.date.substring(0, 10));
    String textDate = DateFormat("d MMMM yyyy").format(parsedDate);

    return Center(
      child: Column(
        children: [
          //
          InkWell(
            child: Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 46,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      closestAppointment.hospitalId == 1
                          ? "Ayrancı"
                          : closestAppointment.hospitalId == 7
                              ? "Çayyolu"
                              : "Online",
                      style: TextStyle(color: R.color.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      textDate,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        onPressed();
                      },
                      child: AnimatedFadedWidget(
                        child: Text(
                          LocaleProvider.of(context).click_go,
                          style: TextStyle(color: R.color.white),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    // FadeAnimatedTextKit(
                    //   repeatForever: true,

                    //   onTap: () {
                    //     onPressed();
                    //   },
                    //   text: [LocaleProvider.of(context).click_go],
                    //   textStyle: TextStyle(color: R.color.white),
                    //   textAlign: TextAlign.start,
                    // )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: closestAppointment.hospitalId == 1
                    ? R.color.ayranci
                    : closestAppointment.hospitalId == 7
                        ? R.color.cayyolu
                        : R.color.online_appointment,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: R.color.dark_black.withAlpha(25),
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            onTap: () {
              onPressed();
            },
          ),
        ],
      ),
    );
  }
}
