enum PaymentType {
  package, // online package
  appointment, // online appointment
  test // covid19 test
}

extension PaymentTypeExtension on PaymentType {
  int get xGetIndex {
    switch (this) {
      case PaymentType.package:
        return 0;

      case PaymentType.appointment:
        return 1;

      case PaymentType.test:
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
        return PaymentType.package;

      case 1:
        return PaymentType.appointment;

      case 2:
        return PaymentType.test;

      default:
        return PaymentType.package;
    }
  }
}
