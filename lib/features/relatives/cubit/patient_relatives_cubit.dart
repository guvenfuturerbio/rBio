import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/data/repository/repository.dart';
import '../../../core/locator.dart';
import '../../../model/model.dart';

part 'patient_relatives_cubit.freezed.dart';
part 'patient_relatives_state.dart';

class PatientRelativesCubit extends Cubit<PatientRelativesState> {
  PatientRelativesCubit() : super(const PatientRelativesState.initial());

  Future<void> getAll() async {
    emit(const PatientRelativesState.loading());
    PatientRelativeInfoResponse response;

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

      emit(const PatientRelativesState.loaded());
    } catch (e) {
      emit(const PatientRelativesState.error());
    }
  }
}
