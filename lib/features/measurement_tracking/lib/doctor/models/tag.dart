class Tag {
  String name;
  String icon;
  String color;
  int id;

  Tag({this.name, this.icon, this.color, this.id});

  Tag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    color = json['color'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['color'] = this.color;
    data['id'] = this.id;
    return data;
  }
}