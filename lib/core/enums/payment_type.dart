enum PaymentType {
  PACKAGE, // online package
  APPOINTMENT, // online appointment
  TEST // covid19 test
}

extension PaymentTypeExtension on PaymentType {
  int get xGetIndex {
    switch (this) {
      case PaymentType.PACKAGE:
        return 0;

      case PaymentType.APPOINTMENT:
        return 1;

      case PaymentType.TEST:
        return 2;

      default:
        return 0;
    }
  }
}

extension PaymentTypeIntExtension on int {
  PaymentType get xGetPaymenType {
    switch (this) {
      case 0:
        return PaymentType.PACKAGE;

      case 1:
        return PaymentType.APPOINTMENT;

      case 2:
        return PaymentType.TEST;

      default:
        return PaymentType.PACKAGE;
    }
  }
}
