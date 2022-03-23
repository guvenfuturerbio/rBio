class ApplicationVersionResponse {
  String? name;
  String? latest;
  String? minimum;
  String? releaseNotes;
  String? androidUrl;
  String? iosUrl;
  int? id;

  ApplicationVersionResponse({
    this.minimum,
    this.latest,
    this.name,
    this.releaseNotes,
    this.androidUrl,
    this.iosUrl,
    this.id,
  });

  ApplicationVersionResponse.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'] as String?;
    latest = json['latest'] as String?;
    name = json['name'] as String?;
    releaseNotes = json['release_notes'] as String?;
    androidUrl = json['android_url'] as String?;
    iosUrl = json['ios_url'] as String?;
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minumum'] = minimum;
    data['latest'] = latest;
    data['name'] = name;
    data['release_notes'] = releaseNotes;
    data['android_url'] = androidUrl;
    data['ios_url'] = iosUrl;
    data['id'] = id;
    return data;
  }
}
