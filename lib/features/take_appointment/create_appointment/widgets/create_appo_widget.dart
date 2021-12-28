import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_vm.dart';

Widget CreateAppoWidget({
  @required CreateAppointmentVm val,
  @required BuildContext context,
  @required String header,
  @required String hint,
  @required Fields whichField,
  @required LoadingProgress progress,
  @required List<dynamic> itemList,
  bool isOnline = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(header, style: TextStyle(fontSize: 15)),
      ),

      //
      AbsorbPointer(
        absorbing: isOnline,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: progress == LoadingProgress.LOADING
                ? RbioLoading()
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
      icon: isOnline ? Icon(Icons.close, size: 0) : null,
      isExpanded: true,
      underline: SizedBox(),
      focusColor: Colors.white,
      value: whichField == Fields.DEPARTMENT
          ? val.dropdownValueDepartment
          : whichField == Fields.TENANTS
              ? val.dropdownValueTenant
              : whichField == Fields.RELATIVE
                  ? val.dropdownValueRelative
                  : val.dropdownValueDoctor,
      style: context.xHeadline5,
      iconEnabledColor: Colors.black,
      items: itemList.map<DropdownMenuItem<dynamic>>(
        (dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(
              whichField == Fields.RELATIVE
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
        if (whichField == Fields.DEPARTMENT) {
          val.departmentSelection(value);
        } else if (whichField == Fields.TENANTS) {
          val.hospitalSelection(value);
        } else if (whichField == Fields.DOCTORS) {
          val.doctorSelection(value);
        } else if (whichField == Fields.RELATIVE) {
          val.relativeSelection(value);
        }
      },
      itemHeight: context.xTextScaleType == TextScaleType.Small ? 50 : 70,
    ),
  );
}
