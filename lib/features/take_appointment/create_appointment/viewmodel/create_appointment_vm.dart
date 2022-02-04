import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:slugify/slugify.dart';
import 'package:turkish/turkish.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

enum Fields { department, tenant, doctors, relative }

class CreateAppointmentVm extends ChangeNotifier {
  BuildContext mContext;
  bool forOnline;
  late bool fromSearch;
  bool fromSymptom;

  List<FilterTenantsResponse> tenantsFilterResponse;
  List<FilterDepartmentsResponse> filterDepartmentsResponse;
  List<FilterResourcesResponse> filterResourcesResponse;

  LoadingProgress relativeProgress = LoadingProgress.loading;
  LoadingProgress progress = LoadingProgress.loading;
  LoadingProgress departmentProgress = LoadingProgress.loading;
  LoadingProgress doctorProgress = LoadingProgress.loading;

  FilterTenantsResponse? _dropdownValueTenant;
  FilterDepartmentsResponse? dropdownValueDepartment;
  FilterResourcesResponse? dropdownValueDoctor;

  bool hospitalSelected = false;
  bool departmentSelected = false;
  bool doctorSelected = false;

  PatientRelativeInfoResponse relativeResponse;
  PatientRelative dropdownValueRelative;

  //For favorites
  DateTime _startDate, _endDate;
  int? _patientId;
  List<PatientAppointmentsResponse> _patientAppointments;
  List<PatientAppointmentsResponse> _holderForFavorites = [];
  final List<String> _doctorsImageUrls = [];
  List<int> _doctorsIds = [];

