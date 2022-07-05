import 'package:dart_date/dart_date.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../create_appointment/model/find_resource_available_days_request.dart';
import '../../create_appointment/model/resource_request.dart';
import '../model/get_events_response.dart';

class CreateAppointmentEventsVm extends ChangeNotifier {
  final BuildContext mContext;
  final int tenantId;
  final int resourceId;
  final int departmentId;
  final bool forOnline;

  int? patientId = getIt<UserNotifier>().getPatient().id;

  DateTime _selectedDate = DateTime.now();
  late String filterFromDate;
  late String filterToDate;

  LoadingProgress? slotsProgress;
  LoadingProgress? availableDatesProgress;
  List<ResourcesRequest> resourceRequestList = [];
  late Map<String, List<ResourcesRequest>> availableSlots;

  List<DateTime> availableDates = [];

  late DateTime initDate;

  CreateAppointmentEventsVm({
    required this.mContext,
    required this.tenantId,
    required this.departmentId,
    required this.resourceId,
    required this.forOnline,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setFilterRangeDate(DateTime.now());

      if (!forOnline) {
        if (tenantId == 1) {
          resourceRequestList.add(getAyranciResource());
        } else if (tenantId == 7) {
          resourceRequestList.add(getCayyoluResource());
        }
      } else {
        resourceRequestList.add(getAyranciResource());
        resourceRequestList.add(getCayyoluResource());
      }

      await getAvailableDates(DateTime.now(), true);
    });
  }

  DateTime get selectedDate => _selectedDate;

  Future<void> getAvailableDates(DateTime date, bool isFirstLaunch) async {
    initDate = date;
    availableDatesProgress = LoadingProgress.loading;
    slotsProgress = LoadingProgress.loading;
    notifyListeners();

    try {
      if (forOnline) {
        availableDates.addAll(await getAvailableLists(date, true, 1));
        availableDates.addAll(await getAvailableLists(date, true, 7));
      } else {
        if (availableDates.isNotEmpty) {
          var tmpList = await getAvailableLists(date, false, tenantId);
          for (var item in tmpList) {
            if (!(availableDates.any((element) => element.xIsSameDate(item)))) {
              availableDates.add(item);
            }
          }
          //availableDates = await getAvailableLists(date, false, tenantId);
        } else {
          availableDates = await getAvailableLists(date, false, tenantId);
        }
      }
      availableDates.sort();
      if (isFirstLaunch && availableDates.isNotEmpty) {
        //? Şimdiki tarihden önce gelen günler takvimi patlattığı için önceki günler silindi..
        availableDates.removeWhere(
            (DateTime element) => element.isBefore(DateTime.now()));
        initDate = availableDates.first;
      }

      await setSelectedDate(initDate, true);
      availableDatesProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      availableDatesProgress = LoadingProgress.error;
      notifyListeners();
    }
  }

  Future<List<DateTime>> getAvailableLists(
      DateTime date, bool isOnline, int tenantId) async {
    return (await getIt<Repository>().findResourceAvailableDays(
      FindResourceAvailableDaysRequest(
        appointmentType: isOnline ? 256 : 1,
        resourceRequest: ResourceRequest(
          tenantId: tenantId,
          departmentId: departmentId,
          resourceId: resourceId,
          from: date.toIso8601String(),
          to: date
              .add(const Duration(days: 30))
              .xLastDayOfMonth
              .toIso8601String(),
        ),
      ),
    ))
        .map((e) => DateTime.parse(e.day!).toLocal())
        .toList();
  }

  Future<void> setSelectedDate(DateTime date, bool fetchData) async {
    _selectedDate = date;
    setFilterRangeDate(date);
    for (var data in resourceRequestList) {
      data.from = filterFromDate;
      data.to = filterToDate;
    }
    notifyListeners();
    if (fetchData) {
      await fetchEventsForSelected();
    }
  }

  void setFilterRangeDate(DateTime dateTime) {
    final filterFromDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
    final filterToDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
    this.filterFromDate = convertDatetime(filterFromDate);
    this.filterToDate = convertDatetime(filterToDate);
  }

  String convertDatetime(DateTime dateTime) => dateTime.xFormatTime6();

  String getToDateNextMonth(DateTime dateTime) {
    final dateNextMonth =
        DateTime(dateTime.year, dateTime.month + 1, dateTime.day - 1, 0, 0, 0);
    return dateNextMonth.xFormatTime6();
  }

  ResourcesRequest getAyranciResource() => ResourcesRequest(
        departmentId: departmentId,
        tenantId: R.constants.tenantAyranciId,
        resourceId: resourceId,
        id: resourceId,
        to: filterToDate,
        from: filterFromDate,
      );

  ResourcesRequest getCayyoluResource() => ResourcesRequest(
        departmentId: departmentId,
        tenantId: R.constants.tenantCayyoluId,
        resourceId: resourceId,
        id: resourceId,
        to: filterToDate,
        from: filterFromDate,
      );

  Future<void> fetchEventsForSelected() async {
    if (availableDatesProgress == LoadingProgress.error) {
      return;
    }

    slotsProgress = LoadingProgress.loading;
    notifyListeners();

    try {
      if (forOnline) {
        final getOnlineEventsResponse = await getIt<Repository>().getEvents(
          GetEventsRequest(
            patientId: patientId,
            appointmentType: R.constants.onlineAppointmentType,
            resourcesRequestList: resourceRequestList,
          ),
        );
        availableSlots = await compute(
          calculateAppointmentHours,
          _EventArgs(getOnlineEventsResponse, true, filterFromDate,
              filterToDate, selectedDate),
        );
        // availableSlots = await calculateAppointmentHours(
        //   _EventArgs(
        //     getOnlineEventsResponse,
        //     true,
        //     filterFromDate,
        //     filterToDate,
        //   ),
        // );
        notifyListeners();
      } else {
        if (resourceRequestList.isNotEmpty) {
          final getEventsResponse = await getIt<Repository>().getEvents(
            GetEventsRequest(
              patientId: patientId,
              appointmentType: 1,
              resourcesRequestList: resourceRequestList,
            ),
          );
          availableSlots = await compute(
            calculateAppointmentHours,
            _EventArgs(getEventsResponse, false, filterFromDate, filterToDate,
                selectedDate),
          );
          // availableSlots = await calculateAppointmentHours(
          //   _EventArgs(
          //     getEventsResponse,
          //     false,
          //     filterFromDate,
          //     filterToDate,
          //   ),
          // );
          notifyListeners();
        }
      }

      slotsProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      slotsProgress = LoadingProgress.error;
      notifyListeners();
    }
  }

  bool dateContains(DateTime dayy) => availableDates
      .where((element) =>
          element.year == dayy.year &&
          element.month == dayy.month &&
          element.day == dayy.day)
      .toList()
      .isNotEmpty;
}

