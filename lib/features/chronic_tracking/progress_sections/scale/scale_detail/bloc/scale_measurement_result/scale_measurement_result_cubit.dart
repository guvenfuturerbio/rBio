import 'package:bloc/bloc.dart';
import 'package:scale_repository/scale_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../core/core.dart';

part 'scale_measurement_result_state.dart';
part 'scale_measurement_result_cubit.freezed.dart';

class ScaleMeasurementResultCubit extends Cubit<ScaleMeasurementResultState> {
  ScaleMeasurementResultCubit(
    ScaleEntity scaleEntity,
    this.scaleRepository,
    this.profileStorageImpl,
  ) : super(ScaleMeasurementResultState.initial(scaleEntity));
  late final ScaleRepository scaleRepository;
  late final ProfileStorageImpl profileStorageImpl;

  // #region save
  Future<void> save() async {
    final currentState = state;
    currentState.whenOrNull(
      initial: (scaleEntity) async {
        try {
          final requestBody = AddScaleMasurementBody(
            entegrationId: profileStorageImpl.getFirst().id,
            occurrenceTime: scaleEntity.dateTime,
            weight: scaleEntity.weight,
            water: scaleEntity.water,
            bmi: scaleEntity.bmi,
            bodyFat: scaleEntity.bodyFat,
            bmh: scaleEntity.bmh,
            visceralFat: scaleEntity.visceralFat,
            boneMass: scaleEntity.boneMass,
            muscle: scaleEntity.muscle,
            scaleUnit: scaleEntity.unit.xScaleToInt,
            deviceUUID: scaleEntity.deviceId,
            note: scaleEntity.note,
            isManuel: scaleEntity.isManuel,
          );
          final isSuccess =
              await scaleRepository.addScaleMeasurement(requestBody);
          if (isSuccess) {
            emit(const ScaleMeasurementResultState.successAdded());
          } else {
            emit(const ScaleMeasurementResultState.failure());
          }
        } catch (e) {
          emit(const ScaleMeasurementResultState.failure());
        }
      },
    );
  }
  // #endregion
}
