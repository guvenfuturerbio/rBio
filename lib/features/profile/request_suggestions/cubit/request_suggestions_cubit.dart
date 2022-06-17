import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../model/suggestion_request.dart';

part 'request_suggestions_state.dart';
part 'request_suggestions_cubit.freezed.dart';

class RequestSuggestionsCubit extends Cubit<RequestSuggestionsState> {
  RequestSuggestionsCubit(this.repository)
      : super(const RequestSuggestionsState());
  late final Repository repository;

  Future<void> sendSuggestion({required String text}) async {
    if (text == '') return;

    emit(const RequestSuggestionsState(
        status: RequestSuggestionsStatus.loadInProgress));

    try {
      await repository.addSuggestion(
        SuggestionRequest(suggestionText: text),
      );
      emit(const RequestSuggestionsState(
          status: RequestSuggestionsStatus.success));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(const RequestSuggestionsState(
          status: RequestSuggestionsStatus.failure));
    }
  }
}
