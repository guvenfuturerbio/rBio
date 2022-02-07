part of 'patient_list_model.dart';

class PatientBloodGlucoseListModel
    extends PatientListModel<DoctorGlucosePatientModel> {
  PatientBloodGlucoseListModel(
    BuildContext context,
    List<DoctorGlucosePatientModel> list,
  ) : super(context, list);

  @override
  List<PatientListItemModel> get getList => _filterList
      .map((e) => convertTo(e))
      .cast<PatientListItemModel>()
      .toList();

  @override
  PatientListItemModel convertTo(DoctorGlucosePatientModel e) {
    return PatientListItemModel(
      data: e,
      patientName: e.name,
      dates: e.measurements
          !.map((item) => item.measurementTime != null
              ? DateTime.parse(item.measurementTime ?? '').xFormatTime7()
              : '')
          .toList(),
      times: e.measurements
          !.map((item) => item.measurementTime != null
              ? DateTime.parse(item.measurementTime ?? '').xFormatTime8()
              : '')
          .toList(),
      values: e.measurements!.map((item) => '${item.measurement}').toList(),
    );
  }

  @override
  Color getBackColor(String text, DoctorGlucosePatientModel model) {
    return text == '' || text == null
        ? getIt<ITheme>().cardBackgroundColor
        : Utils.instance.fetchMeasurementColor(
            measurement: _textToInt(text),
            criticMin: model.alertMin?.toInt() ?? 0,
            criticMax: model.alertMax?.toInt() ?? 0,
            targetMax: model.normalMax?.toInt() ?? 0,
            targetMin: model.normalMin?.toInt() ?? 0,
          );
  }

  @override
  List<Widget> getPopupWidgets({
    @required void Function(DoctorPatientListSortType sortType)? onSelect,
  }) {
    return [
      getPopupItem(
        LocaleProvider.of(context).critical_metrics,
        DoctorPatientListSortType.criticalMetrics,
        onSelect!,
      ),
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
    if (text == null || text == '') {
      _filterList = _list;
    } else {
      _filterList = _list
          .where((item) => item.name?.toLowerCase().contains(text.toLowerCase() )as bool)
          .toList();
    }
  }

  @override
  void filterList(DoctorPatientListSortType sortType) {
    switch (sortType) {
      case DoctorPatientListSortType.criticalMetrics:
        _filterList = _list.sortedBy((i) => i.name);
        break;

      case DoctorPatientListSortType.fromNewest:
        _filterList = _list.sortedBy((i) => i.alertMin);
        break;

      case DoctorPatientListSortType.fromOldest:
        _filterList = _list.sortedBy((i) => i.alertMax);
        break;

      default:
        break;
    }
  }

  @override
  void itemOnTap(DoctorGlucosePatientModel model) {
    Atom.to(
      PagePaths.doctorGlucosePatientDetailL,
      queryParameters: {
        'patientId': model.id.toString(),
        'patientName': model.name ??"",
      },
    );
  }

  // #region _textToInt
  int _textToInt(String text) {
    if (text == null) {
      return 0;
    } else if (text.isNotEmpty) {
      return int.parse(text);
    } else {
      return 0;
    }
  }
  // #endregion
}
