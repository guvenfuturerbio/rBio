import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app/config/abstract/app_config.dart';
import '../../../core/locator.dart';
import '../../../core/notifiers/user_notifier.dart';
import '../../../core/packages/atom/src/atom_instance.dart';
import '../../../data/repositories/repository.dart';
import '../../shared/necessary_identity/necessary_identity_screen.dart';
import '../model/visit_request.dart';
import '../model/visit_response.dart';

part 'results_state.dart';
part 'results_cubit.freezed.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit(this.repository) : super(const ResultsState.initial());

  late final Repository repository;

  void setStartDate(DateTime d) {
    final currentState = state;
    currentState.whenOrNull(success: (result) {
      emit(ResultsState.success(result.copyWith(startDate: d)));
    });
  }

  void setEndDate(DateTime d) {
    final currentState = state;
    currentState.whenOrNull(success: (result) {
      emit(ResultsState.success(result.copyWith(endDate: d)));
    });
  }

  void toggleHasResult(bool hasResult) {
    final currentState = state;
    currentState.whenOrNull(success: (result) {
      emit(ResultsState.success(result.copyWith(hasResult: !hasResult)));
    });
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

  VisitRequest get visitRequestBody =>
      _visitRequestBody ??
      VisitRequest(
          isForeignPatient:
              getIt<UserNotifier>().getPatient().nationalityId == 213
                  ? 0
                  : 1, // 213 - Türk
          hasResults: hasResult == false ? 0 : 1,
          identityNumber:
              getIt<UserNotifier>().getPatient().nationalityId == 213
                  ? getIt<UserNotifier>().getPatient().identityNumber
                  : getIt<UserNotifier>().getPatient().passportNumber);

  Future<void> fetchVisits() async {
    emit(const ResultsState.loadInProgress());
    try {
      final visits = await repository.getVisits(visitRequestBody);
      visits.sort((a, b) {
        print('sadasdasdasd232323412412');
        final aOpeningDate = a.openingDate;
        final bOpeningDate = b.openingDate;

        if (aOpeningDate != null && bOpeningDate != null) {
          print('sadasdasdasd23232341241124123122');
          return DateTime.parse(bOpeningDate).compareTo(
            DateTime.parse(aOpeningDate),
          );
        }
        print('sadasdasdasd232323412411241231212312312');
        return -1;
      });
      emit(ResultsState.success(ResultResponse(visits: visits)));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);

      emit(const ResultsState.failure());
    }
  }
}