  // #region Getters

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59)
      : DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  List<PatientAppointmentsResponse> get patientAppointments =>
      _patientAppointments;
  // #endregion

  CreateAppointmentVm(
      {required BuildContext context,
      required  this.forOnline,
      required this.fromSearch,
      required this. fromSymptom,
      int? tenantId,
      int? departmentId,
      int? resourceId}) {
    mContext = context;
    _patientId = getIt<UserNotifier>().getPatient().id;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      fetchRelatives();
      if (forOnline) {
        hospitalSelected = true;
        await fetchOnlineDepartments(
          FilterOnlineDepartmentsRequest(
            appointmentType: R.dynamicVar.onlineAppointmentType.toString(),
            tenantId: R.dynamicVar.tenantAyranciId,
          ),
        );
        _dropdownValueTenant = FilterTenantsResponse(
          id: R.dynamicVar.onlineAppointmentType,
          enabled: true,
          title: LocaleProvider.current.online_appo,
        );
      } else {
        await fetchTenants();
      }

      if (getIt<UserNotifier>().canAccessHospital()) {
        fetchPatientAppointments(context);
      }

      if (fromSearch) {
        if(tenantId !=null&& departmentId!=null&& resourceId!=null) {
          fillFromSearch(tenantId, departmentId, resourceId);
        }
      } else {
        forOnline
            ? LoggerUtils.instance.d("For online!")
            : fromSymptom
                ?LoggerUtils.instance.d("From smyptom!")
                : clearFunc(Fields.tenant);
      }

      if (fromSymptom) {
                if(tenantId !=null&& departmentId!=null) {

        fillFromSymptom(tenantId, departmentId);
      }}
    });
  }

  Future<void> fillFromSymptom(int tenantId, int departmentId) async {
    try {
      if (!forOnline) {
        for (var tenant in tenantsFilterResponse) {
          if (tenant.id == tenantId) {
            await hospitalSelection(tenant);
          }
        }
      }

      for (var department in filterDepartmentResponse) {
        if (department.id == departmentId) {
          await departmentSelection(department);
        }
      }
    } catch (e) {
      LoggerUtils.instance.e("fillFromSymptom: $e");
    }
  }

  Future<void> fillFromSearch(
      int tenantId, int departmentId, int resourceId) async {
    try {
      for (var tenant in tenantsFilterResponse) {
        if (tenant.id == tenantId) {
          await hospitalSelection(tenant);
        }
      }

      for (var department in filterDepartmentResponse) {
        if (department.id == departmentId) {
          await departmentSelection(department);
        }
      }

      for (var doctor in filterResourcesResponse) {
        if (doctor.id == resourceId) {
          doctorSelection(doctor);
        }
      }
    } catch (e) {
      LoggerUtils.instance.e("fillFromSearch: $e");
    }
  }

  Future<void> fillFromFavorites(int index) async {
    try {
      if (!forOnline) {
        for (var tenant in tenantsFilterResponse) {
          if (tenant.id == _holderForFavorites[index].tenantId) {
            await hospitalSelection(tenant);
          }
        }
      }

      for (var department in filterDepartmentResponse) {
        if (department.id ==
            _holderForFavorites[index].resources?.first.departmentId) {
          print(
              'departman : ${department.title} --> departmanId : ${department.id}');
          await departmentSelection(department);
        }
      }

      for (var doctor in filterResourcesResponse) {
        if (doctor.id ==
            _holderForFavorites[index].resources?.first.resourceId) {
          doctorSelection(doctor);
        }
      }
    } catch (e) {
      LoggerUtils.instance.e("fillFromFavorites: $e");
    }

    notifyListeners();
  }

  // #region fetchTenants
  Future<void> fetchTenants() async {
    _progress = LoadingProgress.loading;
    notifyListeners();
    try {
      _tenantsFilterResponse = await getIt<Repository>()
          .filterTenants(FilterTenantsRequest(departmanId: null));
      _tenantsFilterResponse =
          removeOtherTenants(_tenantsFilterResponse);
      _progress = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      _progress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchRelatives
  Future<void> fetchRelatives() async {
    _relativeProgress = LoadingProgress.loading;
    notifyListeners();

    GetAllRelativesRequest bodyPages = GetAllRelativesRequest();
    bodyPages.draw = 1;
    bodyPages.start = 0;
    bodyPages.length = "100";

    SearchObject searchObject = SearchObject();
    searchObject.value = "";
    searchObject.regex = false;
    bodyPages.search = SearchObject();
    bodyPages.search = searchObject;

    bodyPages.columns = <ColumnsObject>[];
    ColumnsObject columnsObject = new ColumnsObject();
    columnsObject.search = searchObject;
    columnsObject.orderable = true;
    columnsObject.name = "null";
    columnsObject.data = "patient.user.name";
    columnsObject.searchable = true;
    bodyPages.columns?.add(columnsObject);

    bodyPages.order = <OrderObject>[];
    OrderObject orderObject = new OrderObject();
    orderObject.column = 0;
    orderObject.dir = "desc";
    bodyPages.order?.add(orderObject);

    try {
      relativeResponse = await getIt<Repository>().getAllRelatives(bodyPages);
      if (relativeResponse == null || relativeResponse.patientRelatives == []) {
        relativeResponse = PatientRelativeInfoResponse([]);
      }
      final currentPatient = getIt<UserNotifier>().getPatient();
      relativeResponse = PatientRelativeInfoResponse(
        [
          PatientRelative(
          name:  currentPatient.firstName,
          surname:  currentPatient.lastName,
           tcNo: currentPatient.identityNumber,
           id: currentPatient.id.toString(),
          ),
          ...relativeResponse.patientRelatives,
        ],
      );
      dropdownValueRelative = relativeResponse.patientRelatives.first;
      _relativeProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      _relativeProgress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchOnlineDepartments
  Future<void> fetchOnlineDepartments(
    FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest,
  ) async {
    try {
      _progress = LoadingProgress.loading;
      _departmentProgress = LoadingProgress.loading;
      notifyListeners();

      _filterDepartmentsResponse = await getIt<Repository>()
          .fetchOnlineDepartments(filterOnlineDepartmentsRequest);
      List<String?> string = [];
      for (var element in _filterDepartmentsResponse) {
        string.add(element.title);
      }
      string = string..sort(turkish.comparator);
      List<FilterDepartmentsResponse> temp = [];
      string.forEach((element) {
        _filterDepartmentsResponse.forEach((element2) {
          if (element == element2.title && !temp.contains(element2)) {
            temp.add(element2);
          }
        });
      });
      temp.insert(
        0,
        FilterDepartmentsResponse(
          enabled: false,
          id: -2,
          title: LocaleProvider.current.pls_select,
          tenants: [],
        ),
      );
      _filterDepartmentsResponse = temp;
      _progress = LoadingProgress.done;
      _departmentProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );

      _progress = LoadingProgress.error;
      _departmentProgress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchDepartments
  Future<void> fetchDepartments(
    FilterDepartmentsRequest filterDepartmentsRequest,
  ) async {
    try {
      _departmentProgress = LoadingProgress.loading;
      notifyListeners();
      List<String> string = [];

      _filterDepartmentsResponse =
          await getIt<Repository>().filterDepartments(filterDepartmentsRequest);
      _filterDepartmentsResponse.forEach((element) {
        string.add(element.title);
      });
      string = string..sort(turkish.comparator);
      List<FilterDepartmentsResponse> temp = [];
      string.forEach((element) {
        _filterDepartmentsResponse.forEach((element2) {
          if (element == element2.title && !temp.contains(element2)) {
            temp.add(element2);
          }
        });
      });

      temp.insert(
        0,
        FilterDepartmentsResponse(
          enabled: false,
          id: -2,
          title: LocaleProvider.current.pls_select,
          tenants: [],
        ),
      );
      _filterDepartmentsResponse = temp;
      _departmentProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      _departmentProgress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchResources
  Future<void> fetchResources(
    FilterResourcesRequest filterResourcesRequest,
  ) async {
    _doctorProgress = LoadingProgress.loading;
    notifyListeners();

    try {
      _filterResourcesResponse =
          await getIt<Repository>().filterResources(filterResourcesRequest);
      _filterResourcesResponse.insert(
            0,
            FilterResourcesResponse(
              departments: [],
              enabled: false,
              gender: "male",
              id: -2,
              isOnline: false,
              isOnlineForWeb: false,
              isSSIContractor: true,
              isTSSContractor: true,
              tenants: [],
              title: LocaleProvider.current.pls_select,
            ),
          );
      _doctorProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      _doctorProgress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region hospitalSelection
  Future<void> hospitalSelection(
      FilterTenantsResponse selectionResponse) async {
    clearFunc(Fields.tenant);
    _dropdownValueTenant = selectionResponse;
    if (selectionResponse.id != -2) {
      await fetchDepartments(FilterDepartmentsRequest(
          search: null, tenantId: selectionResponse.id));
      _hospitalSelected = true;
      notifyListeners();
    } else {
      _hospitalSelected = false;
      notifyListeners();
    }
  }
  // #endregion

  // #region departmentSelection
  // try
  Future<void> departmentSelection(
      FilterDepartmentsResponse selectionResponse) async {
    clearFunc(Fields.department);
    _dropdownValueDepartment = selectionResponse;
    if (selectionResponse.id != -2) {
      await fetchResources(
        FilterResourcesRequest(
          tenantId: _dropdownValueTenant.id,
          departmentId: selectionResponse.id,
          search: null,
        ),
      );
      _departmentSelected = true;
      notifyListeners();
    } else {
      _departmentSelected = false;
      notifyListeners();
    }
  }
  // #endregion

  // #region doctorSelection
  void doctorSelection(FilterResourcesResponse selectionResponse) {
    _dropdownValueDoctor = selectionResponse;
    if (selectionResponse.id != -2) {
      _doctorSelected = true;
      notifyListeners();
    } else {
      _doctorSelected = false;
      notifyListeners();
    }
  }
  // #endregion

  // #region doctorSelection
  void relativeSelection(PatientRelative value) {
    dropdownValueRelative = value;
    notifyListeners();
  }
  // #endregion

  // #region clearFunc
  void clearFunc(Fields currentField) {
    switch (currentField) {
      case Fields.department:
        _filterResourcesResponse?.clear();
        _dropdownValueDoctor = null;
        _doctorSelected = false;
        break;
      case Fields.tenant:
        _filterResourcesResponse?.clear();
        _filterDepartmentsResponse?.clear();
        _dropdownValueDoctor = null;
        _dropdownValueDepartment = null;
        _departmentSelected = false;
        break;
      case Fields.doctors:
      case Fields.relative:
        break;
    }
    notifyListeners();
  }
  // #endregion

  // #region removeOtherTenants
  List<FilterTenantsResponse> removeOtherTenants(
    List<FilterTenantsResponse> tenantsResponse,
  ) {
    try {
      //final onlineAppoTenant = FilterTenantsResponse(enabled: true, id: -1);
      var removedTenants = <FilterTenantsResponse>[];
      for (var data in tenantsResponse) {
        if (data.id == 1 || data.id == 7) {
          data.id == 1
              ? data.title = "Güven Hastanesi Ayrancı"
              : data.title = "Güven Hastanesi Çayyolu";
          removedTenants.add(data);
        }
      }
      FilterTenantsResponse tmp = FilterTenantsResponse(
        enabled: false,
        id: -2,
        title: LocaleProvider.current.pls_select,
      );
      removedTenants.insert(0, tmp);
      _dropdownValueTenant = removedTenants.first;
      notifyListeners();
      //removedTenants.add(onlineAppoTenant);
      return removedTenants;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }
  }
  // #endregion

  // #region showGradientDialog
  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }
  // #endregion

  Future<void> fetchPatientAppointments(BuildContext context) async {
    _progress = LoadingProgress.loading
    notifyListeners();
    try {
      _patientAppointments =
          await getIt<Repository>().getPatientAppointments(
        PatientAppointmentRequest(
          patientId: _patientId,
          to: endDate.toString(),
          from: startDate.toString(),
        ),
      );

      await holderListFillFunc();
      for (var element in _holderForFavorites) {
        print(Slugify(Utils.instance.clearDoctorTitle(element
            .resources.first.resource
            .toLowerCase()
            .xTurkishCharacterToEnglish)));

        final doctorId = Slugify(Utils.instance.clearDoctorTitle(element
            .resources.first.resource
            .toLowerCase()
            .xTurkishCharacterToEnglish));
        try {
          DoctorCvResponse tmpResp =
              await getIt<Repository>().getDoctorCvDetails(doctorId);
          _doctorsImageUrls.add(
              SecretUtils.instance.get(SecretKeys.dev4Guven) +
                  "/storage/app/media/" +
                  tmpResp.image1);
        } catch (e) {
          _doctorsImageUrls.add(R.image.circlevatar);
        }
      }
      ;
      _progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      print(e);
      _progress = LoadingProgress.error;
      notifyListeners();
      showGradientDialog(context, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  Future<void> holderListFillFunc() async {
    _holderForFavorites = [];
    _doctorsIds = [];
    for (var appo in _patientAppointments) {
      _doctorsIds.add(appo.resources.first.resourceId);
    }
    print('Current doctor ids: -->' + _doctorsIds.toString());
    _doctorsIds = _doctorsIds.toSet().toList();
    print('Removed duplicates ids: -->' + _doctorsIds.toString());

    if (_doctorsIds.length >= 4) {
      for (var index = 0; index < 4; index++) {
        _holderForFavorites.add(_patientAppointments.firstWhere((element) =>
            element.resources.first.resourceId == _doctorsIds[index]));
      }
    } else {
      for (var index = 0; index < _doctorsIds.length; index++) {
        _holderForFavorites.add(_patientAppointments.firstWhere((element) =>
            element.resources.first.resourceId == _doctorsIds[index]));
      }
    }
    notifyListeners();
  }
}
