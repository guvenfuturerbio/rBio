import 'dart:async';

import '../../../bluetooth_v2.dart';

class AccuChekOpsCubit extends Cubit<bool> {
  AccuChekOpsCubit(this.accuChekReadValuesUseCase) : super(false);
  final AccuChekReadValuesUseCase accuChekReadValuesUseCase;

  final Map<String, StreamSubscription<List<int>>?> _streamSubs = {};

  @override
  Future<void> close() async {
    _streamSubs.forEach((key, value) {
      value?.cancel();
    });
    super.close();
  }

  void readData(DeviceEntity device) {
    if (_streamSubs.containsKey(device.id)) {
      _streamSubs[device.id]?.cancel();
      _streamSubs[device.id] = null;
    }

    final result = accuChekReadValuesUseCase.call(DeviceParams(device: device));
    result.fold(
      (l) {
        return null;
      },
      (r) {
        _streamSubs[device.id] = r.listen((event) {
          LoggerUtils.instance
              .i("AccuChekOpsCubit-Read Data: ${String.fromCharCodes(event)}");
        });
      },
    );
  }
}
