part of 'ble_operators.dart';

enum BleReactorState { LOADING, DONE, ERROR }

class BleReactorOps extends ChangeNotifier {
  BleReactorOps(this._ble);
  final FlutterReactiveBle _ble;

  bool isFirstConnect = true;

  final List<List<int>> _measurements = <List<int>>[];
  final List<GlucoseData> _gData = <GlucoseData>[];

  List<int> _controlPointResponse = [];

  late BleReactorState _bleReactorState;

  late ScaleDevice scaleDevice;

  BleReactorState get bleReactorState => _bleReactorState;

  List get controlPointResponse => _controlPointResponse;

  List<List<int>> get measurements => _measurements;

  GlucoseData parseGlucoseDataFromReadingInstance(
      data, DiscoveredDevice device) {
    final int yearL = data[3] as int;
    final int yearM = data[4]as int;
    final int month = data[5]as int;
    final int day = data[6]as int;
    final int hr = data[7]as int;
    final int mn = data[8]as int;
    final int sc = data[9]as int;
    final int timeOffsetLSB = data[10]as int; // Least Significant Bit
    final int timeOffsetMSB = data[11]as int; // Most Significant Bit
    final int measurementLevelLSB = data[12]as int; // val
    final int measurementLevelMSB = data[13]as int; // 176 - 177

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

    print("Time OFFSET = $timeOff");
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
          device: 1,);
    } else if ((device.manufacturerData[0]).toString() == "112") {
      // Accu Chek
      return GlucoseData(
          level: measurementLevel.toString(),
          tag: 3,
          time: measureDT.millisecondsSinceEpoch,
          deviceName: device.name,
          deviceUUID: device.id,
          note: "",
          device: 0,);
    } else {
      throw Exception('dataCantParse');
    }
  }

  /// MG2
  saveGlucoseDatas() async {
    var newData = 0;
    late GlucoseData tempData;
    for (var item in _gData) {
      final bool doesExist = await getIt<GlucoseStorageImpl>().doesExist(item);
      if (!doesExist) {
        newData++;
        tempData = item;
      }
    }
    if (newData > 1) {
      for (var item in _gData) {
        final bool doesExist = await getIt<GlucoseStorageImpl>().doesExist(item);
        if (!doesExist) {
          getIt<GlucoseStorageImpl>().write(item, shouldSendToServer: true);
        } else {
          print("$item exists in DB! ${DateTime.now()}");
        }
      }
    } else if (newData == 1) {
      tempData.userId = getIt<ProfileStorageImpl>().getFirst().id ;
      Atom.show(
          BgTaggerPopUp(
            data: tempData,
          ),
          barrierColor: Colors.transparent,
          barrierDismissible: false,);
    }
    getIt<LocalNotificationsManager>().showNotification(
        LocaleProvider.current.blood_glucose_measurement,
        LocaleProvider.current.blood_glucose_imported,);
  }

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// MG2
  Future<void> write(DiscoveredDevice device) async {
    _measurements.clear();
    _gData.clear();
    _controlPointResponse = <int>[];
    this._bleReactorState = BleReactorState.LOADING;
    notifyListeners();
    final PairedDevice pairedDevice = PairedDevice();
    pairedDevice.deviceId = device.id;

    pairedDevice.deviceType = Utils.instance.getDeviceType(device);
    final writeCharacteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse("1808"),
        characteristicId: Uuid.parse("2a52"),
        deviceId: device.id,);

    final subsCharacteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse("1808"),
        characteristicId: Uuid.parse("2a18"),
        deviceId: device.id,);

    _ble.discoverServices(device.id).then((value) => print(value.toString()));

    if (Platform.isAndroid) {
      await _ble.requestConnectionPriority(
          deviceId: device.id, priority: ConnectionPriority.highPerformance,);
    }
    _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a24"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id,),)
        .then((value) {
      final List<int> charCodes = value;
      print("2a24 model name ${String.fromCharCodes(charCodes)}");
      print("2a24$value");
      pairedDevice.modelName = String.fromCharCodes(charCodes);
    });

    _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a25"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id,),)
        .then((value) {
      final List<int> charCodes = value;
      print("2a25 serial number ${String.fromCharCodes(charCodes)}");
      print("2a25$value");
      pairedDevice.serialNumber = String.fromCharCodes(charCodes);
    });

    _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a29"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id,),)
        .then((value) {
      final List<int> charCodes = value;
      print("2a29 manufacturer namr ${String.fromCharCodes(charCodes)}");
      print("2a29$value");
      pairedDevice.manufacturerName = String.fromCharCodes(charCodes);
    });

    _ble.subscribeToCharacteristic(subsCharacteristic).listen(
        (measurementData) {
      _measurements.add(measurementData);

      _gData.add(parseGlucoseDataFromReadingInstance(measurementData, device));

      notifyListeners();
    }, onError: (dynamic error) {
      print("subs characteristic error $error");
      print(error.toString());
    }, onDone: () {
      print("done");
    },);

    _ble.subscribeToCharacteristic(writeCharacteristic).listen(
        (recordAccessData) async {
      print("record access data $recordAccessData");

      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        getIt<BleDeviceManager>().savePairedDevices(pairedDevice).then((value) {
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
      print("write characteristic error $error");
      //user need to press device button for 3 seconds to pairing operation.
    }, onDone: () {
      print("done");
    },);
    try {
      _ble.writeCharacteristicWithResponse(writeCharacteristic,
          value: [0x01, 0x01],).then((value) {
        print("deneme");
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
          getIt<BleDeviceManager>().savePairedDevices(pairedDevice);
        });
      }, onError: (e) {
        this._bleReactorState = BleReactorState.ERROR;
        notifyListeners();
        print("write errorrrrrrrr$e");
      },);
    } catch (e) {
      this._bleReactorState = BleReactorState.ERROR;
      notifyListeners();
      print("write characterisctic error $e");
    }
  }

  Future<void> subscribeScaleDevice(DiscoveredDevice device) async {
    scaleDevice = MiScaleDevice().from(device);
    final PairedDevice pairedDevice = PairedDevice();
    pairedDevice.deviceId = device.id;
    pairedDevice.deviceType = Utils.instance.getDeviceType(device);
    pairedDevice.modelName = device.name;
    pairedDevice.manufacturerName = device.name;
    _ble.discoverServices(device.id).then((value) => print(value.toString()));

    if (Platform.isAndroid) {
      await _ble.requestConnectionPriority(
          deviceId: device.id, priority: ConnectionPriority.highPerformance,);
    }

    _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a25"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id,),)
        .then((value) {
      final List<int> charCodes = value;
      print("2a25 serial number ${String.fromCharCodes(charCodes)}");
      print("2a25$value");
      pairedDevice.serialNumber = String.fromCharCodes(charCodes);
    });

    subscribeScaleCharacteristic(device, pairedDevice);
  }

  subscribeScaleCharacteristic(
      DiscoveredDevice device, PairedDevice pairedDevice) async {
    _controlPointResponse = <int>[];
    final deviceAlreadyPaired =
        await getIt<BleDeviceManager>().hasDeviceAlreadyPaired(pairedDevice);
    final _characteristic = QualifiedCharacteristic(
        characteristicId: Uuid([42, 156]),
        serviceId: Uuid([24, 27]),
        deviceId: device.id,);
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
          final Uint8List data = Uint8List.fromList(event);

          scaleDevice.parseScaleData(pairedDevice, data);
          if (scaleDevice.scaleData.scaleModel.measurementComplete &&
              deviceAlreadyPaired) {
            scaleDevice.scaleData.calculateVariables();
            if (Atom.isDialogShow) {
              Atom.dismiss();
            }
            await Future.delayed(const Duration(milliseconds: 350));
            await Atom.show(
                ScaleTagger(
                  scaleModel: scaleDevice.scaleData.scaleModel,
                ),
                barrierDismissible: false,);
            scaleDevice.scaleData = null;
          }
          final popUpCanClose = (Atom.isDialogShow ?? false) &&
              (scaleDevice.scaleData.scaleModel.weightRemoved ) &&
              !scaleDevice.scaleData.scaleModel.measurementComplete ;

          if (popUpCanClose) {
            Atom.dismiss();
          }

          if ((scaleDevice.scaleData.scaleModel.measurementComplete) &&
              !deviceAlreadyPaired) {
            // Saving paired device Section
            controlPointResponse.add(1);
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              getIt<BleDeviceManager>().savePairedDevices(pairedDevice);
            });
          }
        }

        notifyListeners();
      }, onError: (e, stk) {
        LoggerUtils.instance.e(e);
      },);
    } catch (e, stk) {
        LoggerUtils.instance.e(e);
      debugPrintStack(stackTrace: stk);
    }
  }

  clearControlPointResponse() {
    _controlPointResponse = <int>[];
  }
}
