import '../../../core/core.dart';

class ForYouSubCategoryDetailResponse extends IBaseModel<ForYouSubCategoryDetailResponse> {
  String text;
  String title;
  String image;
  int id;

  ForYouSubCategoryDetailResponse({
    this.text,
    this.title,
    this.image,
    this.id,
  });

  ForYouSubCategoryDetailResponse.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    title = json['title'];
    image = json['image'];
    id = json['id'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['title'] = this.title;
    data['image'] = this.image;
    data['id'] = this.id;
    return data;
  }

  @override
  ForYouSubCategoryDetailResponse fromJson(Map<String, dynamic> json) {
    return ForYouSubCategoryDetailResponse.fromJson(json);
  }
}
