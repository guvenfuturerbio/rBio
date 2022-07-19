part of '../../abstract/app_config.dart';

class GuvenSocialPostEndpoints extends SocialPostEndpoints {
  @override
  String clickPostPath(int postId) => '/SocialPost/clickPost/$postId'.xBaseUrl;

  @override
  String getPostWithTagsByText(String search) =>
      '/SocialPost/getPostWithTagsByText/$search'.xBaseUrl;

  @override
  String getPostWithTagsByPlatform(String platform) =>
      throw RbioUndefinedEndpointException("getPostWithTagsByPlatform");

  @override
  String getAllPosts = '/SocialPost/getAllPosts'.xBaseUrl;
}
