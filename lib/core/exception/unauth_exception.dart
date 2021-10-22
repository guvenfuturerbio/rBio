class UnAuthException implements Exception {
  final message = '401';

  @override
  String toString() => message;
}
