import 'package:atom/atom.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/take_appointment/create_appointment/viewmodel/create_appointment_vm.dart';

import '../../../../core/constants/constants.dart';

Widget historyDoctorItem(BuildContext context, String doctorName,
    CreateAppointmentVm vm, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: GestureDetector(
      onTap: () {
        vm.fillFromFavorites(index);
      },
      child: SizedBox(
        width: Atom.width * .15,
        child: Column(
          children: [
            ClipOval(
              child: Image.network(vm.doctorsImageUrls[index],
                  fit: BoxFit.cover,
                  width: Atom.width * .14,
                  height: Atom.width * .14),
            ),
            Text(
              doctorName,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: context.xHeadline5.copyWith(color: getIt<ITheme>().grey),
            )
          ],
        ),
      ),
    ),
  );
}
