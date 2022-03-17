class RbioNetworkException implements Exception {
  final String url;

  RbioNetworkException(this.url);

  @override
  String toString() => '[RbioNetworkException] - $url';
}
