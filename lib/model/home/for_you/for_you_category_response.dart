import '../../../core/domain/base_model.dart';

class ForYouCategoryResponse extends IBaseModel {
  int id;
  String text;
  String icon;

  ForYouCategoryResponse({
    this.id,
    this.text,
    this.icon,
  });

  ForYouCategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['icon'] = this.icon;
    return data;
  }

  @override
  ForYouCategoryResponse fromJson(Map<String, dynamic> json) =>
      ForYouCategoryResponse.fromJson(json);
}
