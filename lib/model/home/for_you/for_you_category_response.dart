import '../../../core/domain/base_model.dart';

class ForYouCategoryResponse extends IBaseModel<ForYouCategoryResponse> {
  int? id;
  String? text;
  String? icon;

  ForYouCategoryResponse({
    this.id,
    this.text,
    this.icon,
  });

  ForYouCategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    text = json['text'] as String?;
    icon = json['icon'] as String?;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['icon'] = icon;
    return data;
  }

  @override
  ForYouCategoryResponse fromJson(Map<String, dynamic> json) =>
      ForYouCategoryResponse.fromJson(json);
}
