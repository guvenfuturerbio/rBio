// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DrawerModel {
  final String title;
  final VoidCallback onTap;
  final String svgPath;

  DrawerModel({
    required this.title,
    required this.onTap,
    required this.svgPath,
  });
}
