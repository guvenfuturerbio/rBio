part of 'patient_list_model.dart';

class ScalePatientListModel extends PatientListModel<DoctorBMIPatientModel> {
  ScalePatientListModel(
    BuildContext context,
    List<DoctorBMIPatientModel> list,
  ) : super(context, list);

  @override
  List<PatientListItemModel> get getList => _filterList
      .map((e) => convertTo(e))
      .cast<PatientListItemModel>()
      .toList();

  @override
  PatientListItemModel convertTo(DoctorBMIPatientModel model) {
    return PatientListItemModel(
      data: model,
      patientName: model.name,
      dates: (model.bmiMeasurements ?? [])
          .map((item) => item.occurrenceTime != null
              ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime7()
              : '')
          .toList(),
      times: (model.bmiMeasurements ?? [])
          .map((item) => item.occurrenceTime != null
              ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime8()
              : '')
          .toList(),
      values: (model.bmiMeasurements ?? [])
          .map((item) => '${item.weight}')
          .toList(),
    );
  }

  @override
  Color getBackColor(String text, DoctorBMIPatientModel model) {
    return getIt<IAppConfig>().theme.textColorPassive;
  }

  @override
  List<Widget> getPopupWidgets({
    required void Function(DoctorPatientListSortType sortType) onSelect,
  }) {
    return [
      getPopupItem(
        LocaleProvider.of(context).from_newest,
        DoctorPatientListSortType.fromNewest,
        onSelect,
      ),
      getPopupItem(
        LocaleProvider.of(context).from_oldest,
        DoctorPatientListSortType.fromOldest,
        onSelect,
      ),
    ];
  }

  @override
  void textOnChanged(String text) {
    if (text == '') {
      _filterList = _list;
    } else {
      _filterList = _list
          .where((item) =>
              (item.name ?? '').toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
  }

  @override
  void filterList(DoctorPatientListSortType sortType) {
    switch (sortType) {
      case DoctorPatientListSortType.fromNewest:
        _filterList = _list
            .xSortedBy((i) => i.bmiMeasurements?.first.occurrenceTime ?? '')
            .toList()
            .reversed
            .toList();
        break;

      case DoctorPatientListSortType.fromOldest:
        _filterList = _list
            .xSortedBy((i) => i.bmiMeasurements?.first.occurrenceTime ?? '')
            .toList();
        break;

      default:
        break;
    }
  }

  @override
  void itemOnTap(DoctorBMIPatientModel model) {
    Atom.to(
      PagePaths.doctorBmiPatientDetail,
      queryParameters: {
        'patientId': model.id.toString(),
        'patientName': model.name ?? "",
      },
    );
  }
}
