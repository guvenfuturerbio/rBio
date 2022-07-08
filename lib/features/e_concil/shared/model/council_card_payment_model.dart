import '../core/couincil_mixins.dart';
import 'icouncil_card_model.dart';

class CouncilCardPaymentModel extends ICouncilCardModel with CouncilCardDateToString {
  final DateTime date;
  final int numberOfDoctorsToAttend;
  final double price;

  const CouncilCardPaymentModel({
    required super.diagnosis,
    required super.departmentManager,
    required super.title,
    required this.date,
    required this.numberOfDoctorsToAttend,
    required this.price,
  });
}
