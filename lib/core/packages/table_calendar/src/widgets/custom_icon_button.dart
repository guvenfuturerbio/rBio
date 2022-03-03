// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.margin = const EdgeInsets.all(12.0),
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
        child: Padding(
          padding: padding,
          child: icon,
        ),
      ),
    );
  }
}
