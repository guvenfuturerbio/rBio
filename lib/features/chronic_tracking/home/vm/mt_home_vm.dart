part of '../view/mt_home_screen.dart';

class _TempScaleModel {
  double? weight;
  double? bmi;
  double? bodyFat;

  DateTime date;

  String deviceId;
  String deviceName;

  _TempScaleModel(
      {this.bmi,
      this.bodyFat,
      this.weight,
      required this.date,
      required this.deviceId,
      required this.deviceName});
}

class _TempPressureModel {
  int? sys;
  int? dia;
  int? pulse;

  DateTime date;

  String deviceId;
  String deviceName;

  _TempPressureModel(
      {this.sys,
      this.dia,
      this.pulse,
      required this.date,
      required this.deviceId,
      required this.deviceName});
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

  getHealthDataFromDevice() async {
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
      saveScaleData(scaleData);
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

    getIt<GlucoseStorageImpl>().writeAll(glucoseData, isFromHealth: true);
  }

  saveScaleData(List<HealthDataPoint> data) {
    List<_TempScaleModel> _tempScaleModel = <_TempScaleModel>[];

    for (var item in data) {
      if (item.type == HealthDataType.WEIGHT) {
        _tempScaleModel.add(_TempScaleModel(
            weight: item.value.toDouble(),
            date: item.dateFrom,
            deviceId: item.deviceId,
            deviceName: item.sourceName));
      }
    }
    for (var item in data) {
      if (item.type == HealthDataType.BODY_MASS_INDEX) {
        if (_tempScaleModel.any((element) => element.date == item.dateFrom)) {
          _tempScaleModel
              .firstWhere((element) => element.date == item.dateFrom)
              .bmi = item.value.toDouble();
        } else {
          _tempScaleModel.add(_TempScaleModel(
              bmi: item.value.toDouble(),
              date: item.dateFrom,
              deviceId: item.deviceId,
              deviceName: item.sourceName));
        }
      }
    }
    for (var item in data) {
      if (item.type == HealthDataType.BODY_FAT_PERCENTAGE) {
        if (_tempScaleModel.any((element) => element.date == item.dateFrom)) {
          _tempScaleModel
              .firstWhere((element) => element.date == item.dateFrom)
              .bodyFat = item.value.toDouble();
        } else {
          _tempScaleModel.add(_TempScaleModel(
              bodyFat: item.value.toDouble(),
              date: item.dateFrom,
              deviceId: item.deviceId,
              deviceName: item.sourceName));
        }
      }
    }
    List<ScaleMeasurementViewModel> scaleData = _tempScaleModel
        .map((e) => ScaleMeasurementViewModel(
            scaleModel: ScaleModel(
                isManuel: e.deviceId != 'manuel',
                device:
                    PairedDevice(deviceId: e.deviceId, modelName: e.deviceName)
                        .toJson(),
                unit: ScaleUnit.kg,
                bmi: e.bmi,
                weight: e.weight,
                bodyFat: e.bodyFat,
                note: '',
                dateTime: e.date,
                isFromHealth: true,
                images: [])))
        .toList();

    for (var item in scaleData) {
      LoggerUtils.instance.e(item);
    }
    for (var item in data) {
      LoggerUtils.instance.e(item);
    }
    if (scaleData.any((element) => element.bmi == null)) {
      for (var item
          in scaleData.where((element) => element.bmi == null).toList()) {
        item.calculateVariables();
      }
    }
    getIt<ScaleStorageImpl>().writeAll(
        scaleData.map((e) => e.scaleModel).toList(),
        isFromHealth: true);
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
        .writeAll(pressureData, isFromHealth: true);
  }

  Future<void> getValues() async {
    try {
      _state = LoadingProgress.loading;
      notifyListeners();

      if (!(state == LoadingProgress.done)) {
        await getIt<GlucoseStorageImpl>().checkLastGlucoseData();
        await getIt<ScaleStorageImpl>().checkLastScale();
        await getIt<BloodPressureStorageImpl>().checkLastBp();

        items = [
          HomePageModel<BgProgressPageViewModel>(
            title: LocaleProvider.current.blood_glucose_progress,
            key: const Key('Glucose'),
            activateCallBack: (key) => setActiveItem(key),
          ),
          HomePageModel<ScaleProgressPageViewModel>(
            title: LocaleProvider.current.scale_progress,
            key: const Key('Scale'),
            activateCallBack: (key) => setActiveItem(key),
          ),
          HomePageModel<BpProgressPageVm>(
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
      Atom.to(PagePaths.bloodGlucoseProgress);
    } else if (key == const Key('Scale')) {
      Atom.to(PagePaths.bmiProgress);
    } else if (key == const Key('Pressure')) {
      Atom.to(PagePaths.bpProgress);
    }
    notifyListeners();
  }
}
