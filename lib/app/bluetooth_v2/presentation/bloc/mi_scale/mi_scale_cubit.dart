import 'dart:async';

import 'package:scale_repository/scale_repository.dart';

import '../../../../../core/core.dart';
import '../../../bluetooth_v2.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mi_scale_cubit.freezed.dart';
part 'mi_scale_state.dart';

class MiScaleCubit extends Cubit<MiScaleState> {
  MiScaleCubit(
    this.readValuesUseCase,
    this.miScaleStopUseCase,
  ) : super(const MiScaleState.initial());
  final ReadValuesUseCase readValuesUseCase;
  final MiScaleStopUseCase miScaleStopUseCase;

  StreamSubscription<ScaleEntity>? _streamSubs;

  @override
  Future<void> close() async {
    _streamSubs?.cancel();
    super.close();
  }

  Future<void> readValue(DeviceEntity device) async {
    _streamSubs?.cancel();
    _streamSubs = null;
    final result = readValuesUseCase.call(ReadValuesParams(device: device));
    result.fold(
      (l) {
        return null;
      },
      (stream) {
        _streamSubs = stream.listen(
          (scaleEntity) async {
            if ((scaleEntity.weight ?? 0) < 15.0) {
              emit(const MiScaleState.dismissLoading());
              return;
            }

            emit(MiScaleState.showLoading(scaleEntity));
            if (scaleEntity.measurementComplete == true) {
              emit(const MiScaleState.dismissLoading());
              await Future.delayed(const Duration(milliseconds: 350));
              emit(MiScaleState.showScalePopup(scaleEntity));
            }

            final popUpCanClose = (Atom.isDialogShow) &&
                (scaleEntity.weightRemoved == true) &&
                (scaleEntity.measurementComplete == false);
            if (popUpCanClose) {
              emit(const MiScaleState.dismissLoading());
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
