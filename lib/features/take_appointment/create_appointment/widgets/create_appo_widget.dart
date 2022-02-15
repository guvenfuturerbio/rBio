import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_vm.dart';

Widget createAppoWidget({
  required CreateAppointmentVm val,
  required BuildContext context,
  required String header,
  required String hint,
  required Fields whichField,
  required LoadingProgress progress,
  required List<dynamic> itemList,
  bool isOnline = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(header, style: const TextStyle(fontSize: 15)),
      ),

      //
      AbsorbPointer(
        absorbing: isOnline,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: progress == LoadingProgress.loading
                ? const RbioLoading()
                : _buildDropdown(
                    isOnline, whichField, val, context, itemList, hint),
          ),
        ),
      ),
    ],
  );
}

Widget _buildDropdown(
  bool isOnline,
  Fields whichField,
  CreateAppointmentVm val,
  BuildContext context,
  List<dynamic> itemList,
  String hint,
) {
  return Center(
    child: DropdownButton<dynamic>(
      icon: isOnline ? const Icon(Icons.close, size: 0) : null,
      isExpanded: true,
      underline: const SizedBox(),
      focusColor: Colors.white,
      value: whichField == Fields.department
          ? val.dropdownValueDepartment
          : whichField == Fields.tenant
              ? val.dropdownValueTenant
              : whichField == Fields.relative
                  ? val.dropdownValueRelative
                  : val.dropdownValueDoctor,
      style: context.xHeadline5,
      iconEnabledColor: Colors.black,
      items: itemList.map<DropdownMenuItem<dynamic>>(
        (dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(
              whichField == Fields.relative
                  ? '${value.name} ${value.surname}'
                  : value.title,
              style: context.xHeadline5,
            ),
          );
        },
      ).toList(),
      hint: Text(
        hint,
        style: context.xHeadline5,
      ),
      onChanged: (dynamic value) {
        if (whichField == Fields.department) {
          val.departmentSelection(value);
        } else if (whichField == Fields.tenant) {
          val.hospitalSelection(value);
        } else if (whichField == Fields.doctors) {
          val.doctorSelection(value);
        } else if (whichField == Fields.relative) {
          val.relativeSelection(value);
        }
      },
      itemHeight: context.xTextScaleType == TextScaleType.small ? 50 : 70,
    ),
  );
}
