class RbioNotListException implements Exception {
  String message;
  RbioNotListException(this.message);

  @override
  String toString() => '[RbioNotListException] : $message';
}
