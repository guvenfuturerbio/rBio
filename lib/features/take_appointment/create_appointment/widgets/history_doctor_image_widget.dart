import 'package:atom/atom.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/constants/constants.dart';

Column historyDoctorItem(String doctorName, String doctorImageUrl) {
  return Column(
    children: [
      Container(
        width: Atom.width * 0.12,
        child: Image.network(R.image.mockAvatar),
      ),
      Container(
        width: Atom.width * .1,
        child: Text(
          doctorName,
          style: TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),
          maxLines: 1,
        ),
      )
    ],
  );
}