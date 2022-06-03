part of 'home_screen_cubit.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState.initial() = _Initial;
  const factory HomeScreenState.loadInProgress() = _LoadInProgress;
  const factory HomeScreenState.success() = _Success;
  const factory HomeScreenState.failure() = _Failure;
}
