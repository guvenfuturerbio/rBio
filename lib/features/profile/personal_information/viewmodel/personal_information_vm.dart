import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class PersonalInformationScreenVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  String phoneNumber;
  String email;

  final imagePicker = ImagePicker();

  ImageProvider<Object> get getProfileImage =>
      newProfileFile != null ? FileImage(newProfileFile) : oldProfileImage;
  ImageProvider<Object> oldProfileImage;
  File newProfileFile;

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
  }) {
    oldProfileImage = Utils.instance.getCacheProfileImage;
  }

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
      await savePhoto();
    } catch (e, stackTrace) {
      showDefaultErrorDialog(e, stackTrace);
    } finally {
      showLoadingOverlay = false;
    }
  }

  void resetValues() {
    newProfileFile = null;
    notifyListeners();
  }

  String getFormattedDate(String date) => date.replaceAll('.', '/');

  Future<void> getPhotoFromSource(
    BuildContext actionSheetContext,
    ImageSource imageSource,
  ) async {
    Navigator.of(actionSheetContext).pop();
    final imageFile = await imagePicker.getImage(source: imageSource);
    if (imageFile != null) {
      newProfileFile = File(imageFile.path);
      notifyListeners();
    }
  }

  Future<void> deletePhoto(BuildContext actionSheetContext) async {
    Navigator.of(actionSheetContext).pop();
    showLoadingOverlay = true;

    try {
      final guvenResponse = await getIt<Repository>().deleteProfilePicture();
      if (guvenResponse.isSuccessful) {
        oldProfileImage = NetworkImage(R.image.circlevatar);
        newProfileFile = null;
        await getIt<ISharedPreferencesManager>()
            .remove(SharedPreferencesKeys.PROFILE_IMAGE);
        notifyListeners();
      }
    } catch (e, stackTrace) {
      showDefaultErrorDialog(e, stackTrace);
    } finally {
      showLoadingOverlay = false;
    }
  }

  Future<void> savePhoto() async {
    if (newProfileFile == null) return;

    try {
      final guvenResponse =
          await getIt<Repository>().uploadProfilePicture(newProfileFile);
      if (guvenResponse.isSuccessful && guvenResponse.datum != null) {
        await getIt<ISharedPreferencesManager>().setString(
          SharedPreferencesKeys.PROFILE_IMAGE,
          guvenResponse.datum,
        );
        oldProfileImage = MemoryImage(base64.decode(guvenResponse.datum));
        newProfileFile = null;
        notifyListeners();
      }
    } catch (e, stackTrace) {
      showDefaultErrorDialog(e, stackTrace);
    }
  }
}