Future<Map<String, List<ResourcesRequest>>> calculateAppointmentHours(
    _EventArgs args) async {
  final appointments = <ResourcesRequest>[];

  try {
    for (var data in args.getEventsResponse) {
      DateTime dayStart =
          DateTime.parse(args.filterFromDate); // "2021-11-05T00:00:00"
      DateTime dayEnd =
          DateTime.parse(args.filterToDate); // "2021-11-05T23:59:59"
      List<DateTime> availableSlotsList = [];

      if (data.serviceTime != 0) {
        while (dayStart.isBefore(dayEnd)) {
          availableSlotsList.add(dayStart);
          dayStart = dayStart.addMinutes(5); // data.serviceTime
        }

        List<DateTime> tmp = [];
        for (var element in availableSlotsList) {
          tmp.add(element);
        }

        for (var event in (data.events ?? [])) {
          for (var element in availableSlotsList) {
            DateTime dateFrom = DateTime(
              DateTime.parse(args.filterFromDate).year,
              DateTime.parse(args.filterFromDate).month,
              DateTime.parse(args.filterFromDate).day,
              int.parse(event.from.substring(0, 2)),
              int.parse(event.from.substring(3, 5)),
              int.parse(event.from.substring(6, 8)),
            ).addMinutes(-(data.serviceTime ?? 0));

            DateTime dateTo = DateTime(
              DateTime.parse(args.filterFromDate).year,
              DateTime.parse(args.filterFromDate).month,
              DateTime.parse(args.filterFromDate).day,
              int.parse(event.to.substring(0, 2)),
              int.parse(event.to.substring(3, 5)),
              int.parse(event.to.substring(6, 8)),
            );

            if (element.isAfter(dateFrom) && element.isBefore(dateTo)) {
              tmp.remove(element);
            }
          }
        }

        availableSlotsList = tmp;
        List<DateTime> removedList = [];
        for (var item in availableSlotsList) {
          final stopTime = item.add(Duration(minutes: (data.serviceTime ?? 0)));
          if (!removedList.contains(item)) {
            for (var item2 in availableSlotsList) {
              if (item2.isAfter(item) && item2.isBefore(stopTime)) {
                removedList.add(item2);
              }
            }
          }
        }
        availableSlotsList =
            availableSlotsList.toSet().difference(removedList.toSet()).toList();

        if (availableSlotsList.isNotEmpty) {
          for (var element in availableSlotsList) {
            final itemDate = element.xTurkishTimeToLocal();
            if (itemDate.xIsSameDate(args.selectedDateTime ?? DateTime.now())) {
              appointments.add(
                ResourcesRequest(
                  from: convertDatetime(element),
                  to: convertDatetime(
                    element.addMinutes(data.serviceTime ?? 0),
                  ),
                  tenantId: data.resource?.tenantId,
                ),
              );
            }
            // appointments.add(
            //   ResourcesRequest(
            //     from: convertDatetime(element),
            //     to: convertDatetime(
            //       element.addMinutes(data.serviceTime ?? 0),
            //     ),
            //     tenantId: data.resource?.tenantId,
            //   ),
            // );
          }
        }
      }
    }

    return appointments.groupBy(
      (m) => m.from!.substring(11, 16).substring(0, 2),
    );
  } catch (e, stackTrace) {
    getIt<IAppConfig>()
        .platform
        .sentryManager
        .captureException(e, stackTrace: stackTrace);
    LoggerUtils.instance.e(e);
    return {};
  }
}

String convertDatetime(DateTime dateTime) => dateTime.xFormatTime6();

class _EventArgs {
  List<GetEventsResponse> getEventsResponse;
  bool forOnline;
  String filterFromDate;
  String filterToDate;
  DateTime? selectedDateTime;

  _EventArgs(this.getEventsResponse, this.forOnline, this.filterFromDate,
      this.filterToDate, this.selectedDateTime);
}

extension EventListExtension on List<ResourcesRequest> {
  List<ResourcesRequest> xToLocalDateHandler(DateTime selectedDate) {
    final result = where((item) {
      final itemDate =
          DateTime.parse(item.from.toString()).xTurkishTimeToLocal();
      return itemDate.xIsSameDate(selectedDate);
    }).toList();
    return result;
  }
}
