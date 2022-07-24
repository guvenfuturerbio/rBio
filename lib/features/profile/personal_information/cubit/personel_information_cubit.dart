import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/core.dart';
import '../model/change_contact_info_request.dart';

part 'personel_information_state.dart';

class PersonelInformationCubit extends Cubit<PersonelInformationState> {
  PersonelInformationCubit({
    required this.repository,
    required this.userFacade,
    required this.sharedPreferencesManager,
    required this.sentryManager,
    required this.email,
    required this.phoneNumber,
    required this.imageManager,
  }) : super(PersonelInformationState());

  String phoneNumber;
  String email;
  late bool isTwoFactorAuth;
  File? newProfileFile;
  late Repository repository;
  late UserFacade userFacade;
  late ISharedPreferencesManager sharedPreferencesManager;
  late SentryManager sentryManager;
  late ImageManager imageManager;

// serkan.ozturk@guvenfuture.com
  Future<void> updateValues({
    required String newPhoneNumber,
    required String newEmail,
    required String countryCode,
  }) async {
    phoneNumber = newPhoneNumber;
    email = newEmail;
    emit(
      state.copyWith(isLoading: true, status: PersonelInformationStatus.inital),
    );

    try {
      var changeInfo = ChangeContactInfoRequest();
      var sharedUserAccount = userFacade.getUserAccount();
      var pusulaAccount = userFacade.getPatient();
      if (pusulaAccount.id != null) {
        changeInfo.gsm = newPhoneNumber;
        changeInfo.gsmCountryCode = countryCode;
        changeInfo.email = newEmail;
        changeInfo.patientId = pusulaAccount.id;
        changeInfo.patientType = int.parse(pusulaAccount.patientType!);
        changeInfo.nationalityId = pusulaAccount.nationalityId;
        changeInfo.hasETKApproval = pusulaAccount.hasETKApproval ?? true;
        changeInfo.hasKVKKApproval = pusulaAccount.hasKVKKApproval ?? true;
        changeInfo.isTwoFactorAuth = sharedPreferencesManager.getBool(SharedPreferencesKeys.isTwoFactorAuth) ?? false;
        await repository.updateContactInfo(changeInfo);
      } else {
        changeInfo.gsm = newPhoneNumber;
        changeInfo.gsmCountryCode = null;
        changeInfo.email = newEmail;
        changeInfo.isTwoFactorAuth = sharedPreferencesManager.getBool(SharedPreferencesKeys.isTwoFactorAuth) ?? false;
        await repository.updateContactInfo(changeInfo);
      }

      sharedUserAccount = sharedUserAccount.copyWith(
        phoneNumber: newPhoneNumber,
        electronicMail: newEmail,
      );
      await userFacade.setUserAccount(sharedUserAccount);
      await savePhoto();
      emit(
        state.copyWith(
          isLoading: false,
          status: PersonelInformationStatus.success,
        ),
      );
    } catch (e, stackTrace) {
      sentryManager.captureException(e, stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: PersonelInformationStatus.errorDialog,
          isLoading: false,
        ),
      );
    }
  }

  void resetValues() {
    newProfileFile = null;
  }

  String getFormattedDate(String date) => date.replaceAll('.', '/');

  Future<void> deletePhoto() async {
    emit(
      state.copyWith(
        status: PersonelInformationStatus.deletePhoto,
        isLoading: true,
      ),
    );
    try {
      final guvenResponse = await repository.deleteProfilePicture();
      if (guvenResponse.xIsSuccessful) {
        newProfileFile = null;
        await sharedPreferencesManager.remove(SharedPreferencesKeys.profileImage);
        emit(
          state.copyWith(
            getProfileImage: NetworkImage(R.image.circlevatar),
            isLoading: false,
          ),
        );
      }
    } catch (e, stackTrace) {
      sentryManager.captureException(e, stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: PersonelInformationStatus.errorDialog,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> savePhoto() async {
    if (newProfileFile == null) return;
    try {
      final guvenResponse = await repository.uploadProfilePicture(newProfileFile!);
      if (guvenResponse.xIsSuccessful && guvenResponse.datum != null) {
        await sharedPreferencesManager.setString(
          SharedPreferencesKeys.profileImage,
          guvenResponse.datum,
        );
        emit(
          state.copyWith(
            getProfileImage: MemoryImage(base64.decode(guvenResponse.datum)),
          ),
        );
        newProfileFile = null;
      }
    } catch (e, stackTrace) {
      sentryManager.captureException(e, stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: PersonelInformationStatus.errorDialog,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> getPhotoFromSource(
    ImageSource imageSource,
  ) async {
    emit(
      state.copyWith(
        status: PersonelInformationStatus.getPhotoFromSource,
        imageSource: imageSource,
      ),
    );
    try {
      final imageFile = await imageManager.pickImage(source: state.imageSource!, maxHeight: 1080, maxWidth: 1920, imageQuality: 50);
      if (imageFile != null) {
        newProfileFile = File(imageFile.path);
        emit(
          state.copyWith(
            getProfileImage: FileImage(newProfileFile!),
          ),
        );
      }
    } catch (e, stackTrace) {
      sentryManager.captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    }
  }
}
