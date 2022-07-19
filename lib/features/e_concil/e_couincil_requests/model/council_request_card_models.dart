import 'package:onedosehealth/features/e_concil/shared/core/couincil_mixins.dart';

import '../../shared/model/icouncil_card_model.dart';

/// Odeme Bekleniyor Kart Modeli
class CouncilCardPendingPaymentModel extends ICouncilCardModel with CouncilCardDateToString {
  final DateTime date;
  final double price;

  CouncilCardPendingPaymentModel({
    required super.diagnosis,
    required super.departmentManager,
    required super.title,
    required this.date,
    required this.price,
    super.color = 0xFFFFCD00,
  });
}

/// Tetkik Bekleniyor Kart Modeli
class CouncilCardPendingInspectionModel extends ICouncilCardModel {
  final String expectedInspection;

  CouncilCardPendingInspectionModel({
    required super.diagnosis,
    required super.departmentManager,
    required super.title,
    required this.expectedInspection,
    super.color = 0xFF5CD2FF,
  });
}

/// Reddedilen Kart Modeli
class CouncilCardRejectedModel extends ICouncilCardModel {
  final String note;

  CouncilCardRejectedModel({
    required super.diagnosis,
    required super.departmentManager,
    required super.title,
    required this.note,
    super.color = 0xFFD93832,
  });
}

/// Onay Bekleniyor Kart Modeli
class CouncilCardPendingApprovalModel extends ICouncilCardModel with CouncilCardDateToString {
  final String date;
  final String councilConnectionUrl;

  CouncilCardPendingApprovalModel({
    required super.diagnosis,
    required super.departmentManager,
    required super.title,
    this.date = '--------------------',
    this.councilConnectionUrl = '--------------------',
    super.color = 0xFF787878,
  });
}

/// Konsey Randevusu Kart Modeli
class CouncilCardAppoitmentModel extends ICouncilCardModel with CouncilCardDateToString {
  final DateTime date;
  final String councilConnectionUrl;

  CouncilCardAppoitmentModel({
    required super.diagnosis,
    required super.departmentManager,
    required super.title,
    required this.date,
    required this.councilConnectionUrl,
    super.color = 0xFF00A147,
  });
}
