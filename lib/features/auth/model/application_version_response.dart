class ApplicationVersionResponse {
  String minimum;
  String latest;
  String name;
  String releaseNotes;
  String androidUrl;
  String iosUrl;

  ApplicationVersionResponse({
    this.minimum,
    this.latest,
    this.name,
    this.releaseNotes,
    this.androidUrl,
    this.iosUrl,
  });

  ApplicationVersionResponse.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    latest = json['latest'];
    name = json['name'];
    releaseNotes = json['release_notes'];
    androidUrl = json['android_url'];
    iosUrl = json['ios_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minumum'] = this.minimum;
    data['latest'] = this.latest;
    data['name'] = this.name;
    data['release_notes'] = this.releaseNotes;
    data['android_url'] = this.androidUrl;
    data['ios_url'] = this.iosUrl;
    return data;
  }
}
