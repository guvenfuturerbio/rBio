import '../../../../core/core.dart';

class ForYouSubCategoryDetailResponse
    extends IBaseModel<ForYouSubCategoryDetailResponse> {
  String? text;
  String? title;
  String? image;
  int? id;

  ForYouSubCategoryDetailResponse({
    this.text,
    this.title,
    this.image,
    this.id,
  });

  ForYouSubCategoryDetailResponse.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
    title = json['title'] as String?;
    image = json['image'] as String?;
    id = json['id'] as int?;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['title'] = title;
    data['image'] = image;
    data['id'] = id;
    return data;
  }

  @override
  ForYouSubCategoryDetailResponse fromJson(Map<String, dynamic> json) {
    return ForYouSubCategoryDetailResponse.fromJson(json);
  }
}
