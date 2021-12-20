part of 'ble_operators.dart';

enum BleReactorState { LOADING, DONE, ERROR }

class BleReactorOps extends ChangeNotifier {
  BleReactorOps({FlutterReactiveBle ble}) {
    this._ble = ble;
  }
  FlutterReactiveBle _ble;

  bool isFirstConnect = true;

  List<List<int>> _measurements = <List<int>>[];
  List<GlucoseData> _gData = <GlucoseData>[];

  List<int> _controlPointResponse = [];

  BleReactorState _bleReactorState;

  ScaleDevice scaleDevice;

  BleReactorState get bleReactorState => this._bleReactorState;

  List get controlPointResponse => this._controlPointResponse;

  List<List<int>> get measurements => this._measurements;

  GlucoseData parseGlucoseDataFromReadingInstance(
      data, DiscoveredDevice device) {
    int yearL = data[3];
    int yearM = (data[4]);
    int month = (data[5]);
    int day = (data[6]);
    int hr = (data[7]);
    int mn = (data[8]);
    int sc = data[9];
    int timeOffsetLSB = data[10]; // Least Significant Bit
    int timeOffsetMSB = data[11]; // Most Significant Bit
    int measurementLevelLSB = data[12]; // val
    int measurementLevelMSB = data[13]; // 176 - 177

    String measurementLSB = measurementLevelLSB.toRadixString(2);
    String measurementMSB = measurementLevelMSB.toRadixString(2);

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
      int leadingZeroz = 8 - measurementLSB.length;
      for (int i = 0; i < leadingZeroz; i++) {
        kekLSB = "0" + kekLSB;
      }
    }

    measurementLSB = "$kekLSB$measurementLSB";

    int measurementLevel = int.parse("$kekMSB$measurementLSB", radix: 2);

    var yearMSB = yearM.toRadixString(2);
    var yearLSB = yearL.toRadixString(2);
    int year = int.parse('$yearMSB$yearLSB', radix: 2);

    var timeOffMSB = timeOffsetMSB.toRadixString(2);
    var timeOffLSB = timeOffsetLSB.toRadixString(2);
    int timeOff = int.parse('$timeOffMSB$timeOffLSB', radix: 2);

