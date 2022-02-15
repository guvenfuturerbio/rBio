enum SearchSocialType {
  blog,
  spotify,
  youtube,
}

extension SearchSocialTypeExtension on SearchSocialType {
  String get xGetTitle {
    switch (this) {
      case SearchSocialType.blog:
        return 'Blog';

      case SearchSocialType.spotify:
        return 'Spotify';

      case SearchSocialType.youtube:
        return 'Youtube';
    }
  }
}
