class DrugResultModel {
  String name;
  int id;

  DrugResultModel({
    this.name,
    this.id,
  });

  factory DrugResultModel.fromJson(Map<String, dynamic> json) => DrugResultModel(
        name: json['name'] as String,
        id: json['id'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'id': id,
      };
}
