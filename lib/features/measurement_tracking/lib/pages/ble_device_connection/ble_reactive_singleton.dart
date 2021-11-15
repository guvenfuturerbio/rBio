import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:onedosehealth/database/datamodels/glucose_data.dart';
import 'package:onedosehealth/database/repository/glucose_repository.dart';
import 'package:onedosehealth/database/repository/profile_repository.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/models/ble_models/DeviceTypes.dart';
import 'package:onedosehealth/models/user_profiles/person.dart';
import 'package:onedosehealth/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/pages/ble_device_connection/ble_reading_tagger.dart';
import 'package:onedosehealth/pages/ble_device_connection/mi_scale/mi_scale.dart';
import 'package:onedosehealth/pages/ble_device_connection/mi_scale/model/device/mi_scale_device.dart';
import 'package:onedosehealth/pages/ble_device_connection/mi_scale/model/mi_scale_data.dart';
import 'package:onedosehealth/pages/ble_device_connection/mi_scale/model/mi_scale_measurement.dart';
import 'package:onedosehealth/pages/signup&login/token_provider.dart';
import 'package:onedosehealth/services/base_provider.dart';
import 'package:onedosehealth/widgets/gradient_dialog.dart';
import 'package:onedosehealth/widgets/utils/base_provider_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_shortcuts/system_shortcuts.dart';

import 'ble_reading_tagger_list.dart';

class BLEHandler with ChangeNotifier {
  static final BLEHandler _instance = BLEHandler._internal();
  BuildContext context;

  static const LAST_PAIRED_DEVICE_KEY = "LAST_PAIRED_DEVICE_KEY";
  static const LAST_PAIRED_DEVICE_UUID_KEY = "LAST_PAIRED_DEVICE_UUID_KEY";
  static const LAST_PAIRED_DEVICE_SERIAL_NUMBER_KEY =
      "LAST_PAIRED_DEVICE_SERIAL_NUMBER";

  static int RESPONSE_NO_RECORDS_FOUND = 6;
  static int OP_CODE_RESPONSE_CODE = 6;
  static List<int> RACP_RESPONSE = List<int>(); // Record Access Control Point

  FlutterReactiveBle reactivebleclient = FlutterReactiveBle();
  StreamSubscription _subscription;
  StreamSubscription<ConnectionStateUpdate> _connection;
  Stream<DiscoveredDevice> _deviceSubscription;
  List<List<int>> readings = new List();
  List<GlucoseData> glucoseReadings = new List();
  List<DiscoveredDevice> devices = new List();
  List<MiScaleDevice> bodyCompositionDevices = new List();
  MiScaleData _miScaleData = new MiScaleData();

  MiScaleData get miScaleData => _miScaleData;

  final Blood_Pressure_SERVICE_UUID =
      Uuid.parse("00001810-0000-1000-8000-00805f9b34fb");
  final Weight_Scale_SERVICE_UUID =
      Uuid.parse("0000181D-0000-1000-8000-00805f9b34fb");
  final Ble_Device_Information =
      Uuid.parse("0000180A-0000-1000-8000-00805f9b34fb");

  final Uuid bodyCompositionService = Uuid([0x18, 0x1B]);

  final BODY_COMPOSITION_SERVICE_UUID = Uuid.parse("181B");

  final serviceUUIDS = [
    Uuid.parse("FC00"),
    Uuid.parse("1808"),
    Uuid.parse("00001810-0000-1000-8000-00805f9b34fb"),
    Uuid.parse("0000181D-0000-1000-8000-00805f9b34fb"),
    Uuid.parse("181B")
  ];

  bool scanStarted = false;

  factory BLEHandler() {
    return _instance;
  }

  FlutterReactiveBle get ble => reactivebleclient;

  BLEHandler._internal() {}

  bool alreadyConnecting = false;

