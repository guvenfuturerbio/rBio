class DiabetType {
  String? name;
  int? id;

  DiabetType({
    this.name,
    this.id,
  });

  DiabetType.fromJson(Map<String, dynamic> json) {
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
