class GetBodyLocationResponse {
  int? id;
  String? name;

  GetBodyLocationResponse({
    this.id,
    this.name,
  });

  GetBodyLocationResponse.fromJson(Map<String, dynamic> json) {
    id = json['ID'] as int?;
    name = json['Name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['Name'] = name;
    return data;
  }
}
