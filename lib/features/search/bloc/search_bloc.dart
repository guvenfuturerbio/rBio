import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import '../model/search_social_type.dart';
import '../search_vm.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UserManager userManager;

  var socialTypes = <SearchSocialType>[];

  SearchBloc(this.userManager) : super(const SearchState.initial()) {
    on<SearchFetched>(onFetched);
    on<SearchTextFiltered>(onTextFiltered);
    on<SearchPlatformFiltered>(onPlatformFiltered);
    on<SearchFilterRetrieved>(onFilterRetrieved);
  }

  FutureOr<void> onFetched(
    SearchFetched event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchState.loadInProgress());
    try {
      final result = await userManager.getAllSocialResources();
      emit(SearchState.success(result, socialTypes));
    } catch (error) {
      LoggerUtils.instance.e(error);
      emit(const SearchState.failure());
    }
  }

  FutureOr<void> onTextFiltered(
    SearchTextFiltered event,
    Emitter<SearchState> emit,
  ) async {
    if (event.input.length >= 3) {
      emit(const SearchState.loadInProgress());
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
      } catch (error) {
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
      emit(currentState.copyWith(socialTypes: socialTypes));
      add(const SearchEvent.filterRetrieved());
    }
  }

  FutureOr<void> onFilterRetrieved(
    SearchFilterRetrieved event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchState.loadInProgress());
    var result = <SearchModel>[];
    for (var item in socialTypes) {
      try {
        var tmpList =
            await userManager.getPostsWithByTagsByPlatform(item.xGetTitle);
        result.addAll(tmpList);
      } catch (error) {
        LoggerUtils.instance.e(error);
        emit(const SearchState.failure());
      }
    }
    emit(SearchState.success(result, socialTypes));
  }

  Future<List<FilterResourcesResponse>> _fetchResources(String text) async {
    return await getIt<Repository>().filterResources(
      FilterResourcesRequest(
        tenantId: null,
        departmentId: null,
        search: text.xTurkishCharacterToEnglish,
        appointmentType: null,
      ),
    );
  }

  Future<List<SocialPostsResponse>> _fetchPostsByText(String text) async {
    return await userManager
        .getSocialPostWithTagsByText(text.xTurkishCharacterToEnglish);
  }
}
