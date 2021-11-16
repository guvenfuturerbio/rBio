import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/take_appointment/create_online_appointment/viewmodel/create_online_appointment_screen_vm.dart';

Column CreateOnlineAppoWidget(
    {@required CreateOnlineAppointmentVm val,
    @required BuildContext context,
    @required String header,
    @required String hint,
    @required Fields whichField,
    @required LoadingProgress progress,
    @required bool isOnline,
    @required List<dynamic> itemList}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(header, style: TextStyle(fontSize: 15)),
    ),
    Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: progress == LoadingProgress.LOADING
            ? RbioLoading()
            : DropdownButton<dynamic>(
                icon: isOnline
                    ? Icon(Icons.close, color: getIt<ITheme>().textColor)
                    : null,
                isExpanded: true,
                underline: SizedBox(),
                focusColor: Colors.white,
                value: whichField == Fields.BEGIN
                    ? "EYC"
                    : whichField == Fields.DEPARTMENT
                        ? val.dropdownValueDepartment
                        : whichField == Fields.TENANTS
                            ? LocaleProvider.current.online_appo
                            : val.dropdownValueDoctor,
                style: context.xHeadline2,
                iconEnabledColor: Colors.black,
                items: itemList.map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(
                      whichField == Fields.BEGIN
                          ? value
                          : isOnline
                              ? value
                              : value.title,
                      style: context.xHeadline2.copyWith(
                          color: isOnline
                              ? getIt<ITheme>().mainColor
                              : getIt<ITheme>().textColorSecondary),
                    ),
                  );
                }).toList(),
                hint: isOnline
                    ? null
                    : Text(
                        hint,
                        style: context.xHeadline2,
                      ),
                onChanged: isOnline
                    ? null
                    : (dynamic value) {
                        if (whichField == Fields.DEPARTMENT) {
                          val.departmentSelection(value);
                        } /* else if (whichField == Fields.TENANTS) {
                    val.hospitalSelection(value);
                  }*/
                        else if (whichField == Fields.DOCTORS) {
                          val.doctorSelection(value);
                        }
                      },
              ),
      ),
    ),
  ]);
}
