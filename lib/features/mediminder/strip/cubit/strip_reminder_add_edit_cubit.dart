import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

part 'strip_reminder_add_edit_state.dart';
part 'strip_reminder_add_edit_cubit.freezed.dart';

class StripReminderAddEditCubitCubit
    extends Cubit<StripReminderAddEditCubitState> {
  StripReminderAddEditCubitCubit(
    this.sharedPreferencesManager,
    this.chronicTrackingRepository,
    this.profileStorage,
    this.localNotificationManager,
  ) : super(const StripReminderAddEditCubitState.initial());
  late final ISharedPreferencesManager sharedPreferencesManager;
  late final ChronicTrackingRepository chronicTrackingRepository;
  late final ProfileStorageImpl profileStorage;
  late final LocalNotificationManager localNotificationManager;

  int _initCount = 0;
  Person? _userLocal;

  var stripDetailModel = StripDetailModel();
  var sharedKeys = SharedPreferencesKeys.usedStripCount;

  Future<void> setInitState() async {
    try {
      // TODO ------------ ------------
      stripDetailModel.alarmCount = 10;
      stripDetailModel.currentCount = 50;
      stripDetailModel.deviceUUID = "ID";
      stripDetailModel.entegrationId = 10;
      stripDetailModel.isNotificationActive = true;

      emit(const StripReminderAddEditCubitState.loadInProgress());
      await Future.delayed(const Duration(seconds: 2));
      emit(
        StripReminderAddEditCubitState.success(
          StripReminderAddEditResult(
            alarmCount: stripDetailModel.alarmCount,
            stripCount: stripDetailModel.currentCount,
            usedStripCount: 20,
          ),
        ),
      );
      // TODO ------------ ------------

      // var usedStripCount = 0;
      // if (sharedPreferencesManager.containsKey(sharedKeys)) {
      //   usedStripCount = sharedPreferencesManager.getInt(sharedKeys) ?? 0;
      // } else {
      //   usedStripCount = 0;
      //   await sharedPreferencesManager.setInt(
      //     sharedKeys,
      //     0,
      //   );
      // }

      // _userLocal = profileStorage.getFirst();
      // if (_userLocal != null) {
      //   stripDetailModel = await chronicTrackingRepository.getUserStrip(
      //     _userLocal!.id ?? 0,
      //     _userLocal!.deviceUUID,
      //   );
      //   stripDetailModel.deviceUUID = _userLocal!.deviceUUID!;
      //   stripDetailModel.entegrationId = _userLocal!.id!;
      //   _initCount = stripDetailModel.currentCount;
      //   emit(
      //     StripReminderAddEditCubitState.success(
      //       StripReminderAddEditResult(
      //         alarmCount: stripDetailModel.alarmCount,
      //         stripCount: stripDetailModel.currentCount,
      //         usedStripCount: usedStripCount,
      //       ),
      //     ),
      //   );
      // }
    } catch (e) {
      LoggerUtils.instance.e(e);
    }
  }

  void changeTo(int value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        if (value > 0) {
          emit(
            StripReminderAddEditCubitState.success(
              result.copyWith(
                stripCount: value,
              ),
            ),
          );
        }
      },
    );
  }

  void incrementBy(int value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        final stripCount = result.stripCount + value;
        if (value > 0) {
          emit(
            StripReminderAddEditCubitState.success(
              result.copyWith(
                stripCount: stripCount,
              ),
            ),
          );
        }
      },
    );
  }

  void decrementBy(int value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        var stripCount = result.stripCount;
        if (stripCount - value > 0) {
          stripCount = stripCount - value;
        } else {
          stripCount = 0;
        }
        emit(
          StripReminderAddEditCubitState.success(
            result.copyWith(
              stripCount: stripCount,
            ),
          ),
        );
      },
    );
  }

  void setAlarmCount(int value) {
    final currentState = state;
    currentState.whenOrNull(
      success: (result) {
        emit(
          StripReminderAddEditCubitState.success(
            result.copyWith(
              stripCount: value,
            ),
          ),
        );
      },
    );
  }

  Future<void> saveData(int alarmCount) async {
    final currentState = state;
    await currentState.whenOrNull(
      success: (result) async {
        final diff = _initCount - result.stripCount;
        if (diff > 0) {
          final newUseStripCount =
              (sharedPreferencesManager.getInt(sharedKeys) ?? 0) + diff;
          await sharedPreferencesManager.setInt(
            sharedKeys,
            newUseStripCount,
          );
          result.usedStripCount = newUseStripCount;
        }

        _showSuccessMessage();

        // stripDetailModel.alarmCount = alarmCount;
        // stripDetailModel.currentCount = result.stripCount;
        // stripDetailModel.deviceUUID = _userLocal!.deviceUUID!;
        // stripDetailModel.entegrationId = _userLocal!.id!;

        // await chronicTrackingRepository.updateUserStrip(stripDetailModel);

        // _checkAlarmAndSendNotification(stripDetailModel);
      },
    );
  }

  void _checkAlarmAndSendNotification(
    StripDetailModel stripDetailModel,
  ) {
    if (stripDetailModel.alarmCount >= stripDetailModel.currentCount) {
      localNotificationManager.show(
        LocaleProvider.current.strip_count_low,
        _stripLocaleProviderFetcher(
          stripDetailModel.currentCount.toString(),
        ),
      );
    }
  }

  String _stripLocaleProviderFetcher(String localPvString) {
    return LocaleProvider.current.you_have_strip.replaceFirst(
      LocaleProvider.current.strpCnt,
      localPvString,
    );
  }

  // #region _showSuccessMessage
  void _showSuccessMessage() {
    final currentState = state;
    emit(const StripReminderAddEditCubitState.showSuccessMessage());
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        emit(currentState);
      },
    );
  }
  // #endregion
}
