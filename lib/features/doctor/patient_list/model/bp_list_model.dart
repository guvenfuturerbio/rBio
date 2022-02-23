part of 'patient_list_model.dart';

class BpPatientListModel
    extends PatientListModel<DoctorBloodPressurePatientModel> {
  BpPatientListModel(
    BuildContext context,
    List<DoctorBloodPressurePatientModel> list,
  ) : super(context, list);

  @override
  List<PatientListItemModel> get getList => _filterList
      .map((e) => convertTo(e))
      .cast<PatientListItemModel>()
      .toList();

  @override
  PatientListItemModel convertTo(DoctorBloodPressurePatientModel model) {
    return PatientListItemModel(
      data: model,
      patientName: model.name,
      dates: (model.bpMeasurements ?? [])
          .map((item) => item.occurrenceTime != null
              ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime7()
              : '')
          .toList(),
      times: (model.bpMeasurements ?? [])
          .map((item) => item.occurrenceTime != null
              ? DateTime.parse(item.occurrenceTime ?? '').xFormatTime8()
              : '')
          .toList(),
      values: (model.bpMeasurements ?? [])
          .map((item) => '${item.sysValue}')
          .toList(),
    );
  }

  @override
  Color getBackColor(String text, DoctorBloodPressurePatientModel model) {
    return getIt<ITheme>().textColorPassive;
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
  void textOnChanged(String? text) {
    if (text == null || text == '') {
      _filterList = _list;
    } else {
      _filterList = _list
          .where((item) =>
              item.name?.toLowerCase().contains(text.toLowerCase()) ?? false)
          .toList();
    }
  }

  @override
  void filterList(DoctorPatientListSortType sortType) {
    switch (sortType) {
      case DoctorPatientListSortType.fromNewest:
        _filterList = _list
            .sortedBy((i) => i.bpMeasurements?.first.occurrenceTime ?? '')
            .toList()
            .reversed
            .toList();
        break;

      case DoctorPatientListSortType.fromOldest:
        _filterList = _list
            .sortedBy((i) => i.bpMeasurements?.first.occurrenceTime ?? '')
            .toList();
        break;

      default:
        break;
    }
  }

  @override
  void itemOnTap(DoctorBloodPressurePatientModel model) {
    Atom.to(PagePaths.doctorPressurePatientDetail, queryParameters: {
      'patientId': model.id.toString(),
      'patientName': model.name!,
    });
  }
}
