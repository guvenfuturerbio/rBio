import 'dart:async';

import 'package:scale_repository/scale_repository.dart';

import '../../../../../../core/core.dart';
import '../../../../bluetooth_v2.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mi_scale_ops_cubit.freezed.dart';
part 'mi_scale_ops_state.dart';

class MiScaleOpsCubit extends Cubit<MiScaleOpsState> {
  MiScaleOpsCubit(
    this.readValuesUseCase,
    this.miScaleStopUseCase,
  ) : super(const MiScaleOpsState.initial());
  final ReadValuesUseCase readValuesUseCase;
  final MiScaleStopUseCase miScaleStopUseCase;

  StreamSubscription<ScaleEntity>? _streamSubs;

  bool _isSuccessShow = false;
  void changeResultDialogStatus() {
    _isSuccessShow = !_isSuccessShow;
  }

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
              if (_isSuccessShow) {
                return;
              }
              emit(const MiScaleOpsState.dismissLoading());
              return;
            }

            emit(MiScaleOpsState.showLoading(scaleEntity));
            if (scaleEntity.measurementComplete == true) {
              if (!_isSuccessShow) {
                emit(const MiScaleOpsState.dismissLoading());
                await Future.delayed(const Duration(milliseconds: 350));
                emit(MiScaleOpsState.showScalePopup(scaleEntity));
                changeResultDialogStatus();
              }
            }

            final popUpCanClose = (Atom.isDialogShow) &&
                (scaleEntity.weightRemoved == true) &&
                (scaleEntity.measurementComplete == false);
            if (popUpCanClose) {
              if (_isSuccessShow) {
                return;
              }

              emit(const MiScaleOpsState.dismissLoading());
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
