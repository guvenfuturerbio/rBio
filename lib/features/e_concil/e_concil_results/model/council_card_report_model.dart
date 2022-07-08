import 'package:intl/intl.dart';

import '../../shared/core/couincil_mixins.dart';
import '../../shared/model/icouncil_card_model.dart';

class CouncilCardReportModel extends ICouncilCardModel with CouncilCardDateToString {
  final DateTime date;

  const CouncilCardReportModel({
    required super.diagnosis,
    required super.departmentManager,
    required super.title,
    required this.date,
    super.color = 0xFFCAEAD8,
  });

  @override
  String dateToString(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }
}
