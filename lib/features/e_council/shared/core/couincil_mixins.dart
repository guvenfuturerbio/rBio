import 'package:intl/intl.dart';

mixin CouncilCardDateToString {
  String dateToString(DateTime date) {
    return DateFormat('dd.MM.yyyy   hh:mm').format(date);
  }
}
