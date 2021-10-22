import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class EventsScreenVm extends ChangeNotifier {
  int patientId = PatientSingleton().getPatient().id;
  int AYRANCI = 1;
  int CAYYOLU = 7;
  BuildContext mContext;
  bool _ayranciSelected, _cayyoluSelected, _onlineSelected;
  DateTime _selectedDate;
  String _filterFromDate;
  String _filterToDate;
  int tenantId;
  int resourceId;
  int departmentId;
  LoadingProgress _progress;
  List<ResourcesRequest> _resourceRequestList = [];
  List<GetEventsResponse> _getEventsResponse = [];
  List<GetEventsResponse> _getOnlineEventsResponse = [];
  List<GetEventsResponse> _getResourceClosestAvailableResponse = [];
  List<GetEventsResponse> _getOnlineResourceClosestAvailableResponse = [];
  List<ResourcesRequest> _ayranciSlots;
  List<ResourcesRequest> _cayyoluSlots;
  List<ResourcesRequest> _onlineSlots;
  int _onlineSlotsHospital;
  DateTime _ayranciClosestDate, _cayyoluClosestDate;
  List<ClosestAppointment> _closestAppointment;

  EventsScreenVm({
    BuildContext context,
    int tenantId,
    int departmentId,
    int resourceId,
    bool fromOnlineSelect,
  }) {
    this.mContext = context;
    this.tenantId = tenantId;
    this.resourceId = resourceId;
    this.departmentId = departmentId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setFilterRangeDate(DateTime.now());
      if (fromOnlineSelect) {
        await toggleOnlineSelected();
      } else {
        if (tenantId == 1) {
          await toggleAyranciSelected();
        }
        if (tenantId == 7) {
          await toggleCayyoluSelected();
        }
      }
    });
  }

  bool get ayranciSelected => this._ayranciSelected ?? false;

  bool get cayyoluSelected => this._cayyoluSelected ?? false;

  bool get onlineSelected => this._onlineSelected ?? false;

  DateTime get selectedDate => this._selectedDate ?? DateTime.now();

  String get filterFromDate => this._filterFromDate;

  String get filterToDate => this._filterToDate;

  List<ResourcesRequest> get resourcesRequestList => this._resourceRequestList;

  List<ResourcesRequest> get resourcesRequestListForClosest =>
      [getCayyoluResource(), getAyranciResource()];

  List<ResourcesRequest> get ayranciSlots => this._ayranciSlots ?? [];

  List<ResourcesRequest> get cayyoluSlots => this._cayyoluSlots ?? [];

  List<ResourcesRequest> get onlineSlots => this._onlineSlots ?? [];

  LoadingProgress get progress => this._progress;

  List<GetEventsResponse> get resourceClosestAvailableResponse =>
      this._getResourceClosestAvailableResponse;

  List<GetEventsResponse> get onlineResourceClosestAvailableResponse =>
      this._getOnlineResourceClosestAvailableResponse;

  DateTime get ayranciClosestDate => this._ayranciClosestDate;

  DateTime get cayyoluClosestDAte => this._cayyoluClosestDate;

  List<ClosestAppointment> get closestAppointments => this._closestAppointment;

  int get onlineSlotsHospital => this._onlineSlotsHospital;

  toggleAyranciSelected() async {
    this._ayranciSelected = !ayranciSelected;
    notifyListeners();
    if (ayranciSelected) {
      this._resourceRequestList.add(getAyranciResource());
      notifyListeners();
    } else {
      this._ayranciSlots.clear();
      this._resourceRequestList.removeWhere((item) => item.tenantId == AYRANCI);
      notifyListeners();
    }
    await fetchEventsForSelected();
  }

  toggleCayyoluSelected() async {
    this._cayyoluSelected = !cayyoluSelected;
    notifyListeners();
    if (cayyoluSelected) {
      this._resourceRequestList.add(getCayyoluResource());
      notifyListeners();
    } else {
      this._cayyoluSlots.clear();
      this._resourceRequestList.removeWhere((item) => item.tenantId == CAYYOLU);
      notifyListeners();
    }
    await fetchEventsForSelected();
  }

  toggleOnlineSelected() async {
    this._onlineSelected = !onlineSelected;
    notifyListeners();
    if (!onlineSelected) {
      this._onlineSlots.clear();
      notifyListeners();
    }
    await fetchEventsForSelected();
  }

  setSelectedDate(DateTime date) async {
    this._selectedDate = date;
    setFilterRangeDate(date);
    for (var data in this._resourceRequestList) {
      data.from = filterFromDate;
      data.to = filterToDate;
    }
    notifyListeners();
    await fetchEventsForSelected();
  }

  setSelectedClosestDate(ClosestAppointment closestAppointment) async {
    this._selectedDate =
        DateTime.parse(closestAppointment.date.substring(0, 10));
    setFilterRangeDate(
        DateTime.parse(closestAppointment.date.substring(0, 10)));
    for (var data in this._resourceRequestList) {
      data.from = filterFromDate;
      data.to = filterToDate;
    }
    notifyListeners();
    if (closestAppointment.hospitalId == 1) {
      this._ayranciSelected = true;
      this._resourceRequestList.removeWhere((element) => element.tenantId == 1);
      this._resourceRequestList.add(getAyranciResource());
      notifyListeners();
      await fetchEventsForSelected();
    }
    if (closestAppointment.hospitalId == 7) {
      this._cayyoluSelected = true;
      this._resourceRequestList.removeWhere((element) => element.tenantId == 7);
      this._resourceRequestList.add(getCayyoluResource());
      notifyListeners();
      await fetchEventsForSelected();
    }
    if (closestAppointment.hospitalId == 256) {
      this._onlineSelected = true;
      notifyListeners();
      await fetchEventsForSelected();
    }
  }

  setFilterRangeDate(DateTime dateTime) {
    DateTime filterFromDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
    DateTime filterToDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
    this._filterFromDate = convertDatetime(filterFromDate);
    this._filterToDate = convertDatetime(filterToDate);
    notifyListeners();
  }

  convertDatetime(DateTime dateTime) {
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(dateTime);
    return dateFormatted;
  }

  getToDate(DateTime dateTime, int serviceTime) {
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute + serviceTime,
        dateTime.second));
    return dateFormatted;
  }

  getToDateNextMonth(DateTime dateTime) {
    DateTime dateNextMonth =
        DateTime(dateTime.year, dateTime.month + 1, dateTime.day - 1, 0, 0, 0);
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(dateNextMonth);
    return dateFormatted;
  }

  Future calculateAppointmentHours(
      List<GetEventsResponse> getEventsResponse, bool forOnline) async {
    try {
      List<ResourcesRequest> appointmentsAyranci = List<ResourcesRequest>();
      List<ResourcesRequest> appointmentsCayyolu = List<ResourcesRequest>();
      List<ResourcesRequest> appointmentsOnline = List<ResourcesRequest>();
      for (var data in getEventsResponse) {
        //DateTime startDate = DateTime.parse(filterFromDate);
        DateTime startDate = DateTime(
            DateTime.parse(filterFromDate).year,
            DateTime.parse(filterFromDate).month,
            DateTime.parse(filterFromDate).day,
            int.parse(data.events[0].to.substring(0, 2)),
            int.parse(data.events[0].to.substring(3, 5)),
            int.parse(data.events[0].to.substring(6, 8)));
        int start = startDate.millisecondsSinceEpoch;
        DateTime endDate = DateTime.parse(filterToDate);
        int end = endDate.millisecondsSinceEpoch;
        if (data.serviceTime > 0) {
          while (start < end) {
            bool isEmpty = await checkSlotIsEmpty(
                startDate, data.events, data.serviceTime);
            if (isEmpty) {
              forOnline
                  ? appointmentsOnline.add(ResourcesRequest(
                      from: convertDatetime(startDate),
                      to: getToDate(startDate, data.serviceTime)))
                  : data.resource.tenantId == 1
                      ? appointmentsAyranci.add(ResourcesRequest(
                          from: convertDatetime(startDate),
                          to: getToDate(startDate, data.serviceTime)))
                      : appointmentsCayyolu.add(ResourcesRequest(
                          from: convertDatetime(startDate),
                          to: getToDate(startDate, data.serviceTime)));
            }
            startDate = DateTime(
                startDate.year,
                startDate.month,
                startDate.day,
                startDate.hour,
                startDate.minute + data.serviceTime,
                startDate.second);
            start = startDate.millisecondsSinceEpoch;
            if (startDate.day != endDate.day) {
              break;
            }
          }
        }
      }
      if (forOnline) {
        this._onlineSlots = appointmentsOnline;
        this._onlineSlotsHospital = getEventsResponse[0].resource.tenantId;
      } else {
        this._cayyoluSlots = appointmentsCayyolu;
        this._ayranciSlots = appointmentsAyranci;
      }
      notifyListeners();
      if (cayyoluSlots.isEmpty && ayranciSlots.isEmpty && onlineSlots.isEmpty) {
        await fetchResourceClosestAvailableDate();
      }
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  Future<bool> checkSlotIsEmpty(
      DateTime dateTime, List<Events> events, int serviceTime) async {
    try {
      bool isEmpty = true;
      if (dateTime.millisecondsSinceEpoch >
          DateTime.now().millisecondsSinceEpoch) {
        int date = dateTime.millisecondsSinceEpoch;
        DateTime today = DateTime.parse(filterToDate);
        for (var event in events) {
          DateTime eventStartTime = DateTime(
              today.year,
              today.month,
              today.day,
              int.parse(event.from.substring(0, 2)),
              int.parse(event.from.substring(3, 5)),
              int.parse(event.from.substring(6, 8)));
          int startDate = eventStartTime.millisecondsSinceEpoch;
          DateTime eventEndTime = DateTime(
              today.year,
              today.month,
              today.day,
              int.parse(event.to.substring(0, 2)),
              int.parse(event.to.substring(3, 5)),
              int.parse(event.to.substring(6, 8)));
          int endDate = eventEndTime.millisecondsSinceEpoch;
          if (date >= startDate && date < endDate) {
            isEmpty = false;
          }
          DateTime slotEndDateTime =
              dateTime.add(Duration(minutes: serviceTime));
          int slotEndDate = slotEndDateTime.millisecondsSinceEpoch;
          if (slotEndDate > startDate && slotEndDate < endDate) {
            isEmpty = false;
          }
          if (startDate > date && endDate <= slotEndDate) {
            isEmpty = false;
          }
        }
      } else {
        isEmpty = false;
      }
      return isEmpty;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  ResourcesRequest getAyranciResource() {
    return ResourcesRequest(
      departmentId: departmentId,
      tenantId: AYRANCI,
      resourceId: resourceId,
      id: resourceId,
      to: filterToDate,
      from: filterFromDate,
    );
  }

  ResourcesRequest getCayyoluResource() {
    return ResourcesRequest(
      departmentId: departmentId,
      tenantId: CAYYOLU,
      resourceId: resourceId,
      id: resourceId,
      to: filterToDate,
      from: filterFromDate,
    );
  }

  Future<void> fetchResourceClosestAvailableDate() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._getResourceClosestAvailableResponse =
          await getIt<Repository>().findResourceClosestAvailablePlan(
        ResourceForAvailablePlanRequest(
          from: convertDatetime(DateTime.now()),
          to: getToDateNextMonth(DateTime.now()),
          resourcesRequestList: resourcesRequestListForClosest,
        ),
      );
      this._getOnlineResourceClosestAvailableResponse =
          await getIt<Repository>().findResourceClosestAvailablePlan(
        ResourceForAvailablePlanRequest(
          from: convertDatetime(DateTime.now()),
          to: getToDateNextMonth(DateTime.now()),
          appointmentType: 256, //video call
          resourcesRequestList: resourcesRequestListForClosest,
        ),
      );

      notifyListeners();
      await calculateClosestAvailableDate();
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  Future calculateClosestAvailableDate() async {
    try {
      List<ClosestAppointment> closestAppointment = <ClosestAppointment>[];
      for (var data in resourceClosestAvailableResponse) {
        if (data.serviceTime > 0) {
          if (data.resource.tenantId == 1) {
            this._ayranciClosestDate = DateTime.parse(data.resource.eventDate);
            closestAppointment.add(ClosestAppointment(
                date: data.resource.eventDate, hospitalId: 1));
          }
          if (data.resource.tenantId == 7) {
            this._cayyoluClosestDate = DateTime.parse(data.resource.eventDate);
            closestAppointment.add(ClosestAppointment(
                date: data.resource.eventDate, hospitalId: 7));
          }
        }
      }
      for (var data in onlineResourceClosestAvailableResponse) {
        if (data.serviceTime > 0) {
          if (data.resource.tenantId == 1) {
            this._ayranciClosestDate = DateTime.parse(data.resource.eventDate);
            closestAppointment.add(ClosestAppointment(
                date: data.resource.eventDate, hospitalId: 256));
          }
          if (data.resource.tenantId == 7) {
            this._cayyoluClosestDate = DateTime.parse(data.resource.eventDate);
            closestAppointment.add(ClosestAppointment(
                date: data.resource.eventDate, hospitalId: 256));
          }
        }
      }
      this._closestAppointment = closestAppointment;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  Future fetchEventsForSelected() async {
    this._progress = LoadingProgress.LOADING;
    this._closestAppointment = <ClosestAppointment>[];
    notifyListeners();

    try {
      if (onlineSelected) {
        this._getOnlineEventsResponse = await getIt<Repository>().getEvents(
          GetEventsRequest(
            patientId: patientId,
            appointmentType: 256,
            resourcesRequestList: [getAyranciResource(), getCayyoluResource()],
          ),
        );
        await calculateAppointmentHours(this._getOnlineEventsResponse, true);
      }

      if (resourcesRequestList.isNotEmpty) {
        this._getEventsResponse = await getIt<Repository>().getEvents(
          GetEventsRequest(
            patientId: patientId,
            appointmentType: 1,
            resourcesRequestList: resourcesRequestList,
          ),
        );
        await calculateAppointmentHours(this._getEventsResponse, false);
      }

      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }
}
