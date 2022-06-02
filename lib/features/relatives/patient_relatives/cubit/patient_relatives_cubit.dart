import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

part 'patient_relatives_cubit.freezed.dart';
part 'patient_relatives_state.dart';

class PatientRelativesCubit extends Cubit<PatientRelativesState> {
  PatientRelativesCubit(this._repository, this._userNotifier,
      this._analyticsManager, this._iSharedPreferencesManager)
      : super(const PatientRelativesState.initial()) {
    identificationNumber = _userNotifier.getUserAccount().identificationNumber;
  }
  String? identificationNumber;
  late final Repository _repository;
  late final UserNotifier _userNotifier;
  late final FirebaseAnalyticsManager _analyticsManager;
  late final ISharedPreferencesManager _iSharedPreferencesManager;

  Future<void> fetchPatientReletives() async {
    emit(const PatientRelativesState.loadInProgress());
    PatientRelativeInfoResponse response;

    try {
      response = await _repository.getAllRelatives();
      if (response.patientRelatives == []) {
        response = PatientRelativeInfoResponse([]);
      }
      response.patientRelatives.removeWhere(
          (PatientRelative element) => element.tcNo == identificationNumber);

      emit(PatientRelativesState.success(response: response));
    } catch (e) {
      emit(const PatientRelativesState.failure());
    }
  }

  Future<void> deletePatientRelative(PatientRelative patientRelative) async {
    try {
      emit(const PatientRelativesState.loadInProgress());
      final response =
          await getIt<Repository>().removePatientRelative(patientRelative.id!);
      var isSuccess = response.datum;
      if (isSuccess) {
        _analyticsManager.logEvent(
          YakinSilmeBasariliEvent(
              '${patientRelative.name!} ${patientRelative.surname!}'),
        );

        fetchPatientReletives();
      } else {
        _analyticsManager.logEvent(
          YakinSilmeHataEvent(
              '${patientRelative.name!} ${patientRelative.surname!}'),
        );
        emit(const PatientRelativesState.failure());
      }
    } catch (error) {
      LoggerUtils.instance.e(error);

      _analyticsManager.logEvent(
        YakinSilmeHataEvent(
            '${patientRelative.name!} ${patientRelative.surname!}'),
      );

      emit(const PatientRelativesState.failure());
    }
  }

  Future<void> changeUserToPatientRelative(
      PatientRelative patientRelativeInfo) async {
    try {
      final response = await _repository.getRelativeRelationships();
      var patientUserRelationships =
          response.datum["patient_user_relationships"];

      for (var pur in patientUserRelationships) {
        if (pur["patient"]["id"].toString() == patientRelativeInfo.id) {
          // Selected relative
          await _repository
              .changeActiveUserToRelative(pur["patient"]["user_id"].toString());

          _analyticsManager.logEvent(YakinDegistirmeBasariliEvent(
              '${patientRelativeInfo.name} ${patientRelativeInfo.surname}'));

          await _iSharedPreferencesManager.setBool(
              SharedPreferencesKeys.isDefaultUser, false);
          _userNotifier.isDefaultUser = false;

          Atom.to(PagePaths.main, isReplacement: true, queryParameters: {});
          return;
        }
      }
      // Navigator.pop(context);
    } catch (error) {
      LoggerUtils.instance.e(error);
      _analyticsManager.logEvent(YakinDegistirmeHataEvent(
          '${patientRelativeInfo.name} ${patientRelativeInfo.surname}'));
    }
  }
}
