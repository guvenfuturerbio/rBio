import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/data/service/chronic_service/chronic_storage_service.dart';

import 'package:onedosehealth/generated/l10n.dart';

import '../../core/utils/pop_up/scale_tagger/scale_tagger_pop_up.dart';
import '../../database/repository/glucose_repository.dart';
import '../../locator.dart';
import '../../models/ble_models/paired_device.dart';
import '../../models/device_model/mi_scale_device.dart';
import '../../models/device_model/scale_device_model.dart';
import '../../../progress_sections/scale_progress/utils/mi_scale_popup.dart';
import '../shared_pref_notifiers.dart';
import '../user_profiles_notifier.dart';

enum BleReactorState { LOADING, DONE, ERROR }

class BleReactorOps extends ChangeNotifier {
  BleReactorOps({FlutterReactiveBle ble}) {
    this._ble = ble;
  }
  FlutterReactiveBle _ble;

  bool isFirstConnect = true;

  List<List<int>> _measurements = <List<int>>[];

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
    // IEE 754, IEE 11073: 16 bit floating point. TODO: mg/dL olmayan cihazda test

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
  saveGlucoseDataToDatabase(data, DiscoveredDevice device) async {
    try {
      GlucoseData gData = parseGlucoseDataFromReadingInstance(data, device);
      bool doesExist = getIt<GlucoseStorageImpl>().doesExist(gData);
      if (doesExist) {
        print("$gData exists in DB! " + DateTime.now().toString());
      } else {
        gData.userId = UserProfilesNotifier().selection?.id ?? 0;
        await getIt<GlucoseStorageImpl>().write(
          gData,
          shouldSendToServer: true,
        );
      }
    } catch (_) {
      //showNotification(message: "error");
    }
  }

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  showNotification({String message}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('11', 'New Message',
            channelDescription: 'New message recieved',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        LocaleProvider.current.blood_glucose_measurement,
        message == null
            ? LocaleProvider.current.blood_glucose_imported
            : LocaleProvider.current.we_have_an_error,
        platformChannelSpecifics);
  }

  /// MG2
  Future<void> write(DiscoveredDevice device) async {
    _measurements?.clear();
    _controlPointResponse = <int>[];
    this._bleReactorState = BleReactorState.LOADING;
    notifyListeners();
    PairedDevice pairedDevice = PairedDevice();
    pairedDevice.deviceId = device.id;

    pairedDevice.deviceType = getDeviceType(device);
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

      // TODO: This section will be editing
      saveGlucoseDataToDatabase(measurementData, device);
      notifyListeners();
    }, onError: (dynamic error) {
      print("subs characteristic error " + error.toString());
      print(error.toString());
    }, onDone: () {
      print("done");
    });

    _ble.subscribeToCharacteristic(writeCharacteristic).listen(
        (recordAccessData) {
      print("record access data " + recordAccessData.toString());
      _controlPointResponse = recordAccessData;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        locator<SharedPrefNotifiers>().savePairedDevices(pairedDevice);
      });
      this._bleReactorState = BleReactorState.DONE;
      showNotification();
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
          locator<SharedPrefNotifiers>().savePairedDevices(pairedDevice);
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
    pairedDevice.deviceType = getDeviceType(device);
    pairedDevice.modelName = device.name;
    pairedDevice.manufacturerName = device.name;
    _ble.discoverServices(device.id).then((value) => print(value.toString()));

    if (Platform.isAndroid) {
      await _ble.requestConnectionPriority(
          deviceId: device.id, priority: ConnectionPriority.highPerformance);
    }
    /*  _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a24"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id))
        .then((value) {
      List<int> charCodes = value;
      print("2a24 model name " + String.fromCharCodes(charCodes));
      print("2a24" + value.toString());
      pairedDevice.modelName = String.fromCharCodes(charCodes);
    }); */

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

    /* _ble
        .readCharacteristic(QualifiedCharacteristic(
            characteristicId: Uuid.parse("2a29"),
            serviceId: Uuid.parse("180a"),
            deviceId: device.id))
        .then((value) {
      List<int> charCodes = value;
      print("2a29 manufacturer namr " + String.fromCharCodes(charCodes));
      print("2a29" + value.toString());
      pairedDevice.manufacturerName = String.fromCharCodes(charCodes);
    }); */

    subscribeScaleCharacteristic(device, pairedDevice);
  }

  subscribeScaleCharacteristic(
      DiscoveredDevice device, PairedDevice pairedDevice) async {
    _controlPointResponse = <int>[];
    var deviceAlreadyPaired =
        await SharedPrefNotifiers().hasDeviceAlreadyPaired(pairedDevice);
    var _characteristic = QualifiedCharacteristic(
        characteristicId: Uuid([42, 156]),
        serviceId: Uuid([24, 27]),
        deviceId: device.id);
    try {
      _ble.subscribeToCharacteristic(_characteristic).listen((event) {
        if (!Get.isDialogOpen) {
          Get.dialog(
              MiScalePopUp(
                hasAlreadyPair: deviceAlreadyPaired,
              ),
              barrierDismissible: false,
              useSafeArea: false,
              barrierColor: Colors.transparent);
        }
        if (scaleDevice.scaleData == null ||
            !scaleDevice.scaleData.measurementComplete) {
          Uint8List data = Uint8List.fromList(event);

          scaleDevice.parseScaleData(pairedDevice, data);
          if (scaleDevice.scaleData.measurementComplete &&
              deviceAlreadyPaired) {
            scaleDevice.scaleData.calculateVariables();

            if (Get.isDialogOpen) {
              Get.back();
            }
            Get.dialog(
                ScaleTagger(
                  scaleModel: scaleDevice.scaleData,
                ),
                barrierDismissible: false);
            scaleDevice.scaleData = null;
          }
          var popUpCanClose = Get.isDialogOpen &&
              scaleDevice.scaleData.weightRemoved &&
              !scaleDevice.scaleData.measurementComplete;

          if (popUpCanClose) {
            Get.back();
          }

          if (scaleDevice.scaleData.measurementComplete &&
              !deviceAlreadyPaired) {
            // Saving paired device Section
            controlPointResponse.add(1);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              locator<SharedPrefNotifiers>().savePairedDevices(pairedDevice);
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
    _controlPointResponse.clear();
  }
}
