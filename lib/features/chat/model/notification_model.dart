class NotificationModel {
  String? title;
  String? body;

  NotificationModel({this.title, this.body});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    body = json['body'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
