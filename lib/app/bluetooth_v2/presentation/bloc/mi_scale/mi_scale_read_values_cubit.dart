import 'dart:async';
import 'package:scale_repository/scale_repository.dart';

import '../../../bluetooth_v2.dart';

class MiScaleReadValuesCubit extends Cubit<MiScaleReadValuesState> {
  MiScaleReadValuesCubit(
    this.readValuesUseCase,
  ) : super(const MiScaleReadValuesState());
  final ReadValuesUseCase readValuesUseCase;

  StreamSubscription<ScaleEntity>? _streamSubs;

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
      return null;
    }, (stream) {
      _streamSubs = stream.listen((event) {
        emit(MiScaleReadValuesState(scaleEntity: event));
      });
      return null;
    });
  }

  Future<void> resetState() async {
    emit(const MiScaleReadValuesState(scaleEntity: null));
  }
}

class MiScaleReadValuesState extends Equatable {
  final ScaleEntity? scaleEntity;

  const MiScaleReadValuesState({
    this.scaleEntity,
  });

  @override
  List<Object?> get props => [scaleEntity];
}
