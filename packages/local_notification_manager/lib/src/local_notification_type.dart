import 'package:collection/collection.dart';

enum LocalNotificationType {
  reminder,
}

extension LocalNotificationTypeStringExt on String {
  LocalNotificationType? get xLocalNotificationType =>
      LocalNotificationType.values
          .firstWhereOrNull((element) => element.name == this);
}

extension LocalNotificationTypeExt on LocalNotificationType {
  String get xRawValue => name;
}
