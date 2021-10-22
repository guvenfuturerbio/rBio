import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class RegisterStep1ScreenVm with ChangeNotifier {
  BuildContext context;
  LoadingDialog loadingDialog;
  CountryListResponse countryList;
  DateTime selectedDate;
  bool isWithOutTCKN;

  RegisterStep1ScreenVm(this.context) {
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      countryList = await getCountries();
    });*/
  }

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
        });
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    //builder: (BuildContext context) => WillPopScope(child:loadingDialog = LoadingDialog() , onWillPop:  () async => false,));
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  Future<void> getCountries() async {
    try {
      showLoadingDialog(context);
      final response = await getIt<Repository>().getCountries();
      countryList = CountryListResponse.fromMap(response.toJson());
      notifyListeners();
      hideDialog(context);
    } catch (error) {
      //
    }
  }

  Future<void> selectDate(BuildContext context) async {
    if (selectedDate == null) {
      selectedDate = DateTime.now();
    }

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year - 150),
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

  Future<void> registerStep1(RegisterStep1PusulaModel userRegistrationStep1,
      UserRegistrationStep1Model registerStep1Model) async {
    try {
      showLoadingDialog(context);
      GuvenResponseModel response;
      if (userRegistrationStep1.identityNumber.trim().isEmpty ||
          registerStep1Model.identificationNumber.trim().isEmpty) {
        isWithOutTCKN = true;
        response = await getIt<Repository>()
            .registerStep1WithOutTc(registerStep1Model);
      } else {
        isWithOutTCKN = false;
        response =
            await getIt<Repository>().registerStep1Ui(userRegistrationStep1);
      }

      hideDialog(context);
      if (response.datum == 18 ||
          response.datum == 19 ||
          response.datum == 21 ||
          response.datum == 1 ||
          response.datum == 3) {
        Atom.to(
          PagePaths.REGISTER_STEP_2,
          queryParameters: {
            'isWithoutTCKN': isWithOutTCKN.toString(),
            'registerStep1Model': registerStep1Model.toJson().toString(),
            'userRegistrationStep1': userRegistrationStep1.toJson().toString(),
          },
        );
      } else if (response.datum == 5 || response.datum == 2) {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            "TC Kimlik numarası hatalı");
      } else if (response.datum == 4) {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            LocaleProvider.of(context).already_registered_mail);
      } else if (response.datum == 15) {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            LocaleProvider.of(context).already_registered_phone);
      } else if (response.datum == 16) {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            LocaleProvider.of(context).credential_already_exist);
      } else {
        showGradientDialog(context, LocaleProvider.of(context).warning,
            response.message.toString());
        AnalyticsManager()
            .sendEvent(new RegisterStep1FailEvent("Register1 User TC", 22));
      }
    } catch (error) {
      Future.delayed(const Duration(milliseconds: 500), () {
        AnalyticsManager()
            .sendEvent(new RegisterStep1FailEvent("Register1 User TC", 22));
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

  void showKvkkInfo() {
    if (kIsWeb) {
      Get.dialog(
        Dialog(
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: Get.width * 0.6, maxHeight: Get.height * 0.8),
                child: HtmlElementView(viewType: 'kvkk'),
              ),
            ),
          ),
        ),
      );
    } else {
      Atom.to(
        PagePaths.WEBVIEW,
        queryParameters: {
          'url': Uri.encodeFull(LocaleProvider.of(context).policy_url),
          'title':
              Uri.encodeFull(LocaleProvider.of(context).personal_data_policy),
        },
      );
    }
  }
}
