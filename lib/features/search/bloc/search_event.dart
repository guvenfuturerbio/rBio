part of 'search_bloc.dart';

@freezed
abstract class SearchEvent with _$SearchEvent {
  const factory SearchEvent.fetch() = SearchFetched;
  const factory SearchEvent.textFilter(String input) = SearchTextFiltered;
  const factory SearchEvent.platformFilter(SearchSocialType type) = SearchPlatformFiltered;
  const factory SearchEvent.filterRetrieved() = SearchFilterRetrieved;
}
