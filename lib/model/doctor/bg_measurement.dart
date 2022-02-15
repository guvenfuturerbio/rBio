import 'package:flutter/material.dart';

enum HungarState { Empty, Fasting, Before, After }

class BgMeasurement {
  final HungarState? hungarState;
  final String? date;
  final String? result;
  final String? notes;
  final bool? isManual;
  String? imageURL;
  Color? color;
  int? tag; // 1 aç 2 tok 3 fasting
  bool? isDeleted;
  int? id;

  BgMeasurement({
    this.id,
    this.date,
    this.result,
    this.color,
    this.hungarState,
    this.notes,
    this.tag,
    this.isManual = false,
    this.imageURL = "",
    this.isDeleted,
  });

  @override
  String toString() {
    return "date: $date result: $result notes $notes hungarState: $hungarState";
  }
}
