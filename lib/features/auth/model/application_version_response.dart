class ApplicationVersionResponse {
  String? minimum;
  String? latest;
  String? name;
  String? releaseNotes;
  String? androidUrl;
  String? iosUrl;

  ApplicationVersionResponse({
    this.minimum,
    this.latest,
    this.name,
    this.releaseNotes,
    this.androidUrl,
    this.iosUrl,
  });

  ApplicationVersionResponse.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'] as String;
    latest = json['latest']as String;
    name = json['name']as String;
    releaseNotes = json['release_notes']as String;
    androidUrl = json['android_url']as String;
    iosUrl = json['ios_url']as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['minumum'] = minimum;
    data['latest'] = latest;
    data['name'] = name;
    data['release_notes'] = releaseNotes;
    data['android_url'] = androidUrl;
    data['ios_url'] = iosUrl;
    return data;
  }
}