    print("Time OFFSET = $timeOff");
    Duration offset = new Duration(minutes: timeOff, hours: 0);
    DateTime measureDT = new DateTime(year, month, day, hr, mn, sc);
    measureDT = measureDT.add(offset);
    if ((device.manufacturerData[0]).toString() == "103") {
      // Contour Plus
      return new GlucoseData(
          level: measurementLevel.toString(),
          tag: 3,
          time: measureDT.millisecondsSinceEpoch,
          note: "",
          deviceName: device.name,
          deviceUUID: device.id,
          manual: false,
          device: 1);
    } else if ((device.manufacturerData[0]).toString() == "112") {
      // Accu Chek
      return new GlucoseData(
          level: measurementLevel.toString(),
          tag: 3,
          time: measureDT.millisecondsSinceEpoch,
          deviceName: device.name,
          deviceUUID: device.id,
          manual: false,
          note: "",
          device: 0);
    } else {
      throw Exception('dataCantParse');
    }
  }

  /// MG2
  saveGlucoseDatas() async {
    var newData = 0;
    GlucoseData tempData;
    for (var item in _gData) {
      bool doesExist = await getIt<GlucoseStorageImpl>().doesExist(item);
      if (!doesExist) {
        newData++;
        tempData = item;
      }
    }
    if (newData > 1) {
      for (var item in _gData) {
        bool doesExist = await getIt<GlucoseStorageImpl>().doesExist(item);
        if (!doesExist) {
          getIt<GlucoseStorageImpl>().write(item, shouldSendToServer: true);
        } else {
          print("$item exists in DB! " + DateTime.now().toString());
        }
      }
    } else if (newData == 1) {
      tempData.userId = getIt<ProfileStorageImpl>().getFirst()?.id ?? 0;
      Atom.show(
          BgTaggerPopUp(
            data: tempData,
          ),
          barrierColor: Colors.transparent,
          barrierDismissible: false);
    }
    getIt<LocalNotificationsManager>().showNotification(
        LocaleProvider.current.blood_glucose_measurement,
        LocaleProvider.current.blood_glucose_imported);
  }

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// MG2
  Future<void> write(DiscoveredDevice device) async {
    _measurements?.clear();
    _gData?.clear();
    _controlPointResponse = <int>[];
    this._bleReactorState = BleReactorState.LOADING;
    notifyListeners();
    PairedDevice pairedDevice = PairedDevice();
    pairedDevice.deviceId = device.id;

    pairedDevice.deviceType = Utils.instance.getDeviceType(device);
    final writeCharacteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse("1808"),
        characteristicId: Uuid.parse("2a52"),
        deviceId: device.id);

    final subsCharacteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse("1808"),
        characteristicId: Uuid.parse("2a18"),
        deviceId: device.id);

    _ble.discoverServices(device.id).then((value) => print(value.toString()));

    if (Platform.isAndroid) {
      await _ble.requestConnectionPriority(
          deviceId: device.id, priority: ConnectionPriority.highPerformance);
    }
    _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a24"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id))
        .then((value) {
      List<int> charCodes = value;
      print("2a24 model name " + String.fromCharCodes(charCodes));
      print("2a24" + value.toString());
      pairedDevice.modelName = String.fromCharCodes(charCodes);
    });

    _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a25"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id))
        .then((value) {
      List<int> charCodes = value;
      print("2a25 serial number " + String.fromCharCodes(charCodes));
      print("2a25" + value.toString());
      pairedDevice.serialNumber = String.fromCharCodes(charCodes);
    });

    _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a29"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id))
        .then((value) {
      List<int> charCodes = value;
      print("2a29 manufacturer namr " + String.fromCharCodes(charCodes));
      print("2a29" + value.toString());
      pairedDevice.manufacturerName = String.fromCharCodes(charCodes);
    });

    _ble.subscribeToCharacteristic(subsCharacteristic).listen(
        (measurementData) {
      _measurements.add(measurementData);

      _gData.add(parseGlucoseDataFromReadingInstance(measurementData, device));

      notifyListeners();
    }, onError: (dynamic error) {
      print("subs characteristic error " + error.toString());
      print(error.toString());
    }, onDone: () {
      print("done");
    });

    _ble.subscribeToCharacteristic(writeCharacteristic).listen(
        (recordAccessData) async {
      print("record access data " + recordAccessData.toString());

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        getIt<BleDeviceManager>().savePairedDevices(pairedDevice).then((value) {
          log("$value");
          value
              ? _controlPointResponse = recordAccessData
              : _controlPointResponse.clear();
        });
      });
      this._bleReactorState = BleReactorState.DONE;
      await saveGlucoseDatas();

      notifyListeners();
    }, onError: (dynamic error) {
      this._bleReactorState = BleReactorState.ERROR;
      notifyListeners();
      print("write characteristic error " + error.toString());
      //user need to press device button for 3 seconds to pairing operation.
    }, onDone: () {
      print("done");
    });
    try {
      _ble.writeCharacteristicWithResponse(writeCharacteristic,
          value: [0x01, 0x01]).then((value) {
        print("deneme");
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          getIt<BleDeviceManager>().savePairedDevices(pairedDevice);
        });
      }, onError: (e) {
        this._bleReactorState = BleReactorState.ERROR;
        notifyListeners();
        print("write errorrrrrrrr" + e.toString());
      });
    } catch (e) {
      this._bleReactorState = BleReactorState.ERROR;
      notifyListeners();
      print("write characterisctic error " + e.toString());
    }
  }

  Future<void> subscribeScaleDevice(DiscoveredDevice device) async {
    scaleDevice = MiScaleDevice().from(device);
    PairedDevice pairedDevice = PairedDevice();
    pairedDevice.deviceId = device.id;
    pairedDevice.deviceType = Utils.instance.getDeviceType(device);
    pairedDevice.modelName = device.name;
    pairedDevice.manufacturerName = device.name;
    _ble.discoverServices(device.id).then((value) => print(value.toString()));

    if (Platform.isAndroid) {
      await _ble.requestConnectionPriority(
          deviceId: device.id, priority: ConnectionPriority.highPerformance);
    }

    _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a25"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id))
        .then((value) {
      List<int> charCodes = value;
      print("2a25 serial number " + String.fromCharCodes(charCodes));
      print("2a25" + value.toString());
      pairedDevice.serialNumber = String.fromCharCodes(charCodes);
    });

    subscribeScaleCharacteristic(device, pairedDevice);
  }

  subscribeScaleCharacteristic(
      DiscoveredDevice device, PairedDevice pairedDevice) async {
    _controlPointResponse = <int>[];
    var deviceAlreadyPaired =
        await getIt<BleDeviceManager>().hasDeviceAlreadyPaired(pairedDevice);
    var _characteristic = QualifiedCharacteristic(
        characteristicId: Uuid([42, 156]),
        serviceId: Uuid([24, 27]),
        deviceId: device.id);
    try {
      _ble.subscribeToCharacteristic(_characteristic).listen((event) async {
        if (!(Atom.isDialogShow ?? false)) {
          Atom.show(
            MiScalePopUp(
              hasAlreadyPair: deviceAlreadyPaired,
            ),
          );
        }
        if (scaleDevice.scaleData == null ||
            !scaleDevice.scaleData.scaleModel.measurementComplete) {
          Uint8List data = Uint8List.fromList(event);

          scaleDevice.parseScaleData(pairedDevice, data);
          if (scaleDevice.scaleData.scaleModel.measurementComplete &&
              deviceAlreadyPaired) {
            scaleDevice.scaleData.calculateVariables();
            if (Atom.isDialogShow) {
              Atom.dismiss();
            }
            await Future.delayed(Duration(milliseconds: 350));
            await Atom.show(
                ScaleTagger(
                  scaleModel: scaleDevice.scaleData.scaleModel,
                ),
                barrierDismissible: false);
            scaleDevice.scaleData = null;
          }
          var popUpCanClose = (Atom.isDialogShow ?? false) &&
              (scaleDevice.scaleData?.scaleModel?.weightRemoved ?? false) &&
              !(scaleDevice.scaleData?.scaleModel?.measurementComplete ??
                  false);

          if (popUpCanClose) {
            Atom.dismiss();
          }

          if ((scaleDevice.scaleData?.scaleModel?.measurementComplete ??
                  false) &&
              !deviceAlreadyPaired) {
            // Saving paired device Section
            controlPointResponse.add(1);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              getIt<BleDeviceManager>().savePairedDevices(pairedDevice);
            });
          }
        }

        notifyListeners();
      }, onError: (e, stk) {
        print(e);
        debugPrintStack(stackTrace: stk);
      });
    } catch (e, stk) {
      print(e);
      debugPrintStack(stackTrace: stk);
    }
  }

  clearControlPointResponse() {
    _controlPointResponse = <int>[];
  }
}
