import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../viewmodel/patient_list_vm.dart';

part 'bg_list_model.dart';
part 'bp_list_model.dart';
part 'scale_list_model.dart';

abstract class PatientListModel<T> {
  final BuildContext context;
  final List<T> _list;

  PatientListModel(this.context, this._list) {
    _filterList = _list;
  }

  late List<T> _filterList;
  List<PatientListItemModel> get getList;
  int get getitemCount => _filterList.length;
  PatientListItemModel convertTo(T model);
  Color getBackColor(String text, T model);
  List<Widget> getPopupWidgets({
    required void Function(DoctorPatientListSortType sortType) onSelect,
  });
  void textOnChanged(String text);
  void filterList(DoctorPatientListSortType sortType);
  void itemOnTap(T model);

  Widget getPopupItem(
    String text,
    DoctorPatientListSortType sortType,
    void Function(DoctorPatientListSortType sortType) onSelect,
  ) {
    return GestureDetector(
      child: Container(
        color: getIt<IAppConfig>().theme.scaffoldBackgroundColor,
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: context.xHeadline4.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        onSelect(sortType);
      },
    );
  }
}

class PatientListItemModel {
  final dynamic data;
  final String? patientName;
  final List<String>? dates;
  final List<String>? times;
  final List<String>? values;

  PatientListItemModel({
    this.data,
    this.patientName,
    this.dates,
    this.times,
    this.values,
  });
}
