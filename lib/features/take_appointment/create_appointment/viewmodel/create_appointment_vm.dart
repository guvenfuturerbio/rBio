import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:slugify/slugify.dart';
import 'package:turkish/turkish.dart';

import '../../../../core/core.dart';
import '../../../../model/home/filter_tenants_response.dart';
import '../../../../model/home/take_appointment/filter_departments_request.dart';
import '../../../../model/home/take_appointment/filter_departments_response.dart';
import '../../../../model/home/take_appointment/filter_tenants_request.dart';
import '../../../../model/model.dart';

enum Fields { DEPARTMENT, TENANTS, DOCTORS, RELATIVE }

class CreateAppointmentVm extends ChangeNotifier {
  BuildContext mContext;
  bool forOnline;

  List<FilterTenantsResponse> _tenantsFilterResponse;
  List<FilterDepartmentsResponse> _filterDepartmentsResponse;
  List<FilterResourcesResponse> _filterResourcesResponse;

  LoadingProgress _relativeProgress = LoadingProgress.LOADING;
  LoadingProgress _progress = LoadingProgress.LOADING;
  LoadingProgress _departmentProgress = LoadingProgress.LOADING;
  LoadingProgress _doctorProgress = LoadingProgress.LOADING;

  FilterTenantsResponse _dropdownValueTenant;
  FilterDepartmentsResponse _dropdownValueDepartment;
  FilterResourcesResponse _dropdownValueDoctor;

  bool _hospitalSelected = false;
  bool _departmentSelected = false;
  bool _doctorSelected = false;

  PatientRelativeInfoResponse relativeResponse;
  PatientRelative dropdownValueRelative;

  //For favorites
  DateTime _startDate, _endDate;
  int _patientId;
  List<PatientAppointmentsResponse> _patientAppointments;
  List<PatientAppointmentsResponse> _holderForFavorites = [];
  List<String> _doctorsImageUrls = [];

  // #region Getters
  LoadingProgress get relativeProgress => this._relativeProgress;
  LoadingProgress get progress => this._progress;
  LoadingProgress get departmentProgress => this._departmentProgress;
  LoadingProgress get doctorProgress => this._doctorProgress;

  List<FilterTenantsResponse> get tenantsFilterResponse =>
      this._tenantsFilterResponse;
  List<FilterDepartmentsResponse> get filterDepartmentResponse =>
      this._filterDepartmentsResponse;
  List<FilterResourcesResponse> get filterResourcesResponse =>
      this._filterResourcesResponse;
  List<PatientAppointmentsResponse> get holderForFavorites =>
      _holderForFavorites;
  List<String> get doctorsImageUrls => _doctorsImageUrls;

  FilterTenantsResponse get dropdownValueTenant => this._dropdownValueTenant;
  FilterDepartmentsResponse get dropdownValueDepartment =>
      this._dropdownValueDepartment;
  FilterResourcesResponse get dropdownValueDoctor => this._dropdownValueDoctor;

