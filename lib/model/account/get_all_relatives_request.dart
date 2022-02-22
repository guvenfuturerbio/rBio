class GetAllRelativesRequest {
  int? draw;
  int? start;
  String? length;
  List<ColumnsObject>? columns;
  List<OrderObject>? order;
  SearchObject? search;

  GetAllRelativesRequest({
    this.draw,
    this.start,
    this.length,
    this.columns,
    this.order,
    this.search,
  });

  factory GetAllRelativesRequest.fromJson(Map<String, dynamic> json) =>
      GetAllRelativesRequest(
        draw: json['draw'] as int?,
        start: json['start'] as int?,
        length: json['length'] as String?,
        columns: (json['columns'] as List<dynamic>)
            .map((e) => ColumnsObject.fromJson(e as Map<String, dynamic>))
            .toList(),
        order: (json['order'] as List<dynamic>)
            .map((e) => OrderObject.fromJson(e as Map<String, dynamic>))
            .toList(),
        search: SearchObject.fromJson(json['search'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'draw': draw,
        'start': start,
        'length': length,
        'columns': columns,
        'order': order,
        'search': search,
      };
}

class ColumnsObject {
  String? data;
  String? name;
  bool? orderable;
  SearchObject? search;
  bool? searchable;

  ColumnsObject({
    this.data,
    this.name,
    this.orderable,
    this.search,
  });

  factory ColumnsObject.fromJson(Map<String, dynamic> json) => ColumnsObject(
        data: json['data'] as String?,
        name: json['name'] as String?,
        orderable: json['orderable'] as bool?,
        search: SearchObject.fromJson(json['search'] as Map<String, dynamic>),
      )..searchable = json['searchable'] as bool?;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'name': name,
        'orderable': orderable,
        'search': search,
        'searchable': searchable,
      };
}

class OrderObject {
  int? column;
  String? dir;

  OrderObject({
    this.column,
    this.dir,
  });

  factory OrderObject.fromJson(Map<String, dynamic> json) => OrderObject(
        column: json['column'] as int?,
        dir: json['dir'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'column': column,
        'dir': dir,
      };
}

class SearchObject {
  String? value;
  bool? regex;

  SearchObject({
    this.value,
    this.regex,
  });

  factory SearchObject.fromJson(Map<String, dynamic> json) => SearchObject(
        value: json['value'] as String?,
        regex: json['regex'] as bool?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'value': value,
        'regex': regex,
      };
}