  Future<bool> startScan(BuildContext context, bool autoConnect) async {
    try {
      print(
          "CAGDAS reactivebleclient ${reactivebleclient} & ${reactivebleclient.status}");
      reactivebleclient.statusStream.listen((event) {
        if (event == BleStatus.ready) {
          print(
              "BLEStatus: ${reactivebleclient.status}, started scanning! CAGDAS");
          print("Mi Scale Chars ${bodyCompositionService}");
          _deviceSubscription = reactivebleclient
              .scanForDevices(withServices: serviceUUIDS)
              .asBroadcastStream();
          _subscription = _deviceSubscription.listen((device) async {
            final knownDeviceIndex =
                devices.indexWhere((d) => d.id == device.id);
            final String previousDevice = await getSavedDeviceUUID(context);

            // mi scale
            // Determine the device type
            final scaleDevice = MiScaleDevice.from(device);
            // If no device type found, stop
            if (scaleDevice == null) {
              ;
            } else {
              final knownDeviceIndex2 =
                  bodyCompositionDevices.indexWhere((d) => d.id == device.id);
              if (knownDeviceIndex2 >= 0) {
                bodyCompositionDevices[knownDeviceIndex2] = scaleDevice;
                notifyListeners();
              } else {
                bodyCompositionDevices.add(scaleDevice);
                notifyListeners();
              }
            }
            if (knownDeviceIndex >= 0) {
              //print("ReDiscovered device $device");
              devices[knownDeviceIndex] = device;
              notifyListeners();
            } else {
              bool isFound = false;
              for (int i = 0; i < devices.length; i++) {
                if (devices[i].id == device.id) {
                  devices[i] = device;
                  isFound = true;
                }
              }
              if (isFound == false) {
                print("Discovered device $device");
                devices.add(device);
              }
              notifyListeners();
            }
            if ((previousDevice == device.id) &&
                !alreadyConnecting &&
                autoConnect) {
              // Device we are trying to connect to is active user's paired device!
              alreadyConnecting = true;
              connect(
                  context,
                  device,
                  true,
                  DeviceType
                      .ACCU_CHEK); // TODO Save device type in order to auto connect
            }
          }, onError: (error) {
            //code for handling error
            print("Error discovering devicess");
          });
        }
      });
      if (reactivebleclient.status == BleStatus.ready) {
      } else {
        //print("BLE is not ready CAGDAS");
        /*Future.delayed(new Duration(seconds: 2), () {
          //startScan(context, autoConnect);
        });*/
        /*await SystemShortcuts.bluetooth(); // just android
          if(event == BleStatus.unauthorized) {
            AppSettings.openBluetoothSettings();
          } else {
            //AppSettings.openWIFISettings();
          }*/
      }
    } catch (e) {
      print("ble_reactive_singleton : startScan Exception " + e.toString());
    }
  }

  Future<int> getSavedDevice(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Person activePerson = UserProfilesNotifier().selection;
    final lastPairedDevice = await sharedPreferences
        .getInt(activePerson.id.toString() + "_" + LAST_PAIRED_DEVICE_KEY);
    if (lastPairedDevice == null || lastPairedDevice == -1) {
      // No device is paired yet!
      return null;
    } else {
      return lastPairedDevice;
    }
  }

  Future<int> getSavedDeviceForPerson(
      BuildContext context, Person activePerson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final lastPairedDevice = await sharedPreferences
        .getInt(activePerson.id.toString() + "_" + LAST_PAIRED_DEVICE_KEY);
    if (lastPairedDevice == null || lastPairedDevice == -1) {
      // No device is paired yet!
      return null;
    } else {
      return lastPairedDevice;
    }
  }

  Future<String> getSavedDeviceUUID(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Person activePerson = UserProfilesNotifier().selection;
    final lastPairedDevice = await sharedPreferences.getString(
        activePerson.id.toString() + "_" + LAST_PAIRED_DEVICE_UUID_KEY);
    if (lastPairedDevice == null || lastPairedDevice == "") {
      // No device is paired yet!
      return "";
    } else {
      return lastPairedDevice;
    }
  }