  bool get hospitalSelected => this._hospitalSelected;
  bool get departmentSelected => this._departmentSelected;
  bool get doctorSelected => this._doctorSelected;

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59)
      : DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  List<PatientAppointmentsResponse> get patientAppointments =>
      this._patientAppointments;
  // #endregion

  CreateAppointmentVm({
    @required BuildContext context,
    @required bool forOnline,
  }) {
    this.mContext = context;
    this.forOnline = forOnline;
    this._patientId = PatientSingleton().getPatient().id;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      fetchRelatives();
      if (forOnline) {
        _hospitalSelected = true;
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

      if (getIt<UserInfo>().canAccessHospital()) {
        fetchPatientAppointments(context);
      }
    });
  }

  fillFromFavorites(int index) async {
    try {
      for (var tenant in tenantsFilterResponse) {
        if (tenant.id == _holderForFavorites[index].tenantId) {
          await hospitalSelection(tenant);
        }
      }
      for (var department in filterDepartmentResponse) {
        if (department.id ==
            _holderForFavorites[index].resources.first.departmentId) {
          await departmentSelection(department);
        }
      }
      for (var doctor in filterResourcesResponse) {
        if (doctor.id ==
            _holderForFavorites[index].resources.first.resourceId) {
          await doctorSelection(doctor);
        }
      }
    } catch (e) {
      print("fillFromFavorites: $e");
    }
    notifyListeners();
  }

  // #region fetchTenants
  Future<void> fetchTenants() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._tenantsFilterResponse = await getIt<Repository>()
          .filterTenants(FilterTenantsRequest(departmanId: null));
      this._tenantsFilterResponse =
          removeOtherTenants(this._tenantsFilterResponse);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchRelatives
  Future<void> fetchRelatives() async {
    _relativeProgress = LoadingProgress.LOADING;
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
    bodyPages.columns.add(columnsObject);

    bodyPages.order = <OrderObject>[];
    OrderObject orderObject = new OrderObject();
    orderObject.column = 0;
    orderObject.dir = "desc";
    bodyPages.order.add(orderObject);

    try {
      relativeResponse = await getIt<Repository>().getAllRelatives(bodyPages);
      if (relativeResponse == null || relativeResponse.patientRelatives == []) {
        relativeResponse = PatientRelativeInfoResponse([]);
      }
      final currentPatient = PatientSingleton().getPatient();
      relativeResponse = PatientRelativeInfoResponse(
        [
          PatientRelative(
            currentPatient.firstName,
            currentPatient.lastName,
            currentPatient.identityNumber,
            currentPatient.id.toString(),
          ),
          ...relativeResponse.patientRelatives,
        ],
      );
      dropdownValueRelative = relativeResponse.patientRelatives.first;
      _relativeProgress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      _relativeProgress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchOnlineDepartments
  Future<void> fetchOnlineDepartments(
    FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest,
  ) async {
    try {
      this._progress = LoadingProgress.LOADING;
      this._departmentProgress = LoadingProgress.LOADING;
      notifyListeners();

      this._filterDepartmentsResponse = await getIt<Repository>()
          .fetchOnlineDepartments(filterOnlineDepartmentsRequest);
      List<String> string = [];
      this._filterDepartmentsResponse.forEach((element) {
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
      this._progress = LoadingProgress.DONE;
      this._departmentProgress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );

      this._progress = LoadingProgress.ERROR;
      this._departmentProgress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchDepartments
  Future<void> fetchDepartments(
    FilterDepartmentsRequest filterDepartmentsRequest,
  ) async {
    try {
      this._departmentProgress = LoadingProgress.LOADING;
      notifyListeners();
      List<String> string = [];

      this._filterDepartmentsResponse =
          await getIt<Repository>().filterDepartments(filterDepartmentsRequest);
      this._filterDepartmentsResponse.forEach((element) {
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
      this._departmentProgress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      this._departmentProgress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }
  // #endregion

  // #region fetchResources
  Future<void> fetchResources(
    FilterResourcesRequest filterResourcesRequest,
  ) async {
    this._doctorProgress = LoadingProgress.LOADING;
    notifyListeners();

    try {
      this._filterResourcesResponse =
          await getIt<Repository>().filterResources(filterResourcesRequest);
      this._filterResourcesResponse.insert(
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
      this._doctorProgress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      this._doctorProgress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }
  // #endregion

  // #region hospitalSelection
  void hospitalSelection(FilterTenantsResponse selectionResponse) {
    clearFunc(Fields.TENANTS);
    _dropdownValueTenant = selectionResponse;
    if (selectionResponse.id != -2) {
      fetchDepartments(FilterDepartmentsRequest(
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
  void departmentSelection(FilterDepartmentsResponse selectionResponse) {
    clearFunc(Fields.DEPARTMENT);
    _dropdownValueDepartment = selectionResponse;
    if (selectionResponse.id != -2) {
      fetchResources(
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
      case Fields.DEPARTMENT:
        _filterResourcesResponse?.clear();
        _dropdownValueDoctor = null;
        _doctorSelected = false;
        break;
      case Fields.TENANTS:
        _filterResourcesResponse?.clear();
        _filterDepartmentsResponse?.clear();
        _dropdownValueDoctor = null;
        _dropdownValueDepartment = null;
        _departmentSelected = false;
        break;
      case Fields.DOCTORS:
      case Fields.RELATIVE:
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
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._patientAppointments =
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
              SecretUtils.instance.get(SecretKeys.DEV_4_GUVEN) +
                  "/storage/app/media/" +
                  tmpResp.image1);
        } catch (e) {
          _doctorsImageUrls.add(R.image.mockAvatar);
        }
      }
      ;
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      print(e);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
      showGradientDialog(context, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  holderListFillFunc() async {
    _holderForFavorites = [];
    if (_patientAppointments.length >= 4) {
      for (var item = 0; item < 4; item++) {
        if (!(_holderForFavorites.contains(_patientAppointments[item]))) {
          _holderForFavorites.add(_patientAppointments[item]);
        }
      }
    } else {
      for (var element in _patientAppointments) {
        if (!(_holderForFavorites.contains(element))) {
          _holderForFavorites.add(element);
        }
      }
    }
    notifyListeners();
  }
}
