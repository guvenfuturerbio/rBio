import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bluetooth_v2.dart';

class PillarSmallCubit extends Cubit<bool> {
  final PillarSmallTriggerUseCase useCase;

  PillarSmallCubit(this.useCase) : super(true);

  FutureOr<void> trigger(DeviceEntity device) async {
    useCase.call(DeviceParams(device: device));
  }
}
