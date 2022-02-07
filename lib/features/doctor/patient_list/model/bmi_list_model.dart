part of 'patient_list_model.dart';

class PatientBMIListModel extends PatientListModel<DoctorBMIPatientModel> {
  PatientBMIListModel(
    BuildContext context,
    List<DoctorBMIPatientModel> list,
  ) : super(context, list);

  @override
  List<PatientListItemModel> get getList => _filterList
      .map((e) => convertTo(e))
      .cast<PatientListItemModel>()
      .toList();

  @override
  PatientListItemModel convertTo(DoctorBMIPatientModel e) {
    return PatientListItemModel(
      data: e,
      patientName: e.name,
      dates: e.bmiMeasurements
          !.map((item) => item.occurrenceTime != null
              ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime7()
              : '')
          .toList(),
      times: e.bmiMeasurements
          !.map((item) => item.occurrenceTime != null
              ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime8()
              : '')
          .toList(),
      values: e.bmiMeasurements!.map((item) => '${item.weight}').toList(),
    );
  }

  @override
  Color getBackColor(String text, DoctorBMIPatientModel model) {
    return Colors.red;
  }

  @override
  List<Widget> getPopupWidgets({
    required void Function(DoctorPatientListSortType sortType)? onSelect,
  }) {
    return [
      getPopupItem(
        LocaleProvider.of(context).from_newest,
        DoctorPatientListSortType.fromNewest,
        onSelect,
      ),
    ];
  }

  @override
  void textOnChanged(String text) {
    if (text == null || text == '') {
      _filterList = _list;
    } else {
      _filterList = _list
          .where((item) => item.name!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
  }

  @override
  void filterList(DoctorPatientListSortType sortType) {
    switch (sortType) {
      case DoctorPatientListSortType.fromNewest:
        _filterList = _list.sortedBy((i) => i.name);
        break;

      default:
        break;
    }
  }

  @override
  void itemOnTap(DoctorBMIPatientModel model) {
    LoggerUtils.instance.i('OnTap : ${model.id}');
    LoggerUtils.instance.i('$model');

    Atom.to(
      PagePaths.doctorBmiPatientDetail,
      queryParameters: {
        'patientId': model.id.toString(),
        'patientName': model.name??"",
      },
    );
  }
}
