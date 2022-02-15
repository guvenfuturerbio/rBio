class BannerTabsModel {
  String? name;
  int? index;
  String? imageUrl;
  String? destinationUrl;
  String? applicationName;
  String? groupName;
  int? id;

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
    name = json['name'] as String?;
    index = json['index'] as int?;
    imageUrl = json['image_url'] as String?;
    destinationUrl = json['destination_url']as String?;
    applicationName = json['application_name']as String?;
    groupName = json['group_name']as String?;
    id = json['id']as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['index'] = index;
    data['image_url'] = imageUrl;
    data['destination_url'] = destinationUrl;
    data['application_name'] = applicationName;
    data['group_name'] = groupName;
    data['id'] = id;
    return data;
  }
}
