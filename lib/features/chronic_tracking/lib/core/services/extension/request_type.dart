part of '../service_shaft.dart';

extension RequestTypeExtension on RequestType {
  String get toStr {
    switch (this) {
      case RequestType.get:
        return 'GET';
      case RequestType.post:
        return 'POST';
      case RequestType.delete:
        return 'DELETE';
      case RequestType.put:
        return 'PUT';
      default:
        throw 'Method Not Found';
    }
  }
}
