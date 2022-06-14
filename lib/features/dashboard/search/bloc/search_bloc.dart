import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../model/search_social_type.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchModel {}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Repository repository;

  var socialTypes = <SearchSocialType>[];
  List<SocialPostsResponse> allSocialList = [];

  SearchBloc(this.repository) : super(const SearchState.initial()) {
    on<SearchFetched>(onFetched);
    on<SearchTextFiltered>(onTextFiltered);
    on<SearchPlatformFiltered>(onPlatformFiltered);
    on<SearchFilterRetrieved>(onFilterRetrieved);
  }

  FutureOr<void> onFetched(
    SearchFetched event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchState.loadInProgress(null));
    try {
      allSocialList = await repository.getAllSocialResources();
      emit(SearchState.success(allSocialList, socialTypes));
    } catch (error, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(error, stackTrace: stackTrace);
      LoggerUtils.instance.e(error);
      emit(const SearchState.failure());
    }
  }

  FutureOr<void> onTextFiltered(
    SearchTextFiltered event,
    Emitter<SearchState> emit,
  ) async {
    if (event.input.length >= 3) {
      emit(SearchState.loadInProgress(socialTypes));
      try {
        final futureList = await Future.wait(
          [
            _fetchResources(event.input),
            _fetchPostsByText(event.input),
          ],
        );
        final searchList = <SearchModel>[];
        searchList.addAll(futureList[0]);
        searchList.addAll(futureList[1]);
        emit(SearchState.success(searchList, socialTypes));
      } catch (error, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(error, stackTrace: stackTrace);
        LoggerUtils.instance.e(error);
        emit(const SearchState.failure());
      }
    } else if (event.input.isEmpty) {
      add(const SearchEvent.fetch());
    }
  }

  FutureOr<void> onPlatformFiltered(
    SearchPlatformFiltered event,
    Emitter<SearchState> emit,
  ) async {
    final currentState = state;
    if (currentState is SearchSuccess) {
      final isContains = socialTypes.contains(event.type);
      if (isContains) {
        socialTypes.remove(event.type);
      } else {
        socialTypes.add(event.type);
      }

      if (socialTypes.isEmpty) {
        emit(
          currentState.copyWith(
            socialTypes: socialTypes,
            list: allSocialList,
          ),
        );
      } else {
        emit(
          currentState.copyWith(
            socialTypes: socialTypes,
          ),
        );
        add(const SearchEvent.filterRetrieved());
      }
    }
  }

  FutureOr<void> onFilterRetrieved(
    SearchFilterRetrieved event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchState.loadInProgress(socialTypes));
    var result = <SearchModel>[];
    for (var item in socialTypes) {
      try {
        var tmpList =
            await repository.getPostWithTagsByPlatform(item.xGetTitle);
        result.addAll(tmpList);
      } catch (error, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(error, stackTrace: stackTrace);
        LoggerUtils.instance.e(error);
        emit(const SearchState.failure());
      }
    }
    emit(SearchState.success(result, socialTypes));
  }

  Future<List<FilterResourcesResponse>> _fetchResources(String text) async {
    return await repository.filterResources(
      FilterResourcesRequest(
        tenantId: null,
        departmentId: null,
        search: text.xTurkishCharacterToEnglish,
        appointmentType: null,
      ),
    );
  }

  Future<List<SocialPostsResponse>> _fetchPostsByText(String text) async {
    return await repository
        .getSocialPostWithTagsByText(text.xTurkishCharacterToEnglish);
  }
}
