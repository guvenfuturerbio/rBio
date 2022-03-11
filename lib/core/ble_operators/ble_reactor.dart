import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bluetooth_connector/bluetooth_connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mi_scale/mi_scale.dart';

import '../../../../../core/core.dart';
import '../../features/chronic_tracking/progress_sections/blood_glucose/widgets/tagger/bg_tagger_pop_up.dart';
import '../../features/chronic_tracking/progress_sections/scale/widgets/mi_scale_popup.dart';
import '../../features/chronic_tracking/progress_sections/scale/widgets/tagger/scale_tagger_pop_up.dart';

class BleReactorOps {
  BleReactorOps(this._ble);
  final FlutterReactiveBle _ble;

  bool isFirstConnect = true;

  final List<List<int>> _measurements = <List<int>>[];
  final List<GlucoseData> _gData = <GlucoseData>[];

  List<int> _controlPointResponse = [];

  late MiScaleDevice scaleDevice;

  List get controlPointResponse => _controlPointResponse;

  List<List<int>> get measurements => _measurements;

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

  /// MG2
  Future<void> saveGlucoseDatas() async {
    var newData = 0;
    late GlucoseData tempData;

    for (final item in _gData) {
      final bool doesExist = getIt<GlucoseStorageImpl>().doesExist(item);
      if (!doesExist) {
        newData++;
        tempData = item;
      }
    }

    if (newData > 1) {
      for (final item in _gData) {
        final bool doesExist = getIt<GlucoseStorageImpl>().doesExist(item);
        if (!doesExist) {
          getIt<GlucoseStorageImpl>().write(item, shouldSendToServer: true);
        }
      }
    } else if (newData == 1) {
      tempData.userId = getIt<ProfileStorageImpl>().getFirst().id;
      Atom.show(
        BgTaggerPopUp(
          data: tempData,
        ),
        barrierColor: Colors.transparent,
        barrierDismissible: false,
      );
    }

    getIt<LocalNotificationManager>().show(
      LocaleProvider.current.blood_glucose_measurement,
      LocaleProvider.current.blood_glucose_imported,
    );
  }

  /// MG2
  Future<void> write(
    DiscoveredDevice device,
    void Function(List<int>) emitState,
  ) async {
    _measurements.clear();
    _gData.clear();
    _controlPointResponse = <int>[];
    emitState(_controlPointResponse);

    final PairedDevice pairedDevice = PairedDevice();
    pairedDevice.deviceId = device.id;

    pairedDevice.deviceType = Utils.instance.getDeviceType(device);
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

    //read ilgili unique id içerisindeki değeri okumamızı sağlayan parametre. byteArray - List<int> olarak döner.
    _ble
        .readCharacteristic(
      QualifiedCharacteristic(
        characteristicId: Uuid.parse("2a24"),
        serviceId: Uuid.parse("180a"),
        deviceId: device.id,
      ),
    )
        .then((value) {
      final List<int> charCodes = value;
      LoggerUtils.instance
          .d("2a24 model name ${String.fromCharCodes(charCodes)}");
      LoggerUtils.instance.d("2a24$value");
      pairedDevice.modelName = String.fromCharCodes(charCodes);
    });

    _ble
        .readCharacteristic(
      QualifiedCharacteristic(
        characteristicId: Uuid.parse("2a25"),
        serviceId: Uuid.parse("180a"),
        deviceId: device.id,
      ),
    )
        .then((value) {
      final List<int> charCodes = value;
      LoggerUtils.instance
          .d("2a25 serial number ${String.fromCharCodes(charCodes)}");
      LoggerUtils.instance.d("2a25$value");
      pairedDevice.serialNumber = String.fromCharCodes(charCodes);
    });

    _ble
        .readCharacteristic(
      QualifiedCharacteristic(
        characteristicId: Uuid.parse("2a29"),
        serviceId: Uuid.parse("180a"),
        deviceId: device.id,
      ),
    )
        .then((value) {
      final List<int> charCodes = value;
      LoggerUtils.instance
          .d("2a29 manufacturer namr ${String.fromCharCodes(charCodes)}");
      LoggerUtils.instance.d("2a29$value");
      pairedDevice.manufacturerName = String.fromCharCodes(charCodes);
    });

    _ble.subscribeToCharacteristic(subsCharacteristic).listen(
      (measurementData) {
        _measurements.add(measurementData);
        _gData
            .add(parseGlucoseDataFromReadingInstance(measurementData, device));
        emitState(_controlPointResponse);
      },
      onError: (dynamic error) {
        LoggerUtils.instance.d("subs characteristic error $error");
        LoggerUtils.instance.d(error.toString());
      },
      onDone: () {
        LoggerUtils.instance.d("done");
      },
    );

    bool _lock = false;
    _ble.subscribeToCharacteristic(writeCharacteristic).listen(
      (recordAccessData) async {
        LoggerUtils.instance
            .i("record access data " + recordAccessData.toString());
        LoggerUtils.instance.i("LOCK :$_lock");

        if (!_lock) {
          _lock = true;
          Atom.context.read<BluetoothBloc>().add(
                BluetoothEvent.savePairedDevices(
                  pairedDevice,
                  true,
                  recordAccessData,
                ),
              );

          _lock = false;
        }

        await saveGlucoseDatas();
        emitState(_controlPointResponse);
      },
      onError: (dynamic error) {
        LoggerUtils.instance
            .i("write characteristic error " + error.toString());
        //user need to press device button for 3 seconds to pairing operation.
      },
      onDone: () {
        LoggerUtils.instance.i("done");
      },
    );

    try {
      //Cihazının servis karakteristiklerinin içerisine veri yazmamızı sağlayan metod.
      _ble.writeCharacteristicWithResponse(
        writeCharacteristic,
        value: [0x01, 0x01],
      ).then((value) {
        // print("deneme");
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        //   getIt<BleDeviceManager>().savePairedDevices(pairedDevice);
        // });
      }, onError: (e) {
        LoggerUtils.instance.i("write errorrrrrrrr" + e.toString());
      });
    } catch (e) {
      LoggerUtils.instance.i("write characterisctic error " + e.toString());
    }
  }

