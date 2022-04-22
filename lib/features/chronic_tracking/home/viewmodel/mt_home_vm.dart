part of '../view/mt_home_screen.dart';

class _TempPressureModel {
  int? sys;
  int? dia;
  int? pulse;
  DateTime date;
  String deviceId;
  String deviceName;

  _TempPressureModel({
    this.sys,
    this.dia,
    this.pulse,
    required this.date,
    required this.deviceId,
    required this.deviceName,
  });
}

class MeasurementTrackingVm with ChangeNotifier {
  List<HomePageModel> items = [];
  late HealthFactory health;
  late List<HealthDataType> _healthDataTypes;
  bool? healthDataRequested;

  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;

  HomePageModel? _selectedPage;
  HomePageModel? activeItem;

  HomePageModel get selectedPage => _selectedPage == null
      ? HomePageModel(title: LocaleProvider.current.chronic_track)
      : items[0];

  MeasurementTrackingVm() {
    health = HealthFactory();

    _healthDataTypes = [
      // Glucose Data
      HealthDataType.BLOOD_GLUCOSE,

      // Scale Data
      HealthDataType.BODY_MASS_INDEX,
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,

      // Pressure Data
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.HEART_RATE,
    ];

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      getHealthDataFromDevice();
      getValues();
    });
  }

  Future<void> getHealthDataFromDevice() async {
    await Permission.activityRecognition.request();

    bool succes = await health.requestAuthorization(
      _healthDataTypes,
    );

    if (succes) {
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime(1997, 11, 9), DateTime.now(), _healthDataTypes);

      List<HealthDataPoint> glucoseData = healthData
          .where((e) => e.type == HealthDataType.BLOOD_GLUCOSE)
          .toList();

      List<HealthDataPoint> scaleData = healthData
          .where((e) =>
              e.type == HealthDataType.BODY_MASS_INDEX ||
              e.type == HealthDataType.BODY_FAT_PERCENTAGE ||
              e.type == HealthDataType.WEIGHT)
          .toList();

      List<HealthDataPoint> pressureData = healthData
          .where(
            (e) =>
                e.type == HealthDataType.BLOOD_PRESSURE_DIASTOLIC ||
                e.type == HealthDataType.BLOOD_PRESSURE_SYSTOLIC ||
                e.type == HealthDataType.HEART_RATE,
          )
          .toList();

      saveGlucoseData(glucoseData);
      // saveScaleData(scaleData);
      savePressureData(pressureData);
    }
  }

  saveGlucoseData(List<HealthDataPoint> data) {
    List<GlucoseData> glucoseData = data
        .map((e) => GlucoseData(
            level: e.value.toString(),
            tag: 3,
            time: e.dateTo.millisecondsSinceEpoch,
            note: "",
            deviceName: e.sourceName,
            deviceUUID: e.deviceId,
            manual: false,
            isFromHealth: true,
            device: 4))
        .toList();

    getIt<GlucoseStorageImpl>().writeAll(glucoseData, isFromHealth: false);
  }

  savePressureData(List<HealthDataPoint> data) {
    List<_TempPressureModel> _tempPressureModel = <_TempPressureModel>[];

    for (var item in data) {
      if (item.type == HealthDataType.BLOOD_PRESSURE_DIASTOLIC) {
        _tempPressureModel.add(_TempPressureModel(
            dia: item.value.toInt(),
            date: item.dateFrom,
            deviceId: item.deviceId,
            deviceName: item.sourceName));
      }
    }
    for (var item in data) {
      if (item.type == HealthDataType.BLOOD_PRESSURE_SYSTOLIC) {
        if (_tempPressureModel
            .any((element) => element.date == item.dateFrom)) {
          _tempPressureModel
              .firstWhere((element) => element.date == item.dateFrom)
              .sys = item.value.toInt();
        } else {
          _tempPressureModel.add(_TempPressureModel(
              sys: item.value.toInt(),
              date: item.dateFrom,
              deviceId: item.deviceId,
              deviceName: item.sourceName));
        }
      }
    }
    for (var item in data) {
      if (item.type == HealthDataType.HEART_RATE) {
        if (_tempPressureModel
            .any((element) => element.date == item.dateFrom)) {
          _tempPressureModel
              .firstWhere((element) => element.date == item.dateFrom)
              .pulse = item.value.toInt();
        } else {
          _tempPressureModel.add(_TempPressureModel(
              pulse: item.value.toInt(),
              date: item.dateFrom,
              deviceId: item.deviceId,
              deviceName: item.sourceName));
        }
      }
    }

    LoggerUtils.instance.e(data.length);
    LoggerUtils.instance.e(_tempPressureModel.length);
    List<BloodPressureModel> pressureData = _tempPressureModel
        .map((e) => BloodPressureModel(
              sys: e.sys,
              dia: e.dia,
              pulse: e.pulse,
              dateTime: e.date,
              deviceUUID: e.deviceId,
              isManual: e.deviceId == 'manuel',
              note: '',
              isFromHealth: true,
            ))
        .toList();

    getIt<BloodPressureStorageImpl>()
        .writeAll(pressureData, isFromHealth: false);
  }

  Future<void> getValues() async {
    try {
      _state = LoadingProgress.loading;
      notifyListeners();

      if (!(state == LoadingProgress.done)) {
        await getIt<GlucoseStorageImpl>().checkLastGlucoseData();
        await getIt<BloodPressureStorageImpl>().checkLastBp();

        items = [
          HomePageModel<BgProgressVm>(
            title: LocaleProvider.current.blood_glucose_progress,
            key: const Key('Glucose'),
            activateCallBack: (key) => setActiveItem(key),
          ),
          HomePageModel<ScaleProgressVm>(
            title: LocaleProvider.current.scale_progress,
            key: const Key('Scale'),
            activateCallBack: (key) => setActiveItem(key),
          ),
          HomePageModel<BpProgressVm>(
            title: LocaleProvider.current.scale_progress,
            key: const Key('Pressure'),
            activateCallBack: (key) => setActiveItem(key),
          ),
        ];

        _state = LoadingProgress.done;
        notifyListeners();
      }
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      _state = LoadingProgress.error;
      notifyListeners();
    }
  }

  void setActiveItem(Key key) {
    Utils.instance.releaseOrientation();

    if (key == const Key('Glucose')) {
      FirebaseAnalytics.instance.logEvent(
        name: "SaglikTakibi_Butonlar",
        parameters: {
          'element': 'Kan_Şekeri',
        },
      );
      Atom.to(PagePaths.bloodGlucoseProgress);
    } else if (key == const Key('Scale')) {
      FirebaseAnalytics.instance.logEvent(
        name: "SaglikTakibi_Butonlar",
        parameters: {
          'element': 'Tartı',
        },
      );
      Atom.to(PagePaths.scaleDetail);
    } else if (key == const Key('Pressure')) {
      FirebaseAnalytics.instance.logEvent(
        name: "SaglikTakibi_Butonlar",
        parameters: {
          'element': 'Tansiyon',
        },
      );
      Atom.to(PagePaths.bpProgress);
    }

    notifyListeners();
  }
}
