class RbioNotListException implements Exception {
  String message;
  RbioNotListException(this.message);

  @override
  String toString() => '[RbioNotListException] : $message';
}

class RbioNetworkException implements Exception {
  @override
  String toString() => '[RbioNetworkException]';
}

class RbioModelCastException implements Exception {
  final String message;

  RbioModelCastException(this.message);

  @override
  String toString() => message;
}

class RbioDisplayException implements Exception {
  final String message;

  RbioDisplayException(this.message);

  @override
  String toString() => message;
}
