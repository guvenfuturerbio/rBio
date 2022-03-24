import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../bluetooth_v2.dart';

part 'bluetooth_status.dart';

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
