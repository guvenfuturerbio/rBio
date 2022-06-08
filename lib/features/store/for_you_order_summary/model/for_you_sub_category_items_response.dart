class ForYouSubCategoryItemsResponse {
  int? id;
  String? text;
  String? title;
  String? icon;
  String? price;
  String? url;

  ForYouSubCategoryItemsResponse({
    this.id,
    this.text,
    this.icon,
    this.price,
    this.title,
    this.url,
  });

  ForYouSubCategoryItemsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    text = json['text'] as String?;
    icon = json['icon'] as String?;
    price = json['price'] as String?;
    title = json['title'] as String?;
    url = json['url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['icon'] = icon;
    data['price'] = price;
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}
