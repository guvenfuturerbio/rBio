class TranslatorResponse {
  String language;
  String name;
  int id;

  TranslatorResponse({
    this.language,
    this.name,
    this.id,
  });

  TranslatorResponse.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
