class RbioDisplayException implements Exception {
  final String message;

  RbioDisplayException(this.message);

  @override
  String toString() => message;
}
