// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/core.dart';

part 'home_screen_cubit.freezed.dart';
part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final UserManager _userManager;

  HomeScreenCubit({required UserManager userManager})
      : _userManager = userManager,
        super(const HomeScreenState.initial());

  Future<void> getUser() async {
    emit(const HomeScreenState.loadInProgress());
    try {
      await _userManager.getUserProfile();
      emit(const HomeScreenState.success());
    } catch (e) {
      emit(const HomeScreenState.failure());
    }
  }
}
/*isDefault = await getIt<ISharedPreferencesManager>()
          .getBool(SharedPreferencesKeys.IS_DEFAULT_USER); */