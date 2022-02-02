class TagModel {
  String? name;
  String? icon;
  String? color;
  int? id;

  TagModel({
    this.name,
    this.icon,
    this.color,
    this.id,
  });

  TagModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    icon = json['icon'] as String?;
    color = json['color'] as String?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['icon'] = icon;
    data['color'] = color;
    data['id'] = id;
    return data;
  }
}