  Future<void> subscribeScaleDevice(
    DiscoveredDevice device,
    void Function(List<int>) emitState,
    void Function(MiScaleDevice) emit2State,
  ) async {
    scaleDevice = MiScaleDevice.from(
      device,
      Utils.instance.getAge(),
      Utils.instance.getHeight(),
      Utils.instance.getGender(),
    );

    final PairedDevice pairedDevice = PairedDevice();
    pairedDevice.deviceId = device.id;
    pairedDevice.deviceType = Utils.instance.getDeviceType(device);
    pairedDevice.modelName = device.name;
    pairedDevice.manufacturerName = device.name;

    _ble
        .discoverServices(device.id)
        .then((value) => LoggerUtils.instance.d(value.toString()));

    if (Platform.isAndroid) {
      await _ble.requestConnectionPriority(
        deviceId: device.id,
        priority: ConnectionPriority.highPerformance,
      );
    }

    _ble
        .readCharacteristic(
      QualifiedCharacteristic(
        characteristicId: Uuid.parse("2a25"),
        serviceId: Uuid.parse("180a"),
        deviceId: device.id,
      ),
    )
        .then((value) {
      pairedDevice.serialNumber = String.fromCharCodes(value);
    });

    subscribeScaleCharacteristic(device, pairedDevice, emitState, emit2State);
  }

  Future<void> subscribeScaleCharacteristic(
    DiscoveredDevice device,
    PairedDevice pairedDevice,
    void Function(List<int>) emitState,
    void Function(MiScaleDevice) emit2State,
  ) async {
    _controlPointResponse = <int>[];
    final deviceAlreadyPaired =
        await getIt<BluetoothConnector>().hasDeviceAlreadyPaired(pairedDevice);

    final _characteristic = QualifiedCharacteristic(
      characteristicId: Uuid([42, 156]),
      serviceId: Uuid([24, 27]),
      deviceId: device.id,
    );

    try {
      _ble.subscribeToCharacteristic(_characteristic).listen(
        (event) async {
          if (!(Atom.isDialogShow)) {
            Atom.show(
              MiScalePopUp(
                hasAlreadyPair: deviceAlreadyPaired,
              ),
            );
          }

          if (scaleDevice.scaleData == null ||
              !scaleDevice.scaleData!.scaleModel.measurementComplete!) {
            final Uint8List data = Uint8List.fromList(event);
            scaleDevice.parseScaleData(pairedDevice, data);

            if (scaleDevice.scaleData!.scaleModel.measurementComplete! && deviceAlreadyPaired) {
              scaleDevice.scaleData!.calculateVariables();
              if (Atom.isDialogShow) {
                Atom.dismiss();
              }
              await Future.delayed(const Duration(milliseconds: 350));
              await Atom.show(
                ScaleTaggerPopUp(
                  scaleModel: scaleDevice.scaleData!.scaleModel
                    ..isManuel = false,
                ),
                barrierDismissible: false,
              );
              scaleDevice.scaleData = null;
            }

            final popUpCanClose = (Atom.isDialogShow) &&
                (scaleDevice.scaleData!.scaleModel.weightRemoved)! &&
                !scaleDevice.scaleData!.scaleModel.measurementComplete!;

            if (popUpCanClose) {
              Atom.dismiss();
            }

            if ((scaleDevice.scaleData?.scaleModel.measurementComplete)! &&
                !deviceAlreadyPaired) {
              // Saving paired device Section
              controlPointResponse.add(1);
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                Atom.context
                    .read<BluetoothBloc>()
                    .add(BluetoothEvent.savePairedDevices(pairedDevice));
              });
            }
          }

          emitState(_controlPointResponse);
          emit2State(scaleDevice);
        },
        onError: (e, stk) {
          LoggerUtils.instance.e(e);
        },
      );
    } catch (e, stk) {
      LoggerUtils.instance.e(e);
      debugPrintStack(stackTrace: stk);
    }
  }

  void clearControlPointResponse(void Function(List<int>) emitState) {
    _controlPointResponse = <int>[];
    emitState(_controlPointResponse);
  }
}
