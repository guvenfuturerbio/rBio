class DepartmentModel {
  String name;
  int id;

  DepartmentModel({
    this.name,
    this.id,
  });

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
