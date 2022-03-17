class RbioServerException implements Exception {
  final String url;
  final Object? data;

  RbioServerException(this.url, [this.data]);

  @override
  String toString() => '[RbioServerException]';
}
