import 'package:bloc/bloc.dart';

import 'package:onedosehealth/core/core.dart';

import '../../../../model/model.dart';
import '../model/profile_numbers.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    bool isTwoFactorAuth = getIt<ISharedPreferencesManager>()
            .getBool(SharedPreferencesKeys.isTwoFactorAuth) ??
        false;
    emit(
      state.copyWith(
        isTwoFactorAuth: isTwoFactorAuth,
      ),
    );
    getIt<UserNotifier>().isDefaultUser = getIt<ISharedPreferencesManager>()
        .getBool(SharedPreferencesKeys.isDefaultUser);
  }

  ProfileNumbers? numbers;

  Future<void> getNumbers() async {
    try {
      emit(state.copyWith(status: ProfileStatus.loadingProgress));
      await Future.delayed(const Duration(seconds: 1));
      numbers = ProfileNumbers(relatives: 3, followers: 10, subscriptions: 50);
      emit(state.copyWith(status: ProfileStatus.success));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(state.copyWith(status: ProfileStatus.error));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: ProfileStatus.logout));
  }

  Future<void> update2FA(bool newValue) async {
    emit(state.copyWith(isLoading: true));

    try {
      PatientResponse? patient = await getIt<Repository>().getPatientDetail();
      var pusulaAccount = getIt<UserNotifier>().getPatient();
      if (patient == null || patient.patientType == null) return;
      var changeInfo = ChangeContactInfoRequest();
      changeInfo.gsm = patient.gsm;
      changeInfo.gsmCountryCode = patient.gsmCountryCode;
      changeInfo.email = patient.email;
      changeInfo.patientId = pusulaAccount.id;
      changeInfo.patientType = int.parse(pusulaAccount.patientType!);
      changeInfo.nationalityId = pusulaAccount.nationalityId;
      changeInfo.hasETKApproval = pusulaAccount.hasETKApproval ?? true;
      changeInfo.hasKVKKApproval = pusulaAccount.hasKVKKApproval ?? true;
      changeInfo.isTwoFactorAuth = newValue;

      await getIt<Repository>().updateContactInfo(changeInfo);
      await getIt<ISharedPreferencesManager>().setBool(
        SharedPreferencesKeys.isTwoFactorAuth,
        newValue,
      );
      emit(state.copyWith(isTwoFactorAuth: newValue, isLoading: false));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(state.copyWith(
          isLoading: false, status: ProfileStatus.showDefaultErrorDialog));
    }
  }

  Future changeUserToDefault() async {
    emit(state.copyWith(status: ProfileStatus.changeUserToDefault));
  }
}
