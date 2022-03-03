import '../../model/model.dart';

class RbioNotSuccessfulException<T> implements Exception {
  final String url;
  final T data;

  RbioNotSuccessfulException(this.url, this.data);

  @override
  String toString() => url;
}

extension RbioNotSuccessfulExceptionExt on RbioNotSuccessfulException<dynamic> {
  String get xGetMessage {
    if (data is GuvenResponseModel) {
      return (data as GuvenResponseModel).message ?? '';
    }

    return "";
  }
}
