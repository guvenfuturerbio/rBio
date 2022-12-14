part of 'constants.dart';

class _RegExp {
  final html = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  final url = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
}
