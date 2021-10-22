class ForYouSubCategoryItemsResponse {
  int id;
  String text;
  String title;
  String icon;
  String price;
  String url;

  ForYouSubCategoryItemsResponse({
    this.id,
    this.text,
    this.icon,
    this.price,
    this.title,
    this.url,
  });

  ForYouSubCategoryItemsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    icon = json['icon'];
    price = json['price'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
