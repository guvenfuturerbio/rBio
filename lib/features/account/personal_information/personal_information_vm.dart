import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class PersonalInformationScreenVm extends ChangeNotifier {
  BuildContext mContext;

  PersonalInformationScreenVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  Future<void> showUpdatePhoneNumberDialog(
      TextEditingController controller) async {
    Get.defaultDialog(
      title: "Update your phone number",
      titleStyle: TextStyle(color: R.color.blue),
      content: SingleChildScrollView(
          child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: controller,
        decoration: InputDecoration(labelText: 'New phone number'),
        textCapitalization: TextCapitalization.none,
      )),
      actions: <Widget>[
        TextButton(
          child: Text('Update', style: TextStyle(color: R.color.blue)),
          onPressed: () async {
            try {
              PatientResponse patient =
                  await getIt<Repository>().getPatientDetail();
              ChangeContactInfoRequest changeInfo = ChangeContactInfoRequest();
              changeInfo.patientId = patient.id;
              //changeInfo.patientType = patient.patientType;
              changeInfo.nationalityId = patient.nationalityId;
              changeInfo.firstName = patient.firstName;
              changeInfo.lastName = patient.lastName;
              changeInfo.gender = patient.gender;
              changeInfo.identityNumber = patient.identityNumber;
              changeInfo.gsm = controller.value.text;
              changeInfo.gsmCountryCode = null;
              changeInfo.email = patient.email;
              changeInfo.hasETKApproval = patient.hasETKApproval;
              changeInfo.hasKVKKApproval = patient.hasKVKKApproval;
              changeInfo.passportNumber = patient.passportNumber;
              await getIt<Repository>().updateContactInfo(changeInfo);
            } catch (error) {
              Future.delayed(const Duration(milliseconds: 500), () {
                showGradientDialog(
                  this.mContext,
                  LocaleProvider.of(this.mContext).warning,
                  error.toString() == "network"
                      ? LocaleProvider.of(this.mContext).no_network_connection
                      : LocaleProvider.of(this.mContext).sorry_dont_transaction,
                );
              });
            }
            Navigator.of(this.mContext).pop();
          },
        ),
      ],
    );
  }

  Future<void> showUpdateEmailDialog(TextEditingController controller) async {
    Get.defaultDialog(
      title: "Update your email",
      titleStyle: TextStyle(color: R.color.blue),
      content: SingleChildScrollView(
          child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: controller,
        decoration: InputDecoration(labelText: 'New Email'),
        textCapitalization: TextCapitalization.none,
      )),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Update',
            style: TextStyle(color: R.color.blue),
          ),
          onPressed: () async {
            try {
              PatientResponse patient =
                  await getIt<Repository>().getPatientDetail();
              ChangeContactInfoRequest changeInfo = ChangeContactInfoRequest();
              changeInfo.patientId = patient.id;
              //changeInfo.patientType = patient.patientType;
              changeInfo.nationalityId = patient.nationalityId;
              changeInfo.firstName = patient.firstName;
              changeInfo.lastName = patient.lastName;
              changeInfo.gender = patient.gender;
              changeInfo.identityNumber = patient.identityNumber;
              changeInfo.gsm = patient.gsm;
              changeInfo.gsmCountryCode = null;
              changeInfo.email = controller.value.text;
              changeInfo.hasETKApproval = patient.hasETKApproval;
              changeInfo.hasKVKKApproval = patient.hasKVKKApproval;
              changeInfo.passportNumber = patient.passportNumber;
              await getIt<Repository>().updateContactInfo(changeInfo);
            } catch (error) {
              Future.delayed(const Duration(milliseconds: 500), () {
                showGradientDialog(
                  this.mContext,
                  LocaleProvider.of(this.mContext).warning,
                  error.toString() == "network"
                      ? LocaleProvider.of(this.mContext).no_network_connection
                      : LocaleProvider.of(this.mContext).sorry_dont_transaction,
                );
              });
            }
            Navigator.of(this.mContext).pop();
          },
        ),
      ],
    );
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(
      title: LocaleProvider.of(context).lbl_personal_information,
    );
  }

  String getFormattedDate(String date) => date.replaceAll('.', '/');
}
