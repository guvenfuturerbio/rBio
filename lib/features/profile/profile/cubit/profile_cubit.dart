import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../auth/auth.dart';
import '../../personal_information/model/change_contact_info_request.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.repository,
    this.userFacade,
    this.userNotifier,
    this.sentryManager,
    this.sharedPreferencesManager,
  ) : super(ProfileState()) {
    bool isTwoFactorAuth = sharedPreferencesManager
            .getBool(SharedPreferencesKeys.isTwoFactorAuth) ??
        false;
    emit(
      state.copyWith(
        isTwoFactorAuth: isTwoFactorAuth,
        status: ProfileStatus.success,
      ),
    );
    userNotifier.setDefaultUser(
      sharedPreferencesManager.getBool(SharedPreferencesKeys.isDefaultUser),
    );
  }

  late final UserFacade userFacade;
  late final Repository repository;
  late final UserNotifier userNotifier;
  late final SentryManager sentryManager;
  late final ISharedPreferencesManager sharedPreferencesManager;

  Future<void> update2FA(bool newValue) async {
    emit(state.copyWith(isLoading: true));

    try {
      PatientResponse? patient = await repository.getPatientDetail();
      var pusulaAccount = userFacade.getPatient();
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
      await repository.updateContactInfo(changeInfo);
      await sharedPreferencesManager.setBool(
        SharedPreferencesKeys.isTwoFactorAuth,
        newValue,
      );
      emit(
        state.copyWith(
          isTwoFactorAuth: newValue,
          isLoading: false,
        ),
      );
    } catch (e, stackTrace) {
      sentryManager.captureException(e, stackTrace: stackTrace);
      emit(
        state.copyWith(
          isLoading: false,
          status: ProfileStatus.showDefaultErrorDialog,
        ),
      );
    }
  }

  Future<void> changeUserToDefault() async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await repository.getRelativeRelationships();
      var userId = response.datum["id"];
      await repository.changeActiveUserToRelative(userId.toString());
      FirebaseAnalyticsManager()
          .logEvent(YakinlarimAnaHesabaGecisBasariliEvent());
      await sharedPreferencesManager.setBool(
          SharedPreferencesKeys.isDefaultUser, true);
      userNotifier.setDefaultUser(true);
      emit(
        state.copyWith(
          status: ProfileStatus.changeUserToDefault,
          isLoading: false,
        ),
      );
    } on Exception {
      FirebaseAnalyticsManager().logEvent(YakinlarimAnaHesapGecisHataEvent());
      emit(
        state.copyWith(
          status: ProfileStatus.showDefaultErrorDialog,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await userNotifier.logout(context);
  }
}
