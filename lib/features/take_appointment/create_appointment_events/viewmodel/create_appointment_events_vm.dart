import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../create_appointment/model/find_resource_available_days_request.dart';
import '../../create_appointment/model/resource_request.dart';

class CreateAppointmentEventsVm extends ChangeNotifier {
  BuildContext mContext;
  int tenantId;
  int resourceId;
  int departmentId;
  bool forOnline;

  int patientId = PatientSingleton().getPatient().id;

  DateTime selectedDate = DateTime.now();
  String filterFromDate;
  String filterToDate;

  LoadingProgress slotsProgress;
  LoadingProgress availableDatesProgress;
  List<ResourcesRequest> resourceRequestList = [];
  Map<String, List<ResourcesRequest>> availableSlots;

  List<DateTime> availableDates = [];

  DateTime initDate;

  CreateAppointmentEventsVm({
    @required BuildContext context,
    @required this.tenantId,
    @required this.departmentId,
    @required this.resourceId,
    @required this.forOnline,
  }) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      initDate = DateTime.now();
      setFilterRangeDate(DateTime.now());
      if (tenantId == 1) {
        this.resourceRequestList.add(getAyranciResource());
      } else if (tenantId == 7) {
        this.resourceRequestList.add(getCayyoluResource());
      } else if (tenantId == 256) {
        this.resourceRequestList.add(getAyranciResource());
        this.resourceRequestList.add(getCayyoluResource());
      }

      await getAvailableDates(DateTime.now());
      await fetchEventsForSelected();
    });
  }

  Future<void> getAvailableDates(DateTime date) async {
    initDate = date;
    availableDatesProgress = LoadingProgress.LOADING;
    slotsProgress = null;
    notifyListeners();

    try {
      if (forOnline) {
        availableDates..addAll(await getAvailableLists(date, true, 1));
        availableDates..addAll(await getAvailableLists(date, true, 7));
      } else {
        availableDates = await getAvailableLists(date, false, tenantId);
      }

      availableDatesProgress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      availableDatesProgress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  Future<List<DateTime>> getAvailableLists(
      DateTime date, bool isOnline, int tenantId) async {
    return (await getIt<Repository>().findResourceAvailableDays(
      FindResourceAvailableDaysRequest(
        appointmentType: isOnline ? 256 : tenantId,
        resourceRequest: ResourceRequest(
          tenantId: tenantId,
          departmentId: departmentId,
          resourceId: resourceId,
          from: date.toIso8601String(),
          to: date.xLastDayOfMonth.toIso8601String(),
        ),
      ),
    ))
        .map((e) => DateTime.parse(e.day).toLocal())
        .toList();
  }

  Future<void> setSelectedDate(DateTime date, bool fetchData) async {
    this.selectedDate = date;
    setFilterRangeDate(date);
    for (var data in this.resourceRequestList) {
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
    this.slotsProgress = LoadingProgress.LOADING;
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

      this.slotsProgress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      this.slotsProgress = LoadingProgress.ERROR;
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
          availableSlotsList.forEach((element) {
            tmp.add(element);
          });

          data.events.forEach((event) {
            availableSlotsList.forEach((element) {
              DateTime dateFrom = DateTime(
                DateTime.parse(filterFromDate).year,
                DateTime.parse(filterFromDate).month,
                DateTime.parse(filterFromDate).day,
                int.parse(event.from.substring(0, 2)),
                int.parse(event.from.substring(3, 5)),
                int.parse(event.from.substring(6, 8)),
              ).addMinutes(-data.serviceTime);

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
            });
          });

          availableSlotsList = tmp;
          List<DateTime> removedList = [];
          availableSlotsList.forEach((item) {
            final stopTime = item.add(Duration(minutes: data.serviceTime));
            if (!removedList.contains(item)) {
              availableSlotsList.forEach((item2) {
                if (item2.isAfter(item) && item2.isBefore(stopTime)) {
                  removedList.add(item2);
                }
              });
            }
          });

          availableSlotsList = availableSlotsList
              .toSet()
              .difference(removedList.toSet())
              .toList();

          if (!availableSlotsList.isEmpty) {
            availableSlotsList.forEach(
              (element) {
                appointments.add(
                  ResourcesRequest(
                    from: convertDatetime(element),
                    to: convertDatetime(
                      element.addMinutes(data.serviceTime),
                    ),
                    tenantId: data.resource.tenantId,
                  ),
                );
              },
            );
          }
        }
      }

      availableSlots = appointments.groupBy(
        (m) => m.from.substring(11, 16).substring(0, 2),
      );
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
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
