part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitial;
  const factory SearchState.loadInProgress() = SearchLoadInProgress;
  const factory SearchState.success(List<SearchModel> list, List<SearchSocialType> socialTypes) = SearchSuccess;
  const factory SearchState.failure() = SearchFailure;
}
