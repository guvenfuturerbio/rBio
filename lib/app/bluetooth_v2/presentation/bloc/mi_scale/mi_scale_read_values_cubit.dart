import 'dart:async';

import 'package:scale_repository/scale_repository.dart';

import '../../../../../core/core.dart';
import '../../../bluetooth_v2.dart';
import 'mi_scale_state.dart';

class MiScaleReadValuesCubit extends Cubit<MiScaleReadValuesState> {
  MiScaleReadValuesCubit(
    this.readValuesUseCase,
    this.miScaleStopUseCase,
  ) : super(const MiScaleReadValuesState.initial());
  final ReadValuesUseCase readValuesUseCase;
  final MiScaleStopUseCase miScaleStopUseCase;

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
    result.fold(
      (l) {
        return null;
      },
      (stream) {
        _streamSubs = stream.listen(
          (scaleEntity) async {
            if ((scaleEntity.weight ?? 0) < 15.0) {
              emit(const MiScaleReadValuesState.dismissLoading());
              return;
            }

            emit(MiScaleReadValuesState.showLoading(scaleEntity));
            if (scaleEntity.measurementComplete == true) {
              emit(const MiScaleReadValuesState.dismissLoading());
              await Future.delayed(const Duration(milliseconds: 350));
              emit(MiScaleReadValuesState.showScalePopup(scaleEntity));
            }

            final popUpCanClose = (Atom.isDialogShow) &&
                (scaleEntity.weightRemoved == true) &&
                (scaleEntity.measurementComplete == false);
            if (popUpCanClose) {
              emit(const MiScaleReadValuesState.dismissLoading());
            }
          },
        );
      },
    );
  }

  void stopListen() {
    _streamSubs?.cancel();
    miScaleStopUseCase.call(NoParams());
  }
}
