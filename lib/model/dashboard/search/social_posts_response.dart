import '../../../core/core.dart';

class SocialPostsResponse {
  String title;
  String text;
  String url;
  String periodStart;
  SocialPlatform socialPlatform;
  List<BlogPostTags> blogPostTags;
  int id;
  String imagePath;

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
    title = json['title'];
    text = json['text'];
    url = json['url'];
    periodStart = json['period_start'];
    socialPlatform = json['social_platform'] != null
        ? new SocialPlatform.fromJson(json['social_platform'])
        : null;
    if (json['blog_post_tags'] != null) {
      blogPostTags = <BlogPostTags>[];
      json['blog_post_tags'].forEach((v) {
        blogPostTags.add(new BlogPostTags.fromJson(v));
      });
    }
    id = json['id'];
    imagePath = fetchImagePaths(socialPlatform.id);
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['url'] = this.url;
    data['period_start'] = this.periodStart;
    if (this.socialPlatform != null) {
      data['social_platform'] = this.socialPlatform.toJson();
    }
    if (this.blogPostTags != null) {
      data['blog_post_tags'] =
          this.blogPostTags.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class BlogPostTags {
  SocialPlatform postTag;
  int id;

  BlogPostTags({
    this.postTag,
    this.id,
  });

  BlogPostTags.fromJson(Map<String, dynamic> json) {
    postTag = json['post_tag'] != null
        ? new SocialPlatform.fromJson(json['post_tag'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postTag != null) {
      data['post_tag'] = this.postTag.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class SocialPlatform {
  String name;
  int id;

  SocialPlatform({
    this.name,
    this.id,
  });

  SocialPlatform.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