  Future<void> stopScan() async {
    await _subscription?.cancel();
    _subscription = null;
    if (_connection != null) {
      print("Connection cancel");
      await _connection.cancel();
      _connection = null;
    }
    alreadyConnecting = false;
    readings = new List();
    glucoseReadings = new List();
    devices = new List();
    notifyListeners();
    return;
  }

  void checkDeviceRecordNumber(List<int> characteristicResponse,
      BuildContext context, DiscoveredDevice device) {
    int offset = 0;
    if (characteristicResponse[offset] == OP_CODE_RESPONSE_CODE) {
      if (characteristicResponse.length > 3) {
        offset += 3;
        if (characteristicResponse[offset] == RESPONSE_NO_RECORDS_FOUND) {
          print("no record found");
          RACP_RESPONSE = characteristicResponse;
          notifyListeners();
          saveDeviceToSharedPreferences(context, device);
          showCompletedDialog(context);
        }
      }
    }
  }

  Future<String> connect(BuildContext context, final DiscoveredDevice device,
      bool isSingle, DeviceType deviceType) async {
    // isSingle = false means device is selected manually by user from device connections page
    // isSingle = true means device was recorded before and now we autodetected new measurement
    print("Trying to connect to => $device");
    final int previousDevice = await getSavedDevice(context);
    final String previousUUID = await getSavedDeviceUUID(context);

    print("PRev UUID = ${previousUUID} , Current UUID = ${device.id} ");
    bool autoConnect = false;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (isSingle == false) {
      for (int i = 0; i < UserProfilesNotifier().profiles.person.length; i++) {
        final uuid = await sharedPreferences.getString(
            UserProfilesNotifier().profiles.person[i].toString() +
                "_" +
                LAST_PAIRED_DEVICE_UUID_KEY);
        print("Checking uuid = $uuid -> CAGDAS");
        if (uuid == device.id &&
            UserProfilesNotifier().selection.id !=
                UserProfilesNotifier().profiles.person[i].id) {
          return LocaleProvider.current.one_glucometer_one_profile_message;
        }
      }
    }
    print("isSingle == false check Complete -> CAGDAS");
    BaseProvider bp = BaseProvider.create(TokenProvider().authToken);
    /*if(isSingle == false) {
      final response = (await bp.isDeviceIdRegisteredForSomeUser(
          device.id, UserProfilesNotifier().selection.id ?? 0).timeout(new Duration(seconds: BaseProviderRepository.TIMEOUT_DURATION)));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        final bool isDeviceRegisteredBefore = responseBody["datum"] as bool;
        if (isDeviceRegisteredBefore != null &&
            isDeviceRegisteredBefore == true) {
          autoConnect = false;
          return LocaleProvider.current.glucometer_in_use_for_other_account;
        }
      }
    }*/

    if (previousUUID == "") {
      // No device connected before
      autoConnect = true;
    } else {
      if (previousUUID == device.id) {
        // Same device that was paired
        autoConnect = true; // If request is not pair request it's autoConnect
      } else {
        // User is trying to pair another device
        autoConnect = false;
        return LocaleProvider.current.new_profile_for_new_glucometer_message;
      }
    }
    print("autoConnect $autoConnect -> CAGDAS");
    if (autoConnect) {
      try {
        print("connectToDevice id: ${device.id}");
        print("reactivebleclient: ${reactivebleclient}");
        _connection = reactivebleclient.connectToDevice(id: device.id).listen(
            (event) async {
          print("Manufacturer Data = ${device.manufacturerData}");
          //print("devId = ${device.manufacturerData[0]}");
          print("Connection State = ${event.connectionState}");
          if (event.connectionState == DeviceConnectionState.connected) {
            print("CONNECTED to device $event");
            alreadyConnecting = false;
            print("Writing Characteristics!");
            if (Platform.isAndroid) {
              await ble.requestConnectionPriority(
                  deviceId: device.id,
                  priority: ConnectionPriority.highPerformance);
            }

            if (bodyCompositionDevices.length > 0 &&
                bodyCompositionDevices[0].id == device.id) {
              final data = bodyCompositionDevices[0]
                  .parseScaleData(device.serviceData.values.first);
              print("MI SCALE DATA: $data");
              _miScaleData = (data);
              if (deviceType == DeviceType.MI_SCALE) {
                try {
                  final characteristicMi = QualifiedCharacteristic(
                      serviceId: Uuid.parse("181B"),
                      characteristicId: Uuid.parse("181B"),
                      deviceId: device.id);
                  ble.subscribeToCharacteristic(characteristicMi).listen(
                      (data) {
                    // code to handle incoming data
                    print("Service 181B: Characteristic: 181B Data: $data");
                  }, onError: (dynamic error) {
                    print(error);
                    // code to handle errors
                  });
                } catch (e) {
                  print("Error subscribing characteristic for Mi");
                }
                if (bodyCompositionDevices.length > 0) {
                  print("Body Composition, ${bodyCompositionDevices[0].name}");
                }
              }
            } else {
              Future.delayed(new Duration(seconds: 1), () {
                write(context, device, isSingle, deviceType);
              });
            }
          } else if (event.connectionState ==
              DeviceConnectionState.disconnected) {
            print("DISCONNECTED from device $event");
            for (int i = 0; i < devices.length; i++) {
              if (devices[i].id == device.id) {
                devices.removeAt(i);
                notifyListeners();
                break;
              }
            }
            //startScan(context, true);
          } else {
            print("State Update $event : ${event.connectionState}");
            //an(context, true);
          }
          notifyListeners();
          return "";
        }, onError: (dynamic error) {
          print("Error Connecting: $error");
        }, onDone: () {
          print("Done connecting");
        });
        print("Connection $_connection -> CAGDAS");
        return "";
      } catch (e) {
        print("Failed to connect to device $device");
        return "";
      }
    }
  }

