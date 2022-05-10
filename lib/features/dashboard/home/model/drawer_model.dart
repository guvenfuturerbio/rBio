import 'package:flutter/material.dart';

class DrawerModel {
  final String title;
  final VoidCallback onTap;

  DrawerModel({
    required this.title,
    required this.onTap,
  });
}
