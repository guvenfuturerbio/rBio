import 'dart:convert';

class CountryListResponse {
  List<Country>? countries;

  CountryListResponse({
    this.countries,
  });

  Map<String, dynamic> toMap() {
    return {
      'countries': countries?.map((x) => x.toJson()).toList(),
    };
  }

  factory CountryListResponse.fromMap(Map<String, dynamic> map) {
    return CountryListResponse(
      countries: List<Country>.from(
        map['datum']?.map((x) => Country.fromJson(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryListResponse.fromJson(String source) =>
      CountryListResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CountryList(countries: $countries)';

  @override
  int get hashCode => countries.hashCode;
}

class Country {
  int? id;
  String? name;

  Country({
    this.id,
    this.name,
  });

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
