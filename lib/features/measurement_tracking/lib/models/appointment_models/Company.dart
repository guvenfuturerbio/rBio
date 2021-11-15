class Company {
  String name;
  double legacyId;
  String taxId;
  String taxOffice;
  String displayName;
  String shortCode;
  int id;

  Company(
      {this.name,
        this.legacyId,
        this.taxId,
        this.taxOffice,
        this.displayName,
        this.shortCode,
        this.id});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    legacyId = json['legacy_id'];
    taxId = json['tax_id'];
    taxOffice = json['tax_office'];
    displayName = json['display_name'];
    shortCode = json['short_code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['legacy_id'] = this.legacyId;
    data['tax_id'] = this.taxId;
    data['tax_office'] = this.taxOffice;
    data['display_name'] = this.displayName;
    data['short_code'] = this.shortCode;
    data['id'] = this.id;
    return data;
  }
}