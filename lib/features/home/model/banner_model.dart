class BannerTabsModel {
  String name;
  int index;
  String imageUrl;
  String destinationUrl;
  String applicationName;
  String groupName;
  int id;

  BannerTabsModel({
    this.name,
    this.index,
    this.imageUrl,
    this.destinationUrl,
    this.applicationName,
    this.groupName,
    this.id,
  });

  BannerTabsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    index = json['index'];
    imageUrl = json['image_url'];
    destinationUrl = json['destination_url'];
    applicationName = json['application_name'];
    groupName = json['group_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['index'] = this.index;
    data['image_url'] = this.imageUrl;
    data['destination_url'] = this.destinationUrl;
    data['application_name'] = this.applicationName;
    data['group_name'] = this.groupName;
    data['id'] = this.id;
    return data;
  }
}