  void write(BuildContext context, final DiscoveredDevice device, bool isSingle,
      DeviceType deviceType) async {
    readings.clear();
    glucoseReadings.clear();
    notifyListeners();

    if (deviceType == DeviceType.OMRON_BLOOD_PRESSURE_ARM ||
        deviceType == DeviceType.OMRON_BLOOD_PRESSURE_WRIST ||
        deviceType == DeviceType.OMRON_SCALE) {
      /// OMRON BLOOD PRESSURE CHARACTERISTICS
      final bloodPressureCharacteristic = QualifiedCharacteristic(
          characteristicId: Uuid.parse("00002A35-0000-1000-8000-00805f9b34fb"),
          serviceId: Blood_Pressure_SERVICE_UUID,
          deviceId: device.id);
      final bloodPressureCharacteristicFeature = QualifiedCharacteristic(
          characteristicId: Uuid.parse("00002A49-0000-1000-8000-00805f9b34fb"),
          serviceId: Blood_Pressure_SERVICE_UUID,
          deviceId: device.id);
      ble.subscribeToCharacteristic(bloodPressureCharacteristic).listen((data) {
        // code to handle incoming data
        print("Blood Pressure Service C1 $data");
      }, onError: (dynamic error) {
        print(error);
        // code to handle errors
      });

      ble.subscribeToCharacteristic(bloodPressureCharacteristicFeature).listen(
          (data) {
        // code to handle incoming data
        print("Blood Pressure Service C2: $data");
      }, onError: (dynamic error) {
        print(error);
        // code to handle errors
      });

      final characteristic2 = QualifiedCharacteristic(
          serviceId: Blood_Pressure_SERVICE_UUID,
          characteristicId: bloodPressureCharacteristic.characteristicId,
          deviceId: device.id);
      try {
        ble
            .subscribeToCharacteristic(bloodPressureCharacteristicFeature)
            .listen((event) {
          print("Service: Blood_Pressure_SERVICE_UUID , Data Listened: $event");
        });
        ble.writeCharacteristicWithResponse(bloodPressureCharacteristicFeature,
            value: [0x10, 0x20]);
      } catch (e) {
        print(e.toString());
      }
    } else if (deviceType == DeviceType.CONTOUR_PLUS_ONE ||
        deviceType == DeviceType.ACCU_CHEK) {
      /// BLOOD GLUCOSE CHARACTERISTICS
      /*final characteristic6 = QualifiedCharacteristic(
          serviceId: Uuid.parse("180a"),
          characteristicId: Uuid.parse("2a24"),
          deviceId: device.id);
      ble.subscribeToCharacteristic(characteristic6).listen((data) {
        // code to handle incoming data
        print("Service 180a: Characteristic: 2a24 Data: $data");
      }, onError: (dynamic error) {
        print(error);
        // code to handle errors
      });*/
      final characteristic = QualifiedCharacteristic(
          serviceId: Uuid.parse("1808"),
          characteristicId: Uuid.parse("2a18"),
          deviceId: device.id);
      ble.subscribeToCharacteristic(characteristic).listen((data) {
        // code to handle incoming data
        print("Service 1808: Characteristic: 2A18 Data: $data");
        saveDeviceToSharedPreferences(context, device);
        saveGlucoseDataToDatabase(context, data, device, isSingle);
        readings.add(data);
        notifyListeners();
      }, onError: (dynamic error) {
        print("Error Service 1808: Characteristic: 2a18 subscribe " +
            error.toString());
        // code to handle errors
      });
      //await reactiveBleClient.clearGattCache(device.id);
      /*final characteristic3 = QualifiedCharacteristic(
          serviceId: Uuid.parse("1808"),
          characteristicId: Uuid.parse("2a34"),
          deviceId: device.id);
      ble.subscribeToCharacteristic(characteristic3).listen((data) {
        // code to handle incoming data
        print("Service 1808: Characteristic: 2a34 Data: $data");
      }, onError: (dynamic error) {
        print(error);
        // code to handle errors
      });*/
      /*final characteristic4 = QualifiedCharacteristic(
          serviceId: Uuid.parse("1808"),
          characteristicId: Uuid.parse("2a52"),
          deviceId: device.id);
      ble.subscribeToCharacteristic(characteristic4).listen((data) {
        // code to handle incoming data
        print("Service 1808: Characteristic: 2a52 Data: $data");
      }, onError: (dynamic error) {
        print(error);
        // code to handle errors
      });*/

      final characteristic2 = QualifiedCharacteristic(
          serviceId: Uuid.parse("1808"),
          characteristicId: Uuid.parse("2a52"),
          deviceId: device.id);
      /*try {
        ble.subscribeToCharacteristic(characteristic2).listen((event) {
          print("Service: 1808, Characteristic: 2A52, Data Listened: $event");
        });
        ble.writeCharacteristicWithResponse(characteristic2,
            value: [0x01, 0x01]);
      } catch (e) {
        print(e.toString());
      }*/
      try {
        ble.subscribeToCharacteristic(characteristic2).listen((event) {
          print("Service: 1808, Characteristic: 2A52, Data Listened: $event");
          checkDeviceRecordNumber(event, context, device);
        });
        ble.writeCharacteristicWithResponse(characteristic2,
            value: [0x01, 0x01]);
      } catch (e) {
        print(e.toString());
      }

      ble.discoverServices(device.id).then((value) {
        print("DISCOVER SERVICES " + value.toString());
      });

      ble
          .readCharacteristic(QualifiedCharacteristic(
              characteristicId: Uuid.parse("2a24"),
              serviceId: Uuid.parse("180a"),
              deviceId: device.id))
          .then((value) {
        List<int> charCodes = value;
        print("2a24 model name " + String.fromCharCodes(charCodes));
        print("2a24" + value.toString());
      });

      ble
          .readCharacteristic(QualifiedCharacteristic(
              characteristicId: Uuid.parse("2a25"),
              serviceId: Uuid.parse("180a"),
              deviceId: device.id))
          .then((value) {
        List<int> charCodes = value;
        print("2a25 serial number " + String.fromCharCodes(charCodes));
        saveSerialNumberToSharedPreferences(
            context, device, String.fromCharCodes(charCodes));
        print("2a25" + value.toString());
      });

      ble
          .readCharacteristic(QualifiedCharacteristic(
              characteristicId: Uuid.parse("2a29"),
              serviceId: Uuid.parse("180a"),
              deviceId: device.id))
          .then((value) {
        List<int> charCodes = value;
        print("2a29 manufacturer namr " + String.fromCharCodes(charCodes));
        print("2a29" + value.toString());
      });
    } else if (deviceType == DeviceType.MI_SCALE) {
      try {
        final characteristicMi = QualifiedCharacteristic(
            serviceId: Uuid.parse("181B"),
            characteristicId: Uuid.parse("181B"),
            deviceId: device.id);
        ble.subscribeToCharacteristic(characteristicMi).listen((data) {
          // code to handle incoming data
          print("Service 181B: Characteristic: 181B Data: $data");
        }, onError: (dynamic error) {
          print(error);
          // code to handle errors
        });
      } catch (e) {
        print("Error subscribing characteristic for Mi");
      }
      if (bodyCompositionDevices.length > 0) {
        print("Body Composition, ${bodyCompositionDevices[0].name}");
      }
    }
  }

