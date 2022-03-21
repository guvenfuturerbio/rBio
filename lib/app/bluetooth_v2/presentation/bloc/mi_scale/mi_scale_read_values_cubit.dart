import 'dart:async';

import '../../../bluetooth_v2.dart';

class MiScaleReadValuesCubit extends Cubit<MiScaleReadValuesState> {
  MiScaleReadValuesCubit(
    this.readValuesUseCase,
  ) : super(const MiScaleReadValuesState());
  final ReadValuesUseCase readValuesUseCase;

  StreamSubscription<MiScaleModel>? _streamSubs;

  @override
  Future<void> close() async {
    _streamSubs?.cancel();
    super.close();
  }

  Future<void> readValue(DeviceEntity device, String field) async {
    _streamSubs?.cancel();
    _streamSubs = null;
    final result = readValuesUseCase.call(
      ReadValuesParams(
        device: device,
        field: field,
      ),
    );
    result.fold((l) {
      print("[ReadValuesCubit] - Left - $l");
      return null;
    }, (stream) {
      _streamSubs = stream.listen((event) {
        emit(MiScaleReadValuesState(miScaleModel: event));
      });
      return null;
    });
  }
}

class MiScaleReadValuesState extends Equatable {
  final MiScaleModel? miScaleModel;

  const MiScaleReadValuesState({
    this.miScaleModel,
  });

  @override
  List<Object?> get props => [miScaleModel];
}
