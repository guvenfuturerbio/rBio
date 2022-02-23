import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/search/bloc/search_bloc.dart';
import 'package:onedosehealth/features/search/model/search_social_type.dart';
import 'package:onedosehealth/model/dashboard/search/social_posts_response.dart';
import 'package:onedosehealth/model/shared/filter_resources_request.dart';
import 'package:onedosehealth/model/shared/filter_resources_response.dart';

class MockUserManager extends Mock implements UserManager {}

class MockRepository extends Mock implements Repository {}

void main() {
  group('[SearchBloc]', () {
    late UserManager userManager;
    late Repository repository;

    late List<SocialPostsResponse> mockSocialPosts;
    late List<FilterResourcesResponse> mockFilterResources;
    late String filterText = "ABC";

    var socialTypes = <SearchSocialType>[];

    setUpAll(() {
      //
    });

    setUp(() {
      mockSocialPosts = [
        SocialPostsResponse(
          id: 1,
          blogPostTags: [],
          imagePath: 'imagePath',
          periodStart: 'periodStart',
          socialPlatform: null,
          text: 'text',
          title: 'title',
          url: 'url',
        ),
      ];
      mockFilterResources = [
        FilterResourcesResponse(),
        FilterResourcesResponse(),
        FilterResourcesResponse(),
        FilterResourcesResponse(),
      ];

      userManager = MockUserManager();
      repository = MockRepository();

      when(
        () => userManager.getAllSocialResources(),
      ).thenAnswer((_) async => mockSocialPosts);

      when(
        () => userManager.getSocialPostWithTagsByText(filterText),
      ).thenAnswer((_) async => mockSocialPosts);

      when(
        () => userManager
            .getPostsWithByTagsByPlatform(SearchSocialType.spotify.xGetTitle),
      ).thenAnswer((_) async => mockSocialPosts);

      when(
        () => repository.filterResources(
          FilterResourcesRequest(
            tenantId: null,
            departmentId: null,
            search: filterText.xTurkishCharacterToEnglish,
            appointmentType: null,
          ),
        ),
      ).thenAnswer((_) async => mockFilterResources);
    });

    tearDownAll(() {
      //
    });

    tearDown(() {
      //
    });

    SearchBloc buildBloc() => SearchBloc(userManager, repository);

    test('constructor called initial state', () {
      expect(
        buildBloc().state,
        equals(const SearchState.initial()),
      );
    });

    blocTest<SearchBloc, SearchState>(
      'when search fetched, initial items loaded',
      build: buildBloc,
      act: (bloc) => bloc.add(const SearchEvent.fetch()),
      expect: () => <SearchState>[
        const SearchState.loadInProgress(null),
        SearchState.success(mockSocialPosts, socialTypes),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'when search textFilter, return SearchModel list',
      build: buildBloc,
      act: (bloc) => bloc.add(SearchEvent.textFilter(filterText)),
      expect: () => <SearchState>[
        const SearchState.loadInProgress([]),
        SearchState.success([
          ...mockFilterResources,
          ...mockSocialPosts,
        ], socialTypes),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'when search textFilter is empty, return items state',
      build: buildBloc,
      act: (bloc) => bloc.add(const SearchEvent.textFilter("")),
      expect: () => <SearchState>[
        const SearchState.loadInProgress(null),
        SearchState.success(mockSocialPosts, socialTypes),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'when platform filtered, ',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const SearchEvent.platformFilter(SearchSocialType.spotify)),
      seed: () => SearchState.success([
        ...mockFilterResources,
        ...mockSocialPosts,
      ], socialTypes),
      expect: () => <SearchState>[
        SearchState.success([
          ...mockFilterResources,
          ...mockSocialPosts,
        ], [
          SearchSocialType.spotify
        ]),
        const SearchState.loadInProgress([SearchSocialType.spotify]),
        SearchState.success(mockSocialPosts, [SearchSocialType.spotify]),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'when filter retrieved, ',
      build: buildBloc,
      act: (bloc) => bloc.add(const SearchEvent.filterRetrieved()),
      expect: () => <SearchState>[
        const SearchState.loadInProgress([]),
        const SearchState.success([], []),
      ],
    );
  });
}
