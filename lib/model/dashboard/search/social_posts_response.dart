import '../../../core/core.dart';

class SocialPostsResponse {
  String? title;
  String? text;
  String? url;
  String? periodStart;
  SocialPlatform? socialPlatform;
  List<BlogPostTags>? blogPostTags;
  int? id;
  String? imagePath;

  SocialPostsResponse({
    this.title,
    this.text,
    this.url,
    this.periodStart,
    this.socialPlatform,
    this.blogPostTags,
    this.id,
    this.imagePath,
  });

  SocialPostsResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    text = json['text'] as String?;
    url = json['url'] as String?;
    periodStart = json['period_start'] as String?;
    socialPlatform = json['social_platform'] != null
        ? SocialPlatform.fromJson(
            json['social_platform'] as Map<String, dynamic>,
          )
        : null;
    if (json['blog_post_tags'] != null) {
      blogPostTags = <BlogPostTags>[];
      json['blog_post_tags'].forEach((v) {
        blogPostTags?.add(BlogPostTags.fromJson(v as Map<String, dynamic>));
      });
    }
    id = json['id'] as int?;
    imagePath = fetchImagePaths(socialPlatform?.id ?? 0) as String?;
  }

  fetchImagePaths(int id) {
    switch (id) {
      case 1:
        return R.image.facebook_icon;
      case 2:
        return R.image.twitter_icon;
      case 3:
        return R.image.linkedin_icon;
      case 4:
        return R.image.spotify_icon;
      case 5:
        return R.image.instagram_icon;
      case 6:
        return R.image.default_icon;
      case 7:
        return R.image.youtube_icon;
      case 8:
        return R.image.website_icon;
      default:
        return R.image.default_icon;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['text'] = text;
    data['url'] = url;
    data['period_start'] = periodStart;
    if (socialPlatform != null) {
      data['social_platform'] = socialPlatform?.toJson();
    }
    if (this.blogPostTags != null) {
      data['blog_post_tags'] =
          blogPostTags?.map((v) => v.toJson()).toList() as Map<String, dynamic>;
    }
    data['id'] = id;
    return data;
  }
}

class BlogPostTags {
  SocialPlatform? postTag;
  int? id;

  BlogPostTags({
    this.postTag,
    this.id,
  });

  BlogPostTags.fromJson(Map<String, dynamic> json) {
    postTag = json['post_tag'] != null
        ? SocialPlatform.fromJson(json['post_tag'] as Map<String, dynamic>)
        : null;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (postTag != null) {
      data['post_tag'] = postTag?.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class SocialPlatform {
  String? name;
  int? id;

  SocialPlatform({
    this.name,
    this.id,
  });

  SocialPlatform.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
