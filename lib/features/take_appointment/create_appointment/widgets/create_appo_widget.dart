import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
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
          elevation: R.sizes.defaultElevation,
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
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
    child: Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 13, 0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    whichField == Fields.relative
                        ? '${value.name} ${value.surname}'
                        : value.title,
                    style: context.xHeadline5,
                  ),
                  IconButton(
                      onPressed: () {
                        int? index = itemList.indexOf(value);
                        if (whichField == Fields.doctors) {
                          Atom.to(PagePaths.doctorCv, queryParameters: {
                            'tenantId': val.filterResourceResponse?[index]
                                    .tenants?[0].id
                                    .toString() ??
                                '',
                            'doctorNameNoTitle': val
                                    .filterResourceResponse?[index].title
                                    .toString() ??
                                '',
                            'departmentId': val.filterResourceResponse?[index]
                                    .departments?[0].id
                                    .toString() ??
                                '',
                            'resourceId': val.filterResourceResponse?[index].id
                                    .toString() ??
                                '',
                            'doctorName': val
                                    .filterResourceResponse?[index].title
                                    .toString() ??
                                '',
                            'departmentName': val.filterResourceResponse?[index]
                                    .departments?[0].title ??
                                ''
                          });
                        }
                      },
                      icon: Icon(whichField == Fields.doctors
                          ? Icons.remove_red_eye_sharp
                          : null))
                ],
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
    ),
  );
}
