import 'package:bloc/bloc.dart';

import '../../../core/core.dart';
import '../../shared/necessary_identity/necessary_identity_screen.dart';
import '../model/visit_request.dart';
import '../model/visit_response.dart';

part 'results_state.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit(this.repository) : super(ResultsState()) {
    if (getIt<UserNotifier>().canAccessHospital()) {
      fetchVisits();
    } else {
      showNecessary();
    }
  }

  late final Repository repository;

  Future<void> fetchVisits() async {
    final currentState = state;
    emit(currentState.copyWith(status: RbioLoadingProgress.loadInProgress));
    try {
      final visits = await repository.getVisits(
        _visitRequestBody(currentState.startDate, currentState.endDate),
      );
      visits.sort((a, b) {
        final aOpeningDate = a.openingDate;
        final bOpeningDate = b.openingDate;
        if (aOpeningDate != null && bOpeningDate != null) {
          return DateTime.parse(bOpeningDate).compareTo(
            DateTime.parse(aOpeningDate),
          );
        }
        return -1;
      });
      emit(
        currentState.copyWith(
          visits: visits,
          status: RbioLoadingProgress.success,
        ),
      );
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(currentState.copyWith(status: RbioLoadingProgress.failure));
    }
  }

  void setStartDate(DateTime value) {
    final currentState = state;
    emit(currentState.copyWith(startDate: value));
    fetchVisits();
  }

  void setEndDate(DateTime value) {
    final currentState = state;
    emit(currentState.copyWith(endDate: value));
    fetchVisits();
  }

  Future<void> showNecessary() async {
    final result = await Atom.show(
      const NecessaryIdentityScreen(),
      barrierDismissible: false,
    );

    if ((result ?? false) == true) {
      fetchVisits();
    } else {
      Atom.historyBack();
    }
  }

  final bool _hasResult = true;
  VisitRequest _visitRequestBody(DateTime startDate, DateTime endDate) =>
      VisitRequest(
        from: startDate.toString(),
        to: endDate.toString(),
        isForeignPatient:
            getIt<UserNotifier>().getPatient().nationalityId == 213
                ? 0
                : 1, // 213 - Türk
        hasResults: _hasResult == false ? 0 : 1,
        identityNumber: getIt<UserNotifier>().getPatient().nationalityId == 213
            ? getIt<UserNotifier>().getPatient().identityNumber
            : getIt<UserNotifier>().getPatient().passportNumber,
      );
}
