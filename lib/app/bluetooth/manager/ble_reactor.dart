part of 'ble_operators.dart';

class BleReactorOps extends ChangeNotifier {
  BleReactorOps(this._ble);
  final FlutterReactiveBle _ble;

  List<List<int>> get measurements => _measurements;
  final List<List<int>> _measurements = <List<int>>[];

  final List<GlucoseData> _gData = <GlucoseData>[];

  List get controlPointResponse => _controlPointResponse;
  List<int> _controlPointResponse = [];

  // late MiScaleDevice scaleDevice;
  ScaleEntity? scaleEntity;
  StreamSubscription<List<int>>? scaleSubs;

  final flutterLocalNotificationsPlugin = ln.FlutterLocalNotificationsPlugin();

  StreamSubscription<List<int>>? dataStreamSubscription;
  StreamSubscription<List<int>>? recordStreamSubscription;

  /// MG2
  Future<void> write(DiscoveredDevice device) async {
    _measurements.clear();
    _gData.clear();
    _controlPointResponse = <int>[];
    notifyListeners();

    final writeCharacteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse("1808"),
      characteristicId: Uuid.parse("2a52"),
      deviceId: device.id,
    );

    final subsCharacteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse("1808"),
      characteristicId: Uuid.parse("2a18"),
      deviceId: device.id,
    );

    if (Platform.isAndroid) {
      await _ble.requestConnectionPriority(
        deviceId: device.id,
        priority: ConnectionPriority.highPerformance,
      );
    }

    final PairedDevice pairedDevice = PairedDevice();

    // DeviceId
    pairedDevice.deviceId = device.id;

    // DeviceType
    pairedDevice.deviceType = Utils.instance.getDeviceType(device);

    // Model Name
    final modelName = await _ble.readCharacteristic(
      QualifiedCharacteristic(
        characteristicId: Uuid.parse("2a24"),
        serviceId: Uuid.parse("180a"),
        deviceId: device.id,
      ),
    );
    pairedDevice.modelName = String.fromCharCodes(modelName);

    // Serial Number
    final serialNumber = await _ble.readCharacteristic(
      QualifiedCharacteristic(
        characteristicId: Uuid.parse("2a25"),
        serviceId: Uuid.parse("180a"),
        deviceId: device.id,
      ),
    );
    pairedDevice.serialNumber = String.fromCharCodes(serialNumber);

    // Manufacturer Name
    final manufacturerName = await _ble.readCharacteristic(
      QualifiedCharacteristic(
        characteristicId: Uuid.parse("2a29"),
        serviceId: Uuid.parse("180a"),
        deviceId: device.id,
      ),
    );
    pairedDevice.manufacturerName = String.fromCharCodes(manufacturerName);

    LoggerUtils.instance.i({
      'deviceId': pairedDevice.deviceId,
      'deviceType': pairedDevice.deviceType,
      'modelName': pairedDevice.modelName,
      'serialNumber': pairedDevice.serialNumber,
      'manufacturerName': pairedDevice.manufacturerName,
    }.toString());

    // İlk önce buradan datalar geliyor daha sonra aşağıdan recordAccessData tetikleniyor.
    dataStreamSubscription =
        _ble.subscribeToCharacteristic(subsCharacteristic).listen(
      (measurementData) {
        LoggerUtils.instance.i(
          "Cihazdaki Veriler Aktarılırıyor... $measurementData",
        );
        _measurements.add(measurementData);
        _gData
            .add(parseGlucoseDataFromReadingInstance(measurementData, device));
        notifyListeners();
      },
      onError: (dynamic error) {
        LoggerUtils.instance.d(
          "Cihazdaki Veriler Aktarılırken Hata Oluştu - ${error.toString()}",
        );
      },
      onDone: () {
        LoggerUtils.instance.d("Cihazdaki Veriler Aktarıldı");
      },
    );

    bool _lock = false;
    recordStreamSubscription =
        _ble.subscribeToCharacteristic(writeCharacteristic).listen(
      (recordAccessData) async {
        LoggerUtils.instance.i(
          "Cihaz ile Bağlantı Kuruldu ${recordAccessData.toString()}",
        );

        if (!_lock) {
          _lock = true;
          bool isSucces =
              await getIt<BleDeviceManager>().savePairedDevices(pairedDevice);
          isSucces
              ? _controlPointResponse = recordAccessData
              : _controlPointResponse.clear();

          if (isSucces) {
            var localUser = getIt<ProfileStorageImpl>().getFirst();
            var newPerson = Person.fromJson(localUser.toJson());
            newPerson.deviceUUID = pairedDevice.deviceId;
            await getIt<ProfileStorageImpl>().update(
              newPerson,
              localUser.key,
            );
            LoggerUtils.instance.i("Cihaz Bilgisi Backend'e Gönderildi");
          }

          _lock = false;
        }

        await saveGlucoseDatas();
        notifyListeners();
      },
      onError: (dynamic error) {
        notifyListeners();
        LoggerUtils.instance.i(
          "Cihaz ile Bağlantı Kurulurken Hata Oluştu. ${error.toString()}",
        );
      },
      onDone: () {
        LoggerUtils.instance.i(
          "Cihaz ile Bağlantı Kurulumu İşlemi Tamamlandı.",
        );
      },
    );

    try {
      LoggerUtils.instance.i("Cihaza Eşleşme Talebi Gönderildi");
      _ble.writeCharacteristicWithResponse(
        writeCharacteristic,
        value: [0x01, 0x01],
      ).then(
        (value) {
          LoggerUtils.instance.i("Cihaz Eşleşme Talebine Cevap Gönderdi.");
        },
        onError: (e) {
          notifyListeners();
          LoggerUtils.instance.i(
            "Cihaz Eşleşme Talebi Sırasında Hata Oluştu - onError. ${e.toString()}",
          );
        },
      );
    } catch (e, stackTrace) {
      notifyListeners();
      LoggerUtils.instance.i(
        "Cihaz Eşleşme Talebi Sırasında Hata Oluştu - catch. ${e.toString()}",
      );
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
    }
  }

  /// user/user-profile-update/entegrationId isteğinden sonra bu metod çağrılıyor.
  Future<void> saveGlucoseDatas() async {
    var newDataCount = 0;
    GlucoseData? tempData;
    var newItems = <GlucoseData>[];

    LoggerUtils.instance.i("Cihazdan Gelen Veriler Kontrol Ediliyor");

    // Cihazdan gelen bütün verileri dönüyoruz.
    for (final item in _gData) {
      // Cihazın local database'inde yoksa newData counter'ı 1 artıyor ve tempData bu item oluyor.
      final doesExist = getIt<GlucoseStorageImpl>().doesExist(item);
      if (!doesExist) {
        newDataCount++;
        tempData = item;
        newItems.add(item);
      }
    }

    if (newDataCount == 1) {
      tempData?.userId = getIt<ProfileStorageImpl>().getFirst().id;
      Atom.show(
        BgTaggerPopUp(data: tempData),
        barrierColor: Colors.transparent,
        barrierDismissible: false,
      );
    } else if (newDataCount > 1) {
      // Cihazın local'inde olmayan bütün verileri hem local'e hemde db'ye yazıyorum.
      Atom.show(
        SizedBox.expand(
          child: Container(
            color: Colors.black26,
            child: const RbioLoading(),
          ),
        ),
      );
      for (final item in newItems) {
        LoggerUtils.instance.i(
          "Kayıt Edilmemiş Veriler Backend'e Gönderiliyor.",
        );
        await getIt<GlucoseStorageImpl>().write(
          item,
          shouldSendToServer: true,
        );
      }
      Atom.dismiss();
    }

    LoggerUtils.instance.i(
      "Kullanıcıya Notification ile Bilgi Verildi.",
    );
    await getIt<LocalNotificationManager>().show(
      LocaleProvider.current.blood_glucose_measurement,
      LocaleProvider.current.blood_glucose_imported,
    );
  }

  GlucoseData parseGlucoseDataFromReadingInstance(
    List<int> data,
    DiscoveredDevice device,
  ) {
    final int yearL = data[3];
    final int yearM = data[4];
    final int month = data[5];
    final int day = data[6];
    final int hr = data[7];
    final int mn = data[8];
    final int sc = data[9];
    final int timeOffsetLSB = data[10]; // Least Significant Bit
    final int timeOffsetMSB = data[11]; // Most Significant Bit
    final int measurementLevelLSB = data[12]; // val
    final int measurementLevelMSB = data[13]; // 176 - 177

    String measurementLSB = measurementLevelLSB.toRadixString(2);
    final String measurementMSB = measurementLevelMSB.toRadixString(2);

    String kekMSB = "";
    int cnt = 0;
    for (int i = measurementMSB.length - 1; i >= 0; i--) {
      kekMSB = "${measurementMSB[i]}$kekMSB";
      cnt++;
      if (cnt == 2) {
        break;
      }
    }

    String kekLSB = "";
    if (measurementLSB.length < 8) {
      final int leadingZeroz = 8 - measurementLSB.length;
      for (int i = 0; i < leadingZeroz; i++) {
        kekLSB = "0$kekLSB";
      }
    }

    measurementLSB = "$kekLSB$measurementLSB";

    final int measurementLevel = int.parse("$kekMSB$measurementLSB", radix: 2);

    final yearMSB = yearM.toRadixString(2);
    final yearLSB = yearL.toRadixString(2);
    final int year = int.parse('$yearMSB$yearLSB', radix: 2);

    final timeOffMSB = timeOffsetMSB.toRadixString(2);
    final timeOffLSB = timeOffsetLSB.toRadixString(2);
    final int timeOff = int.parse('$timeOffMSB$timeOffLSB', radix: 2);

    final Duration offset = Duration(minutes: timeOff);
    DateTime measureDT = DateTime(year, month, day, hr, mn, sc);
    measureDT = measureDT.add(offset);
    if ((device.manufacturerData[0]).toString() == "103") {
      // Contour Plus
      return GlucoseData(
        level: measurementLevel.toString(),
        tag: 3,
        time: measureDT.millisecondsSinceEpoch,
        note: "",
        deviceName: device.name,
        deviceUUID: device.id,
        device: 1,
      );
    } else if ((device.manufacturerData[0]).toString() == "112") {
      // Accu Chek
      return GlucoseData(
        level: measurementLevel.toString(),
        tag: 3,
        time: measureDT.millisecondsSinceEpoch,
        deviceName: device.name,
        deviceUUID: device.id,
        note: "",
        device: 0,
      );
    } else {
      throw Exception('dataCantParse');
    }
  }

  void parseGlucoseDataFromReadingInstanceTest() {
    final data = <int>[
      11,
      16,
      0,
      230,
      7,
      1,
      19,
      13,
      37,
      0,
      0,
      0,
      142,
      176,
      248,
      0,
      0
    ];

    final device = DiscoveredDevice(
      id: 'id',
      name: 'name',
      serviceData: {},
      manufacturerData: Uint8List.fromList([112]),
      rssi: 1,
      serviceUuids: [],
    );
    final model = parseGlucoseDataFromReadingInstance(data, device);
    LoggerUtils.instance.i(model.toMap().toString());

    final newModel = GlucoseData(
      device: 0,
      deviceName: 'name',
      deviceUUID: 'id',
      imageURL: '',
      isDeleted: false,
      isFromHealth: false,
      level: '142',
      manual: false,
      measurementId: null,
      note: '',
      tag: 3,
      time: 1642588620000,
      userId: null,
    );
  }

  void clearControlPointResponse() {
    _controlPointResponse = <int>[];
  }
}
