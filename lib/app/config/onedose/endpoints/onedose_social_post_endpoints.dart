part of '../../abstract/app_config.dart';

class OneDoseSocialPostEndpoints extends SocialPostEndpoints {
  @override
  String clickPostPath(int postId) => '/socialpost/clickPost/$postId'.xBaseUrl;

  @override
  String getPostWithTagsByText(String search) =>
      '/socialpost/getPostWithTagsByText/$search'.xBaseUrl;

  @override
  String getPostWithTagsByPlatform(String platform) =>
      '/socialPost/getPostWithTagsByPlatform/$platform'.xBaseUrl;

  @override
  String getAllPosts = '/socialpost/getAllPosts'.xBaseUrl;
}
