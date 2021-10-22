import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

enum LoadingStatus { loading, done }

class AddPatientRelativesScreenVm with ChangeNotifier {
  LoadingDialog loadingDialog;
  LoadingStatus status = LoadingStatus.loading;
  DateTime selectedDate;
  BuildContext context;
  var selectedCountry = Country(id: 213, name: "Türkiye");
  CountryListResponse countryList;
  Future<Response> futureResponse;
  final homeKey = GlobalKey<ScaffoldState>();
  UserAccount userAccount;
  PatientRelativeInfoResponse patientRelativeInfo;
  int selectedGender = 1;
  AddPatientRelativesScreenVm(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCountries();
    });
  }

  /*Future<void> _fetch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.get(UserService.JWT_TOKEN_KEY);
    _token = token;
    baseProvider = BaseProviderForPusula.create(_token);
    try {
      var response = await baseProvider.getUserProfile();
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(utf8.decode(response.bodyBytes));

        var datum = responseBody['datum'];
        userAccount = UserAccount.fromJson(datum);
      }
      status = LoadingStatus.done;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      showGradientDialog(
          context, "Error", LocaleProvider.of(context).no_network_connection);
    }
  }*/

  void changeGender(int gender) {
    selectedGender = gender;
    notifyListeners();
  }

  Future<void> getCountries() async {
    try {
      final response = await getIt<Repository>().getCountries();
      countryList = CountryListResponse.fromMap(response.toJson());
      status = LoadingStatus.done;
      notifyListeners();
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      print("exception: " + error.toString());
    }
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
        AnalyticsManager().sendEvent(new AddPatientRelativeSuccessEvent(0));
        showGradientDialog(
            context,
            LocaleProvider.of(context).success_message_title,
            LocaleProvider.of(context).existing_relative_add);
      } else if (response.datum == 1) {
        AnalyticsManager().sendEvent(new AddPatientRelativeSuccessEvent(1));
        showGradientDialog(
            context,
            LocaleProvider.of(context).success_message_title,
            LocaleProvider.of(context).add_new_relative);
      } else {
        AnalyticsManager().sendEvent(new AddPatientRelativeSuccessEvent(-1));
        showGradientDialog(
            context, LocaleProvider.of(context).warning, responseMessage);
      }
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      AnalyticsManager().sendEvent(new AddPatientRelativeFailEvent());
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
        helpText: LocaleProvider.of(context)
            .select_birth_date, // Can be used as title
        cancelText: LocaleProvider.of(context).btn_cancel,
        confirmText: LocaleProvider.of(context).btn_confirm,
        locale: new Locale(Intl.getCurrentLocale().toLowerCase()),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: R.color.blue,
              accentColor: R.color.dark_blue,
              colorScheme: ColorScheme.light(primary: R.color.blue),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ), // This will change to light theme.
            child: child,
          );
        });
    if (picked != null && picked != selectedDate) selectedDate = picked;
    notifyListeners();
  }

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
        });
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
