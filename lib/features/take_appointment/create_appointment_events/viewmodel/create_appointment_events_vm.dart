import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../create_appointment/model/find_resource_available_days_request.dart';
import '../../create_appointment/model/resource_request.dart';

class CreateAppointmentEventsVm extends ChangeNotifier {
  final BuildContext mContext;
  final int tenantId;
  final int resourceId;
  final int departmentId;
  final bool forOnline;

  int? patientId = getIt<UserNotifier>().getPatient().id;

  DateTime selectedDate = DateTime.now();
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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
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

  Future<void> getAvailableDates(DateTime date, bool isFirstLaunch) async {
    initDate = date;
    availableDatesProgress = LoadingProgress.loading;
    notifyListeners();

    try {
      if (forOnline) {
        availableDates.addAll(await getAvailableLists(date, true, 1));
        availableDates.addAll(await getAvailableLists(date, true, 7));
      } else {
        if (availableDates.isNotEmpty) {
          LoggerUtils.instance.w(availableDates.length);
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
      if (isFirstLaunch) {
        initDate = availableDates.first;
      }

      await setSelectedDate(initDate, true);
      availableDatesProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
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
    selectedDate = date;
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
        tenantId: R.dynamicVar.tenantAyranciId,
        resourceId: resourceId,
        id: resourceId,
        to: filterToDate,
        from: filterFromDate,
      );

  ResourcesRequest getCayyoluResource() => ResourcesRequest(
        departmentId: departmentId,
        tenantId: R.dynamicVar.tenantCayyoluId,
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
            appointmentType: R.dynamicVar.onlineAppointmentType,
            resourcesRequestList: resourceRequestList,
          ),
        );
        await calculateAppointmentHours(getOnlineEventsResponse, true);
      } else {
        if (resourceRequestList.isNotEmpty) {
          final getEventsResponse = await getIt<Repository>().getEvents(
            GetEventsRequest(
              patientId: patientId,
              appointmentType: 1,
              resourcesRequestList: resourceRequestList,
            ),
          );
          await calculateAppointmentHours(getEventsResponse, false);
        }
      }

      slotsProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      slotsProgress = LoadingProgress.error;
      notifyListeners();
    }
  }

  Future calculateAppointmentHours(
    List<GetEventsResponse> getEventsResponse,
    bool forOnline,
  ) async {
    final appointments = <ResourcesRequest>[];

    try {
      for (var data in getEventsResponse) {
        DateTime dayStart =
            DateTime.parse(filterFromDate); // "2021-11-05T00:00:00"
        DateTime dayEnd = DateTime.parse(filterToDate); // "2021-11-05T23:59:59"
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
                DateTime.parse(filterFromDate).year,
                DateTime.parse(filterFromDate).month,
                DateTime.parse(filterFromDate).day,
                int.parse(event.from.substring(0, 2)),
                int.parse(event.from.substring(3, 5)),
                int.parse(event.from.substring(6, 8)),
              ).addMinutes(-(data.serviceTime ?? 0));

              DateTime dateTo = DateTime(
                DateTime.parse(filterFromDate).year,
                DateTime.parse(filterFromDate).month,
                DateTime.parse(filterFromDate).day,
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
            final stopTime =
                item.add(Duration(minutes: (data.serviceTime ?? 0)));
            if (!removedList.contains(item)) {
              for (var item2 in availableSlotsList) {
                if (item2.isAfter(item) && item2.isBefore(stopTime)) {
                  removedList.add(item2);
                }
              }
            }
          }

          availableSlotsList = availableSlotsList
              .toSet()
              .difference(removedList.toSet())
              .toList();

          if (availableSlotsList.isNotEmpty) {
            for (var element in availableSlotsList) {
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
          }
        }
      }

      availableSlots = appointments.groupBy(
        (m) => m.from!.substring(11, 16).substring(0, 2),
      );
      notifyListeners();
    } catch (e) {
      LoggerUtils.instance.e(e);
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
