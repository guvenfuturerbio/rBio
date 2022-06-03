import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class AddPatientRelativesScreenVm extends RbioVm {
  @override
  BuildContext mContext;

  AddPatientRelativesScreenVm(this.mContext) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await getCountries();
    });
  }

  LoadingDialog? loadingDialog;
  LoadingProgress status = LoadingProgress.loading;

  late CountryListResponse countryList;
  DateTime? selectedDate;

  List<String> genderList = ["E", "K"];
  int selectedGender = 1;

  Country selectedCountry = Country(id: 213, name: "Türkiye");
  void setSelectedCountry(Country country) {
    selectedCountry = country;
    notifyListeners();
  }

  String? gender;
  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  Future<void> getCountries() async {
    try {
      final response = await getIt<Repository>().getCountries();
      countryList = CountryListResponse.fromMap(response.toJson());
      status = LoadingProgress.done;
      notifyListeners();
    } catch (error) {
      status = LoadingProgress.error;
    }
  }

  void changeGender(int gender) {
    selectedGender = gender;
    notifyListeners();
  }

  Future savePatientRelative(
    AddPatientRelativeRequest userRegistrationStep1,
    BuildContext context,
  ) async {
    try {
      showLoadingDialog(context);
      final response = await getIt<Repository>()
          .addNewPatientRelative(userRegistrationStep1);
      hideDialog(context);
      String responseMessage = response.message.toString();
      if (response.datum == 0) {
        getIt<IAppConfig>().platform.adjustManager?.trackEvent(SuccessfulRelativeAddEvent());
        getIt<FirebaseAnalyticsManager>()
            .logEvent(YakinEklemeBasariliEvent(response.datum));
        showInfoDialog(
          LocaleProvider.of(context).success_message_title,
          LocaleProvider.of(context).existing_relative_add,
        );
      } else if (response.datum == 1) {
        getIt<IAppConfig>().platform.adjustManager?.trackEvent(SuccessfulRelativeAddEvent());
        getIt<FirebaseAnalyticsManager>()
            .logEvent(YakinEklemeBasariliEvent(response.datum));
        showInfoDialog(
          LocaleProvider.of(context).success_message_title,
          LocaleProvider.of(context).add_new_relative,
        );
      } else {
        getIt<IAppConfig>().platform.adjustManager?.trackEvent(SuccessfulRelativeAddEvent());
        getIt<FirebaseAnalyticsManager>()
            .logEvent(YakinEklemeBasariliEvent(response.datum));
        showInfoDialog(
          LocaleProvider.of(context).warning,
          responseMessage,
        );
      }
    } catch (error) {
      getIt<IAppConfig>().platform.adjustManager?.trackEvent(UnsuccessfulRelativeAddEvent());
      getIt<FirebaseAnalyticsManager>().logEvent(YakinEklemeHataEvent());
      Future.delayed(const Duration(milliseconds: 500), () {
        hideDialog(context);
        showInfoDialog(
          LocaleProvider.of(context).warning,
          LocaleProvider.of(context).sorry_dont_transaction,
        );
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    selectedDate ??= DateTime.now();

    final DateTime? pickedDate = await showRbioDatePicker(
      context,
      title: LocaleProvider.of(context).select_birth_date,
      initialDateTime: selectedDate!,
      maximumDate: DateTime(selectedDate!.year + 1),
      minimumDate: DateTime(selectedDate!.year - 20),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
    }
    notifyListeners();
  }

  Future showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null) {
      if (loadingDialog!.isShowing()) {
        Navigator.of(context).pop();
        loadingDialog = null;
      }
    }
  }
}
