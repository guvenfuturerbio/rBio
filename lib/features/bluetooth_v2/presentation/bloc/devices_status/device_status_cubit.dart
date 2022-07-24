import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../bluetooth_v2.dart';

part 'device_status.dart';

class DeviceStatusCubit extends Cubit<DeviceStatus?> {
  final ReadStatusDeviceUseCase useCase;
  DeviceStatusCubit(this.useCase) : super(null);

  StreamSubscription<DeviceStatus>? _streamSubs;

  @override
  Future<void> close() async {
    _streamSubs?.cancel();
    super.close();
  }

  void readStatus(DeviceEntity device) {
    _streamSubs?.cancel();
    final result = useCase.call(DeviceParams(device: device));
    result.fold((l) {
      LoggerUtils.instance.e("[DeviceStatusCubit] - Left - $l");
    }, (stream) {
      _streamSubs = stream.listen((event) {
        emit(event);
      });
    });
  }
}
