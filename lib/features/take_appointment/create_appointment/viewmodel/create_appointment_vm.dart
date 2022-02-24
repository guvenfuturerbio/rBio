import 'package:flutter/material.dart';
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

  List<FilterTenantsResponse>? tenantsFilterResponse;
  List<FilterDepartmentsResponse>? filterDepartmentResponse;
  List<FilterResourcesResponse>? filterResourceResponse;

  LoadingProgress relativeProgress = LoadingProgress.loading;
  LoadingProgress progress = LoadingProgress.loading;
  LoadingProgress departmentProgress = LoadingProgress.loading;
  LoadingProgress doctorProgress = LoadingProgress.loading;

  FilterTenantsResponse? dropdownValueTenant;
  FilterDepartmentsResponse? dropdownValueDepartment;
  FilterResourcesResponse? dropdownValueDoctor;

  bool hospitalSelected = false;
  bool departmentSelected = false;
  bool doctorSelected = false;

  PatientRelativeInfoResponse? relativeResponse;
  late PatientRelative dropdownValueRelative;

  //For favorites
  DateTime? _startDate;
  DateTime? _endDate;
  int? _patientId;
  List<PatientAppointmentsResponse>? patientAppointments;
  List<PatientAppointmentsResponse> holderForFavorites = [];
  final List<String> doctorsImageUrls = [];
  List<int> _doctorsIds = [];

  // #region Getters

  DateTime get startDate {
    return DateTime(
        _startDate?.year ?? DateTime.now().year - 1,
        _startDate?.month ?? DateTime.now().month,
        _startDate?.day ?? DateTime.now().day);
  }

  DateTime get endDate {
    return DateTime(
        _endDate?.year ?? DateTime.now().year + 1,
        _endDate?.month ?? DateTime.now().month,
        _endDate?.day ?? DateTime.now().day,
        23,
        59,
        59);
  }

  // #endregion

  CreateAppointmentVm({
    required this.mContext,
    required this.forOnline,
    required this.fromSearch,
    required this.fromSymptom,
    int? tenantId,
    int? departmentId,
    int? resourceId,
  }) {
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
        dropdownValueTenant = FilterTenantsResponse(
          id: R.dynamicVar.onlineAppointmentType,
          enabled: true,
          title: LocaleProvider.current.online_appo,
        );
      } else {
        await fetchTenants();
      }

      if (getIt<UserNotifier>().canAccessHospital()) {
        fetchPatientAppointments(mContext);
      }

      if (fromSearch) {
        if (tenantId != null && departmentId != null && resourceId != null) {
          fillFromSearch(tenantId, departmentId, resourceId);
        }
      } else {
        forOnline
            ? LoggerUtils.instance.d("For online!")
            : fromSymptom
                ? LoggerUtils.instance.d("From smyptom!")
                : clearFunc(Fields.tenant);
      }

      if (fromSymptom) {
        if (tenantId != null && departmentId != null) {
          fillFromSymptom(tenantId, departmentId);
        }
      }
    });
  }

  Future<void> fillFromSymptom(int tenantId, int departmentId) async {
    try {
      if (!forOnline) {
        for (var tenant in tenantsFilterResponse!) {
          if (tenant.id == tenantId) {
            await hospitalSelection(tenant);
          }
        }
      }

      for (var department in filterDepartmentResponse!) {
        if (department.id == departmentId) {
          await departmentSelection(department);
        }
      }
    } catch (e) {
      LoggerUtils.instance.e("fillFromSymptom: $e");
    }
  }

  Future<void> fillFromSearch(
    int tenantId,
    int departmentId,
    int resourceId,
  ) async {
    try {
      if (tenantsFilterResponse != null) {
        for (var tenant in tenantsFilterResponse!) {
          if (tenant.id == tenantId) {
            await hospitalSelection(tenant);
          }
        }
      }

      for (var department in filterDepartmentResponse!) {
        if (department.id == departmentId) {
          await departmentSelection(department);
        }
      }

      for (var doctor in filterResourceResponse!) {
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
        for (var tenant in tenantsFilterResponse!) {
          if (tenant.id == holderForFavorites[index].tenantId) {
            await hospitalSelection(tenant);
          }
        }
      }

      for (var department in filterDepartmentResponse!) {
        if (department.id ==
            holderForFavorites[index].resources?.first.departmentId) {
          LoggerUtils.instance.i(
              'departman : ${department.title} --> departmanId : ${department.id}');
          await departmentSelection(department);
        }
      }

      for (var doctor in filterResourceResponse!) {
        if (doctor.id ==
            holderForFavorites[index].resources?.first.resourceId) {
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
    progress = LoadingProgress.loading;
    notifyListeners();
    try {
      tenantsFilterResponse = await getIt<Repository>()
          .filterTenants(FilterTenantsRequest(departmanId: null));
      tenantsFilterResponse = removeOtherTenants(tenantsFilterResponse!);
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      progress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchRelatives
  Future<void> fetchRelatives() async {
    relativeProgress = LoadingProgress.loading;
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
    ColumnsObject columnsObject = ColumnsObject();
    columnsObject.search = searchObject;
    columnsObject.orderable = true;
    columnsObject.name = "null";
    columnsObject.data = "patient.user.name";
    columnsObject.searchable = true;
    bodyPages.columns?.add(columnsObject);

    bodyPages.order = <OrderObject>[];
    OrderObject orderObject = OrderObject();
    orderObject.column = 0;
    orderObject.dir = "desc";
    bodyPages.order?.add(orderObject);

    try {
      relativeResponse = await getIt<Repository>().getAllRelatives(bodyPages);
      if (relativeResponse == null ||
          relativeResponse?.patientRelatives == []) {
        relativeResponse = PatientRelativeInfoResponse([]);
      }
      final currentPatient = getIt<UserNotifier>().getPatient();
      relativeResponse = PatientRelativeInfoResponse(
        [
          PatientRelative(
            name: currentPatient.firstName,
            surname: currentPatient.lastName,
            tcNo: currentPatient.identityNumber,
            id: currentPatient.id.toString(),
          ),
          ...relativeResponse!.patientRelatives,
        ],
      );
      dropdownValueRelative = relativeResponse!.patientRelatives.first;
      relativeProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      relativeProgress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchOnlineDepartments
  Future<void> fetchOnlineDepartments(
    FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest,
  ) async {
    try {
      progress = LoadingProgress.loading;
      departmentProgress = LoadingProgress.loading;
      notifyListeners();
      filterDepartmentResponse = await getIt<Repository>()
          .fetchOnlineDepartments(filterOnlineDepartmentsRequest);
      List<String> string = [];
      for (var element in filterDepartmentResponse!) {
        string.add(element.title ?? '');
      }
      string = string..sort(turkish.comparator);
      List<FilterDepartmentsResponse> temp = [];
      for (var element in string) {
        for (var element2 in filterDepartmentResponse!) {
          if (element == element2.title && !temp.contains(element2)) {
            temp.add(element2);
          }
        }
      }
      temp.insert(
        0,
        FilterDepartmentsResponse(
          enabled: false,
          id: -2,
          title: LocaleProvider.current.pls_select,
          tenants: [],
        ),
      );
      filterDepartmentResponse = temp;
      progress = LoadingProgress.done;
      departmentProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );

      progress = LoadingProgress.error;
      departmentProgress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchDepartments
  Future<void> fetchDepartments(
    FilterDepartmentsRequest filterDepartmentsRequest,
  ) async {
    try {
      departmentProgress = LoadingProgress.loading;
      notifyListeners();
      List<String> string = [];

      filterDepartmentResponse =
          await getIt<Repository>().filterDepartments(filterDepartmentsRequest);
      filterDepartmentResponse?.forEach((element) {
        string.add(element.title ?? "");
      });
      string = string..sort(turkish.comparator);
      List<FilterDepartmentsResponse> temp = [];
      for (var element in string) {
        filterDepartmentResponse?.forEach((element2) {
          if (element == element2.title && !temp.contains(element2)) {
            temp.add(element2);
          }
        });
      }

      temp.insert(
        0,
        FilterDepartmentsResponse(
          enabled: false,
          id: -2,
          title: LocaleProvider.current.pls_select,
          tenants: [],
        ),
      );
      filterDepartmentResponse = temp;
      departmentProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      departmentProgress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchResources
  Future<void> fetchResources(
    FilterResourcesRequest filterResourcesRequest,
  ) async {
    doctorProgress = LoadingProgress.loading;
    notifyListeners();

    try {
      filterResourceResponse =
          await getIt<Repository>().filterResources(filterResourcesRequest);

      filterResourceResponse!.sort((a, b) {
        return (a.title ?? '').compareTo((b.title ?? ''));
      });

      filterResourceResponse!.insert(
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
      doctorProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      doctorProgress = LoadingProgress.error;
      notifyListeners();
    }
  }
  // #endregion

  // #region hospitalSelection
  Future<void> hospitalSelection(
      FilterTenantsResponse selectionResponse) async {
    clearFunc(Fields.tenant);
    dropdownValueTenant = selectionResponse;
    if (selectionResponse.id != -2) {
      await fetchDepartments(FilterDepartmentsRequest(
          search: null, tenantId: selectionResponse.id));
      hospitalSelected = true;
      notifyListeners();
    } else {
      hospitalSelected = false;
      notifyListeners();
    }
  }
  // #endregion

  // #region departmentSelection
  // try
  Future<void> departmentSelection(
      FilterDepartmentsResponse selectionResponse) async {
    clearFunc(Fields.department);
    dropdownValueDepartment = selectionResponse;
    if (selectionResponse.id != -2) {
      await fetchResources(
        FilterResourcesRequest(
          tenantId: dropdownValueTenant?.id,
          departmentId: selectionResponse.id,
          search: null,
        ),
      );
      departmentSelected = true;
      notifyListeners();
    } else {
      departmentSelected = false;
      notifyListeners();
    }
  }
  // #endregion

  // #region doctorSelection
  void doctorSelection(FilterResourcesResponse selectionResponse) {
    dropdownValueDoctor = selectionResponse;
    if (selectionResponse.id != -2) {
      doctorSelected = true;
      notifyListeners();
    } else {
      doctorSelected = false;
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
        filterResourceResponse?.clear();
        dropdownValueDoctor = null;
        doctorSelected = false;
        break;
      case Fields.tenant:
        filterResourceResponse?.clear();
        filterDepartmentResponse?.clear();
        dropdownValueDoctor = null;
        dropdownValueDepartment = null;
        departmentSelected = false;
        break;
      case Fields.doctors:
      case Fields.relative:
        break;
    }
    notifyListeners();
  }
  // #endregion

  // #region removeOtherTenants
  List<FilterTenantsResponse>? removeOtherTenants(
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
      dropdownValueTenant = removedTenants.first;
      notifyListeners();
      //removedTenants.add(onlineAppoTenant);
      return removedTenants;
    } catch (e) {
      progress = LoadingProgress.error;
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
    progress = LoadingProgress.loading;
    notifyListeners();
    try {
      patientAppointments = await getIt<Repository>().getPatientAppointments(
        PatientAppointmentRequest(
          patientId: _patientId,
          to: endDate.toString(),
          from: startDate.toString(),
        ),
      );

      await holderListFillFunc();
      for (var element in holderForFavorites) {
        final doctorId = slugify(Utils.instance.clearDoctorTitle(element
            .resources!.first.resource!
            .toLowerCase()
            .xTurkishCharacterToEnglish));
        try {
          DoctorCvResponse tmpResp =
              await getIt<Repository>().getDoctorCvDetails(doctorId);
          doctorsImageUrls.add(SecretHelper.instance.get(SecretKeys.dev4Guven) +
              "/storage/app/media/" +
              tmpResp.image1!);
        } catch (e) {
          doctorsImageUrls.add(R.image.circlevatar);
        }
      }

      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      LoggerUtils.instance.i(e);
      progress = LoadingProgress.error;
      notifyListeners();
      showGradientDialog(context, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  Future<void> holderListFillFunc() async {
    holderForFavorites = [];
    _doctorsIds = [];
    for (var appo in patientAppointments!) {
      _doctorsIds.add(appo.resources!.first.resourceId!);
    }
    LoggerUtils.instance.i('Current doctor ids: -->' + _doctorsIds.toString());
    _doctorsIds = _doctorsIds.toSet().toList();
    LoggerUtils.instance
        .i('Removed duplicates ids: -->' + _doctorsIds.toString());

    if (_doctorsIds.length >= 4) {
      for (var index = 0; index < 4; index++) {
        holderForFavorites.add(patientAppointments!.firstWhere((element) =>
            element.resources?.first.resourceId == _doctorsIds[index]));
      }
    } else {
      for (var index = 0; index < _doctorsIds.length; index++) {
        holderForFavorites.add(patientAppointments!.firstWhere((element) =>
            element.resources?.first.resourceId == _doctorsIds[index]));
      }
    }
    notifyListeners();
  }
}
