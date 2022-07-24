import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../config/config.dart';

part 'scale_manuel_add_cubit.freezed.dart';
part 'scale_manuel_add_state.dart';

class ScaleManuelAddCubit extends Cubit<ScaleManuelAddState> {
  ScaleManuelAddCubit(this.profileStorageImpl, this.scaleRepository)
      : super(ScaleManuelAddState.initial(
            ScaleManuelAddResult(dateTime: DateTime.now())));
  late final ProfileStorageImpl profileStorageImpl;
  late final ScaleRepository scaleRepository;

  // #region changeDateTime
  void changeDateTime(DateTime dateTime) {
    final currentState = state;
    currentState.whenOrNull(
      initial: (result) {
        emit(
          ScaleManuelAddState.initial(
            result.copyWith(
              dateTime: dateTime,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region changeWeight
  void changeWeight(double value) {
    final currentState = state;
    currentState.whenOrNull(
      initial: (result) {
        emit(
          ScaleManuelAddState.initial(
            result.copyWith(
              weight: value,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region changeScaleUnit
  void changeScaleUnit(ScaleUnit value) {
    final currentState = state;
    currentState.whenOrNull(
      initial: (result) {
        emit(
          ScaleManuelAddState.initial(
            result.copyWith(
              scaleUnit: value,
            ),
          ),
        );
      },
    );
  }
  // #endregion

  // #region save
  Future<void> save() async {
    final currentState = state;
    currentState.whenOrNull(
      initial: (result) async {
        final isValid = _checkValidation(result);
        if (!isValid) return;

        try {
          final requestBody = AddScaleMasurementBody(
            entegrationId: profileStorageImpl.getFirst().id,
            occurrenceTime: result.dateTime,
            weight: result.weight,
            bmi: ScaleCalculate.instance.getBMI(
              weight: result.weight!,
              height: Utils.instance.getHeight()!,
            ),
            bmh: ScaleCalculate.instance.getBMH(
              gender: Utils.instance.getGender(),
              weight: result.weight!,
              height: Utils.instance.getHeight()!,
              age: Utils.instance.getAge(),
            ),
            scaleUnit: result.scaleUnit.xScaleToInt,
            note: "",
            isManuel: true,
            deviceUUID: null,
          );
          final isSuccess =
              await scaleRepository.addScaleMeasurement(requestBody);
          if (isSuccess) {
            emit(const ScaleManuelAddState.successAdded());
          } else {
            emit(const ScaleManuelAddState.failure());
          }
        } catch (e, stackTrace) {
          getIt<IAppConfig>()
              .platform
              .sentryManager
              .captureException(e, stackTrace: stackTrace);
          emit(const ScaleManuelAddState.failure());
        }
      },
    );
  }
  // #endregion

  // #region _checkValidation
  bool _checkValidation(ScaleManuelAddResult result) {
    if (result.weight == null) {
      _showWarningDialog(LocaleProvider.current.fill_all_field);
      return false;
    }

    return true;
  }
  // #endregion

  // #region _showWarningDialog
  void _showWarningDialog(String description) {
    final currentState = state;
    emit(ScaleManuelAddState.showWarningDialog(description));
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        emit(currentState);
      },
    );
  }
  // #endregion
}
