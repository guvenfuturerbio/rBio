class RbioUndefinedEndpointException implements Exception {
  final String url;
  RbioUndefinedEndpointException(
    this.url,
  );

  @override
  String toString() => '[RbioUndefinedEndpointException] $url';
}
