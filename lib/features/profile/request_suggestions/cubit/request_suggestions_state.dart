part of 'request_suggestions_cubit.dart';

enum RequestSuggestionsStatus {
  initial,
  loadInProgress,
  success,
  failure,
}

@freezed
class RequestSuggestionsState with _$RequestSuggestionsState {
  const factory RequestSuggestionsState({
    @Default(RequestSuggestionsStatus.initial) RequestSuggestionsStatus status,
  }) = _RequestSuggestionsState;
}
