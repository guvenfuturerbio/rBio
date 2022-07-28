part of 'resources.dart';

class _RegExp {
  final html = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  final url = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
  final email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final filterText = FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'));
  final filterText2 = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\t\r]'));
  final filterText3 = FilteringTextInputFormatter.allow(RegExp('[0-9.,]'));
  final filterText4 = FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'));
}
