class RbioModelCastException implements Exception {
  final String message;

  RbioModelCastException(this.message);

  @override
  String toString() => message;
}