  saveGlucoseDataToDatabase(BuildContext context, data, DiscoveredDevice device,
      bool isSingle) async {
    GlucoseData gData = parseGlucoseDataFromReadingInstance(data, device);
    bool doesExist = await GlucoseRepository().doesDataExist(gData.time);
    if (doesExist) {
      print("$gData exists in DB! " + DateTime.now().toString());
    } else {
      gData.userId = UserProfilesNotifier().selection?.id ?? 0;
      if (isSingle) {
        showTaggingDialog(context, gData);
      } else {
        await GlucoseRepository().addNewGlucoseData(gData, true);
        print('nerdaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        glucoseReadings.add(gData);
        notifyListeners();
        await showTaggingList(context);
      }
    }
  }

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
    print(measureDT.millisecondsSinceEpoch);
    if ((device.manufacturerData[0] ?? 0) == 103) {
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
    } else if ((device.manufacturerData[0] ?? 0) == 112) {
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
    }
  }

  bool didShowDialog = false;

  Future<void> showTaggingList(BuildContext context) async {
    if (!didShowDialog) {
      didShowDialog = true;
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => BleReadingTaggerList()),
      );
    }
    return;
  }

  Future<void> showTaggingDialog(
      BuildContext context, GlucoseData gData) async {
    showDialog(
      context: context,
      builder: (context) {
        return BleReadingTagger(lastReading: gData);
      },
    );
    didShowDialog = true;
    return;
  }

  showCompletedDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.information,
              LocaleProvider.current.device_pairing_completed);
        }).then((value) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  String getReadableTimeFromDateTime(DateTime measureDT) {
    return "${measureDT.hour > 9 ? measureDT.hour : "0" + measureDT.hour.toString()}:${measureDT.minute > 9 ? measureDT.minute : "0" + measureDT.minute.toString()}  ${measureDT.day}.${measureDT.month}.${measureDT.year}";
  }

  void assignTagToMeasurement(BuildContext context, int tag, int row) async {
    await GlucoseRepository().updateMeasurementTag(tag, row);
  }

  void updateMeasurementImageUrl(
      BuildContext context, String path, int timeKey) async {
    await GlucoseRepository().updateMeasurementImageUrl(path, timeKey);
  }

  static const DEFAULT_VERY_LOW = 36;
  static const DEFAULT_LOW = 91;
  static const DEFAULT_TARGET = 131;
  static const DEFAULT_HIGH = 151;
  static const DEFAULT_VERY_HIGH = 301;

  Future<String> getSavedSerialNumber(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Person activePerson = UserProfilesNotifier().selection;
    final lastSerialNumber = await sharedPreferences.getString(
        activePerson.id.toString() +
            "_" +
            LAST_PAIRED_DEVICE_SERIAL_NUMBER_KEY);
    if (lastSerialNumber == null || lastSerialNumber == "") {
      // No device is paired yet!
      return null;
    } else {
      return lastSerialNumber;
    }
  }

  Future<String> getSavedSerialNumberForPerson(
      BuildContext context, Person activePerson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final lastSerialNumber = await sharedPreferences.getString(
        activePerson.id.toString() +
            "_" +
            LAST_PAIRED_DEVICE_SERIAL_NUMBER_KEY);
    if (lastSerialNumber == null || lastSerialNumber == "") {
      // No device is paired yet!
      return null;
    } else {
      return lastSerialNumber;
    }
  }

  saveSerialNumberToSharedPreferences(BuildContext context,
      DiscoveredDevice device, String serialNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String previousDevice = await getSavedSerialNumber(context);
    if (previousDevice == null) {
      Person activePerson = UserProfilesNotifier().selection;

      await sharedPreferences.setString(
          activePerson.id.toString() +
              "_" +
              LAST_PAIRED_DEVICE_SERIAL_NUMBER_KEY,
          serialNumber);
    } else {
      return;
    }
  }

  saveDeviceToSharedPreferences(
      BuildContext context, DiscoveredDevice device) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final int previousDevice = await getSavedDevice(context);
    if (previousDevice == null) {
      //UserProfilesNotifier().changeDeviceUUID(device.id);
      UserProfilesNotifier().changeDeviceManufacturerId(
          (device.manufacturerData == null ||
                  device.manufacturerData.length < 1)
              ? 112
              : device.manufacturerData[0]);
      ProfileRepository().updateProfile(UserProfilesNotifier().selection);

      Person activePerson = UserProfilesNotifier().selection;

      await sharedPreferences.setInt(
          activePerson.id.toString() + "_" + LAST_PAIRED_DEVICE_KEY,
          (device.manufacturerData == null ||
                  device.manufacturerData.length < 1)
              ? 112
              : device.manufacturerData[0]);
      await sharedPreferences.setString(
          activePerson.id.toString() + "_" + LAST_PAIRED_DEVICE_UUID_KEY,
          (device.id == null || device.id.length < 1)
              ? "Unknown UUID"
              : device.id);
      ProfileRepository()
          .updateDeviceUUIDById(activePerson.id, device.id ?? "Unknown UUID");
    } else {
      return;
    }
  }

  saveSerialNumberToSharedPreferencesForPerson(
      BuildContext context, String serialNumber, Person activePerson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String previousDevice =
        await getSavedSerialNumberForPerson(context, activePerson);
    if (previousDevice == null) {
      await sharedPreferences.setString(
          activePerson.id.toString() +
              "_" +
              LAST_PAIRED_DEVICE_SERIAL_NUMBER_KEY,
          serialNumber);
    } else {
      return;
    }
  }

  saveDeviceToSharedPreferencesForPerson(BuildContext context, String deviceId,
      int manufacturerId, Person activePerson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // TODO: backend should store manufacturer data and restore it to the client

    final int previousDevice =
        await getSavedDeviceForPerson(context, activePerson);
    if (previousDevice == null) {
      if (manufacturerId != null) {
        UserProfilesNotifier().changeDeviceManufacturerId(
            (manufacturerId == null) ? 112 : manufacturerId);
      }

      ProfileRepository().updateProfile(activePerson);

      await sharedPreferences.setInt(
          activePerson.id.toString() + "_" + LAST_PAIRED_DEVICE_KEY,
          (manufacturerId == null) ? 112 : manufacturerId);
      await sharedPreferences.setString(
          activePerson.id.toString() + "_" + LAST_PAIRED_DEVICE_UUID_KEY,
          (deviceId == null) ? "Unknown UUID" : deviceId);
      ProfileRepository()
          .updateDeviceUUIDById(activePerson.id, deviceId ?? "Unknown UUID");
    } else {
      return;
    }
  }

  void clearReadings() {
    glucoseReadings.clear();
    readings.clear();
    didShowDialog = false;
  }

  /// XIAOMI Devices

  /// Starts a scan for compatible devices
  ///
  /// Found devices are returned as a [MiScaleDevice] instance.
  /// The scan will automatically stop after the set [duration].
  /// To stop the scan prematurely, cancel the returned stream.
  Stream<MiScaleDevice> discoverDevices(
      {Duration duration = const Duration(seconds: 5)}) {
    StreamSubscription scanSubscription;
    StreamController<MiScaleDevice> controller;
    final foundDeviceIds = <String>[];
    controller = StreamController<MiScaleDevice>.broadcast(
      onListen: () async {
        scanSubscription = _deviceSubscription?.listen((device) {
          // Determine the device type
          final scaleDevice = MiScaleDevice.from(device);
          // If no device type found, stop
          if (scaleDevice == null) return;
          // If we already found it, stop
          if (foundDeviceIds.contains(scaleDevice.id)) return;
          // Add it to the list of found devices
          foundDeviceIds.add(scaleDevice.id);
          // Emit data
          controller.add(scaleDevice);
        });
        await Future.delayed(duration);
        await scanSubscription?.cancel();
        if (!controller.isClosed) await controller.close();
      },
      onCancel: () {
        scanSubscription?.cancel();
        controller.close();
        foundDeviceIds.clear();
      },
    );
    return controller.stream;
  }

  /// Listens for any incoming scale data
  ///
  /// The returned stream emits a [MiScaleData] for each received advertisement packet.
  /// Unless you need access to the parsed advertisement data directly, It is preferable to use [takeMeasurements] instead.
  Stream<MiScaleData> readScaleData() {
    StreamSubscription scanSubscription;
    StreamController<MiScaleData> controller;
    controller = StreamController<MiScaleData>.broadcast(
      onListen: () {
        scanSubscription = _deviceSubscription?.listen((device) {
          final scaleDevice = MiScaleDevice.from(device);
          // Stop if it's not a known scale device
          if (scaleDevice == null) return;
          // Parse scale data
          final data =
              scaleDevice.parseScaleData(device.serviceData.values.first);
          if (data == null) return;
          // Emit data
          controller.add(data);
        });
      },
      onCancel: () {
        scanSubscription?.cancel();
        controller.close();
      },
    );
    return controller.stream;
  }

  final _activeMeasurements = <String, MiScaleMeasurement>{};

  /// Cancel any active measurement for the given device
  ///
  /// Read 'active measurement' as a measurement not on the [MiScaleMeasurementStage.MEASURED] stage.
  /// NOTE: If a user steps off the scale before the [MiScaleMeasurementStage.STABILIZED] stage is reached, the measurement will remain active.
  /// In this case, the measurement will have to be canceled before a new measurement is to be started.
  void cancelMeasurement(String deviceId) {
    _activeMeasurements.remove(deviceId);
  }

  /// Listens for weight measurements
  ///
  /// Provides a stream of [MiScaleMeasurement] instances.
  /// Multiple instances are emitted for the same measurement throughout the progress of the measurement to denote changes.
  /// The measurements continue to be taken until the returned stream is cancelled.
  Stream<MiScaleMeasurement> takeMeasurements() {
    StreamSubscription dataSubscription;
    StreamSubscription cleanUpSubscription;
    StreamController<MiScaleMeasurement> controller;
    controller = StreamController<MiScaleMeasurement>.broadcast(
      onListen: () {
        // Process scale data into measurements
        dataSubscription = readScaleData().listen((scaleData) {
          final measurement = MiScaleMeasurement.processData(
            _activeMeasurements[scaleData.deviceId],
            scaleData,
          );
          if (measurement != null &&
              measurement.stage != MiScaleMeasurementStage.MEASURED) {
            _activeMeasurements[scaleData.deviceId] = measurement;
          } else {
            _activeMeasurements.remove(scaleData.deviceId);
          }
          if (measurement != null) controller.add(measurement);
        });
      },
      onCancel: () {
        dataSubscription?.cancel();
        cleanUpSubscription?.cancel();
        _activeMeasurements.clear();
        controller.close();
      },
    );
    return controller.stream.distinct();
  }
}
