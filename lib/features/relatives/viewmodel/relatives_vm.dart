import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class RelativesVm extends ChangeNotifier {
  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;
  set state(LoadingProgress value) {
    _state = value;
    notifyListeners();
  }

  late PatientRelativeInfoResponse response;

  Future<void> getAll() async {
    state = LoadingProgress.loading;

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
      response = await getIt<Repository>().getAllRelatives(bodyPages);
      if (response.patientRelatives == []) {
        response = PatientRelativeInfoResponse([]);
      }
      state = LoadingProgress.done;
    } catch (e) {
      state = LoadingProgress.error;
    }
  }
}
