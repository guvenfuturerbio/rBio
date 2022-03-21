import 'dart:async';

import '../../../../../core/core.dart';
import '../../../bluetooth_v2.dart';

part 'device_search_state.dart';

class DeviceSearchCubit extends Cubit<DeviceSearchState> {
  final SearchDeviceUseCase useCase;
  final StopScanUseCase stopScanUseCase;
  DeviceSearchCubit(this.useCase, this.stopScanUseCase)
      : super(const DeviceSearchState.initial());

  StreamSubscription<List<DeviceEntity>>? _streamSubs;

  @override
  Future<void> close() async {
    _streamSubs?.cancel();
    super.close();
  }

  void startSearching(DeviceType deviceType) {
    _streamSubs?.cancel();
    emit(const DeviceSearchState.searching());
    final result = useCase.call(SearchParams(deviceType: deviceType));
    result.fold((l) {
      emit(const DeviceSearchState.error("Something went wrong"));
    }, (stream) {
      _streamSubs = stream.listen((event) {
        emit(DeviceSearchState.done(event));
      });
    });
  }

  void stopScan() {
    _streamSubs?.cancel();
    emit(const DeviceSearchState.done([]));
    _streamSubs = null;
    final result = stopScanUseCase.call(NoParams());
    result.fold((l) {
      print("[DeviceSearchCubit] - Left - $l");
    }, (r) {
      print("[DeviceSearchCubit] - Right - true");
    });
  }
}
