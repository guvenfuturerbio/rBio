import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class AddPatientRelativesScreenVm with ChangeNotifier {
  BuildContext context;

  LoadingDialog loadingDialog;
  LoadingProgress status = LoadingProgress.LOADING;

  DateTime selectedDate;
  CountryListResponse countryList;
  UserAccount userAccount;
  int selectedGender = 1;
  Country selectedCountry = Country(id: 213, name: "Türkiye");

  List<String> genderList = ["E", "K"];
  String gender;
  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  AddPatientRelativesScreenVm(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCountries();
    });
  }

  Future<void> getCountries() async {
    try {
      final response = await getIt<Repository>().getCountries();
      countryList = CountryListResponse.fromMap(response.toJson());
      status = LoadingProgress.DONE;
      notifyListeners();
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      status = LoadingProgress.ERROR;
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
        showGradientDialog(
          context,
          LocaleProvider.of(context).success_message_title,
          LocaleProvider.of(context).existing_relative_add,
        );
      } else if (response.datum == 1) {
        showGradientDialog(
          context,
          LocaleProvider.of(context).success_message_title,
          LocaleProvider.of(context).add_new_relative,
        );
      } else {
        showGradientDialog(
          context,
          LocaleProvider.of(context).warning,
          responseMessage,
        );
      }
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      Future.delayed(const Duration(milliseconds: 500), () {
        print(error);
        hideDialog(context);
        showGradientDialog(
            context,
            LocaleProvider.of(context).warning,
            error.toString() == "network"
                ? LocaleProvider.of(context).no_network_connection
                : LocaleProvider.of(context).sorry_dont_transaction);
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    if (selectedDate == null) {
      selectedDate = DateTime.now();
    }

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(selectedDate.year - 20),
      lastDate: DateTime(selectedDate.year + 1),
      helpText: LocaleProvider.of(context).select_birth_date,
      cancelText: LocaleProvider.of(context).btn_cancel,
      confirmText: LocaleProvider.of(context).btn_confirm,
      // locale: Locale(Intl.getCurrentLocale().toLowerCase()),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: getIt<ITheme>().mainColor,
            accentColor: R.color.dark_blue,
            colorScheme: ColorScheme.light(primary: getIt<ITheme>().mainColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate) selectedDate = picked;
    notifyListeners();
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

  Future showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  void setSelectedCountry(Country country) {
    selectedCountry = country;
    notifyListeners();
  }
}
