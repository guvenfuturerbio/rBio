import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../bluetooth_v2.dart';

class BluetoothStatusCubit extends Cubit<BluetoothStatus> {
  final BluetoothStatusUseCase useCase;
  BluetoothStatusCubit(this.useCase) : super(BluetoothStatus.unknown);

  StreamSubscription<BluetoothStatus>? _streamSubs;

  void listenStateOfBluetooth() {
    _streamSubs?.cancel();
    final result = useCase.call(NoParams());
    result.fold(
      (l) => LoggerUtils.instance.i("[BluetoothStatusCubit] - listen() - $l"),
      (r) {
        _streamSubs = r.listen((event) {
          emit(event);
        });
      },
    );
  }
}

enum BluetoothStatus {
  unknown,
  unavailable,
  unauthorized,
  turningOn,
  on,
  turningOff,
  off
}

extension BluetoothStatusExtension on BluetoothState {
  BluetoothStatus get xGetStatus {
    switch (this) {
      case BluetoothState.unknown:
        return BluetoothStatus.unknown;

      case BluetoothState.unavailable:
        return BluetoothStatus.unavailable;

      case BluetoothState.unauthorized:
        return BluetoothStatus.unauthorized;

      case BluetoothState.turningOn:
        return BluetoothStatus.turningOn;

      case BluetoothState.on:
        return BluetoothStatus.on;

      case BluetoothState.turningOff:
        return BluetoothStatus.turningOff;

      case BluetoothState.off:
        return BluetoothStatus.off;
    }
  }
}
