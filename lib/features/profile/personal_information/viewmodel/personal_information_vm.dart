import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class PersonalInformationScreenVm extends RbioVm {
  @override
  BuildContext mContext;

  String phoneNumber;
  String email;
  late bool isTwoFactorAuth;

  final AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  AutovalidateMode? get autovalidateMode => _autovalidateMode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? get formKey => _formKey;

  final imagePicker = ImagePicker();

  ImageProvider<Object> get getProfileImage =>
      newProfileFile != null ? FileImage(newProfileFile!) : oldProfileImage;
  late ImageProvider<Object> oldProfileImage;
  File? newProfileFile;

  bool _showLoadingOverlay = false;
  bool get showLoadingOverlay => _showLoadingOverlay;
  set showLoadingOverlay(bool val) {
    _showLoadingOverlay = val;
    notifyListeners();
  }

  PersonalInformationScreenVm({
    required this.mContext,
    required this.phoneNumber,
    required this.email,
  }) {
    oldProfileImage = Utils.instance.getCacheProfileImage;
  }

  // serkan.ozturk@guvenfuture.com
  Future<void> updateValues({
    required String newPhoneNumber,
    required String newEmail,
    required String countryCode,
  }) async {
    phoneNumber = newPhoneNumber;
    email = newEmail;
    showLoadingOverlay = true;

    try {
      var changeInfo = ChangeContactInfoRequest();
      var sharedUserAccount = getIt<UserFacade>().getUserAccount();
      var pusulaAccount = getIt<UserFacade>().getPatient();
      if (pusulaAccount.id != null) {
        changeInfo.gsm = newPhoneNumber;
        changeInfo.gsmCountryCode = countryCode;
        changeInfo.email = newEmail;
        changeInfo.patientId = pusulaAccount.id;
        changeInfo.patientType = int.parse(pusulaAccount.patientType!);
        changeInfo.nationalityId = pusulaAccount.nationalityId;
        changeInfo.hasETKApproval = pusulaAccount.hasETKApproval ?? true;
        changeInfo.hasKVKKApproval = pusulaAccount.hasKVKKApproval ?? true;
        changeInfo.isTwoFactorAuth = getIt<ISharedPreferencesManager>()
                .getBool(SharedPreferencesKeys.isTwoFactorAuth) ??
            false;
        await getIt<Repository>().updateContactInfo(changeInfo);
      } else {
        changeInfo.gsm = newPhoneNumber;
        changeInfo.gsmCountryCode = null;
        changeInfo.email = newEmail;
        changeInfo.isTwoFactorAuth = getIt<ISharedPreferencesManager>()
                .getBool(SharedPreferencesKeys.isTwoFactorAuth) ??
            false;
        await getIt<Repository>().updateContactInfo(changeInfo);
      }

      sharedUserAccount = sharedUserAccount.copyWith(
        phoneNumber: newPhoneNumber,
        electronicMail: newEmail,
      );
      await getIt<UserFacade>().setUserAccount(sharedUserAccount);
      await savePhoto();
      Utils.instance.showSuccessSnackbar(
        mContext,
        LocaleProvider.current.personal_update_success,
      );
      Utils.instance.hideKeyboard(mContext);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
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
    if (imageSource == ImageSource.gallery) {
      if (!await getIt<PermissionManager>().request(
        permission: GalleryPermissionStrategy(
          LocaleProvider.of(actionSheetContext),
          getIt<IAppConfig>(),
        ),
        context: actionSheetContext,
      )) {
        Navigator.of(actionSheetContext).pop();
        return;
      }
    } else {
      if (!await getIt<PermissionManager>().request(
        permission: CameraPermissionStrategy(
          LocaleProvider.of(actionSheetContext),
          getIt<IAppConfig>(),
        ),
        context: actionSheetContext,
      )) {
        Navigator.of(actionSheetContext).pop();
        return;
      }
    }

    Navigator.of(actionSheetContext).pop();
    try {
      final imageFile = await imagePicker.pickImage(
        source: imageSource,
        maxHeight: 1080,
        maxWidth: 1920,
        imageQuality: 50,
      );
      if (imageFile != null) {
        newProfileFile = File(imageFile.path);
        notifyListeners();
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    }
  }

  Future<void> deletePhoto(BuildContext actionSheetContext) async {
    Navigator.of(actionSheetContext).pop();
    showLoadingOverlay = true;

    try {
      final guvenResponse = await getIt<Repository>().deleteProfilePicture();
      if (guvenResponse.xIsSuccessful) {
        oldProfileImage = NetworkImage(R.image.circlevatar);
        newProfileFile = null;
        await getIt<ISharedPreferencesManager>()
            .remove(SharedPreferencesKeys.profileImage);
        notifyListeners();
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      showDefaultErrorDialog(e, stackTrace);
    } finally {
      showLoadingOverlay = false;
    }
  }

  Future<void> savePhoto() async {
    if (newProfileFile == null) return;

    try {
      final guvenResponse =
          await getIt<Repository>().uploadProfilePicture(newProfileFile!);
      if (guvenResponse.xIsSuccessful && guvenResponse.datum != null) {
        await getIt<ISharedPreferencesManager>().setString(
          SharedPreferencesKeys.profileImage,
          guvenResponse.datum,
        );
        oldProfileImage = MemoryImage(base64.decode(guvenResponse.datum));
        newProfileFile = null;
        notifyListeners();
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      showDefaultErrorDialog(e, stackTrace);
    }
  }
}
