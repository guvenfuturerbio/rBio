import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class PersonalInformationScreenVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  String phoneNumber;
  String email;

  bool _showLoadingOverlay = false;
  bool get showLoadingOverlay => _showLoadingOverlay;
  set showLoadingOverlay(bool val) {
    _showLoadingOverlay = val;
    notifyListeners();
  }

  PersonalInformationScreenVm({
    @required this.mContext,
    @required this.phoneNumber,
    @required this.email,
  });

  // serkan.ozturk@guvenfuture.com
  Future<void> updateValues({
    @required String newPhoneNumber,
    @required String newEmail,
  }) async {
    phoneNumber = newPhoneNumber;
    email = newEmail;
    showLoadingOverlay = true;

    try {
      PatientResponse patient = await getIt<Repository>().getPatientDetail();
      ChangeContactInfoRequest changeInfo = ChangeContactInfoRequest();
      changeInfo.patientId = patient.id;
      changeInfo.patientType = int.parse(patient.patientType);
      changeInfo.nationalityId = patient.nationalityId;
      changeInfo.firstName = patient.firstName;
      changeInfo.lastName = patient.lastName;
      changeInfo.gender = patient.gender;
      changeInfo.identityNumber = patient.identityNumber;
      changeInfo.gsm = newPhoneNumber;
      changeInfo.gsmCountryCode = null;
      changeInfo.email = newEmail;
      changeInfo.hasETKApproval = patient.hasETKApproval;
      changeInfo.hasKVKKApproval = patient.hasKVKKApproval;
      changeInfo.passportNumber = patient.passportNumber;
      await getIt<Repository>().updateContactInfo(changeInfo);
      var sharedUserAccount = getIt<UserNotifier>().getUserAccount();
      sharedUserAccount = sharedUserAccount.copyWith(
        phoneNumber: newPhoneNumber,
        electronicMail: newEmail,
      );
      await getIt<UserNotifier>().setUserAccount(sharedUserAccount);
    } catch (e, stackTrace) {
      showDefaultErrorDialog(e, stackTrace);
    } finally {
      showLoadingOverlay = false;
    }
  }

  String getFormattedDate(String date) => date.replaceAll('.', '/');
}
