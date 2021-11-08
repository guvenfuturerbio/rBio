import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/take_appointment/create_appointment/viewmodel/create_appointment_vm.dart';

Column CreateAppoWidget(
    {@required CreateAppointmentVm val,
    @required BuildContext context,
    @required String header,
    @required String hint,
    @required Fields whichField,
    @required LoadingProgress progress,
    @required List<dynamic> itemList}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(header, style: TextStyle(fontSize: 15)),
    ),
    Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: progress == LoadingProgress.LOADING
            ? RbioLoading()
            : DropdownButton<dynamic>(
                isExpanded: true,
                underline: SizedBox(),
                focusColor: Colors.white,
                value: whichField == Fields.BEGIN
                    ? "EYC"
                    : whichField == Fields.DEPARTMENT
                        ? val.dropdownValueDepartment
                        : whichField == Fields.TENANTS
                            ? val.dropdownValueTenant
                            : val.dropdownValueDoctor,
                //elevation: 5,
                style: context.xHeadline5,
                iconEnabledColor: Colors.black,
                items: itemList.map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(
                      whichField == Fields.BEGIN ? value : value.title,
                      style: context.xHeadline5,
                    ),
                  );
                }).toList(),
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
                  }
                },
              ),
      ),
    ),
  ]);
}
