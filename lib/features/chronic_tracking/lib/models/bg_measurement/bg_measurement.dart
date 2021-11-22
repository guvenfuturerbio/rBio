/*import 'package:flutter/material.dart';

enum HungarState { Empty, Fasting, Before, After }

class BgMeasurement {
  final HungarState hungarState;
  final String date;
  final String level;
  final String note;
  final bool manual;
  String imageURL;
  Color color;
  int tag; // 1 aç 2 tok 3 fasting
  bool isDeleted;
  int time;


  BgMeasurement({
    this.time,
    this.date,
    this.level,
    this.color,
    this.hungarState,
    this.note,
    this.tag,
    this.manual = false,
    this.imageURL = "",
    this.isDeleted
  });

  @override
  String toString() {
    return "date: " +
        date?? "" +
        " result: " +
        level?? "" +
        " notes " +
        note?? "" +
        " hungarState: " +
        hungarState?.toString();
  }
}
*/