class FilterTenantsResponse {
  bool enabled;
  int id;
  String title;

  FilterTenantsResponse({
    this.enabled,
    this.id,
    this.title,
  });

  FilterTenantsResponse.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
