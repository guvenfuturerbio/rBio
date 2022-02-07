import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SelectableDay {
  String? name;
  bool selected;
  Day? day;
  int? dayIndex;
  String? shortName;

  SelectableDay({
    this.name,
    required this.selected,
    this.day,
    this.dayIndex,
    this.shortName,
  });
}
