part of 'patient_list_model.dart';

class BgPatientListModel extends PatientListModel<DoctorGlucosePatientModel> {
  BgPatientListModel(
    BuildContext context,
    List<DoctorGlucosePatientModel> list,
  ) : super(context, list);

  @override
  List<PatientListItemModel> get getList => _filterList
      .map((e) => convertTo(e))
      .cast<PatientListItemModel>()
      .toList();

  @override
  PatientListItemModel convertTo(DoctorGlucosePatientModel model) {
    return PatientListItemModel(
      data: model,
      patientName: model.name,
      dates: (model.measurements ?? [])
          .map((item) => item.measurementTime != null
              ? DateTime.parse(item.measurementTime ?? '').xFormatTime7()
              : '')
          .toList(),
      times: (model.measurements ?? [])
          .map((item) => item.measurementTime != null
              ? DateTime.parse(item.measurementTime ?? '').xFormatTime8()
              : '')
          .toList(),
      values: (model.measurements ?? [])
          .map((item) => '${item.measurement}')
          .toList(),
    );
  }

  @override
  Color getBackColor(String? text, DoctorGlucosePatientModel model) {
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
    required void Function(DoctorPatientListSortType sortType) onSelect,
  }) {
    return [
      getPopupItem(
        LocaleProvider.of(context).critical_metrics,
        DoctorPatientListSortType.criticalMetrics,
        onSelect,
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
      case DoctorPatientListSortType.criticalMetrics:
        _filterList = _list;
        _filterList.sort(criticalMetricsSort);
        break;

      case DoctorPatientListSortType.fromNewest:
        _filterList = _list
            .sortedBy((i) => i.measurements?.first.measurementTime ?? '')
            .toList()
            .reversed
            .toList();
        break;

      case DoctorPatientListSortType.fromOldest:
        _filterList = _list
            .sortedBy((i) => i.measurements?.first.measurementTime ?? '')
            .toList();
        break;

      default:
        break;
    }
  }

  int criticalMetricsSort(
      DoctorGlucosePatientModel a, DoctorGlucosePatientModel b) {
    final aMeasurements = a.measurements ?? [];
    final bMeasurements = b.measurements ?? [];

    double aSum = aMeasurements.fold<double>(
        0, (p, c) => p + (double.tryParse(c.measurement ?? '0') ?? 0.0));
    double bSum = bMeasurements.fold<double>(
        0, (p, c) => p + (double.tryParse(c.measurement ?? '0') ?? 0.0));

    if (aSum < bSum) {
      return -1;
    } else if (aSum > bSum) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void itemOnTap(DoctorGlucosePatientModel model) {
    Atom.to(
      PagePaths.doctorGlucosePatientDetailL,
      queryParameters: {
        'patientId': model.id.toString(),
        'patientName': model.name ?? "",
      },
    );
  }

  // #region _textToInt
  int _textToInt(String? text) {
    if (text == null) {
      return 0;
    } else if (text.isNotEmpty) {
      return (double.tryParse(text) ?? 0).toInt();
    } else {
      return 0;
    }
  }
  // #endregion
}
