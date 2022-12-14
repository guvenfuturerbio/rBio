import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../take_appointment/do_mobile_payment/iyzico_response_sms_payment_page.dart';

class CreditCardScreenVm extends ChangeNotifier {
  CreditCardScreenVm(
      {required BuildContext context, required PaymentType paymentType}) {
    mContext = context;
    paymentTypeVm = paymentType;
  }

  LoadingDialog? progressDialog;

  LoadingProgress? progress;

  PaymentType? paymentTypeVm;

  BuildContext? mContext;

  bool? isDistanceContractSelected;

  bool? isInformationFormAccepted;

  void toggleDistanceContract() {
    isDistanceContractSelected = !isDistanceContractSelected!;
    notifyListeners();
  }

  void toggleInformationForm() {
    isInformationFormAccepted = !isInformationFormAccepted!;
    notifyListeners();
  }

  bool checkRequiredFields({
    required String cardHolder,
    required String cardNumber,
    required String cvv,
    required String date,
  }) {
    bool isCorrect = false;
    if (isDistanceContractSelected!) {
      if (isInformationFormAccepted!) {
        if (cardHolder.isNotEmpty) {
          if (cardNumber.replaceAll(" ", "").length == 16) {
            if (cvv.length > 2) {
              if (date.length == 5) {
                isCorrect = true;
              } else {
                showGradientDialog(mContext!, LocaleProvider.current.warning,
                    LocaleProvider.current.expiration_date_should_be);
              }
            } else {
              showGradientDialog(mContext!, LocaleProvider.current.warning,
                  LocaleProvider.current.cvv_code_least_3_digit);
            }
          } else {
            showGradientDialog(mContext!, LocaleProvider.current.warning,
                LocaleProvider.current.credit_card_lenght_should);
          }
        } else {
          showGradientDialog(mContext!, LocaleProvider.current.warning,
              LocaleProvider.current.card_holder_cannot_empty);
        }
      } else {
        showGradientDialog(mContext!, LocaleProvider.current.warning,
            LocaleProvider.current.check_information);
      }
    } else {
      showGradientDialog(mContext!, LocaleProvider.current.warning,
          LocaleProvider.current.check_distance_sales_contract);
    }
    return isCorrect;
  }

  Future<void> doPackagePayment(PackagePaymentRequest packagePayment) async {
    try {
      progress = LoadingProgress.loading;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 500));
      final paymentResponse =
          await getIt<Repository>().doPackagePayment(packagePayment);
      progress = LoadingProgress.done;
      notifyListeners();
      Navigator.push(
        mContext!,
        MaterialPageRoute(
          builder: (context) =>
              IyzicoResponseSmsPaymentScreen(html: paymentResponse),
          settings:
              const RouteSettings(name: PagePaths.iyzicoResponseSmsPayment),
        ),
      );
    } catch (e) {
      progress = LoadingProgress.error;
      notifyListeners();
      showGradientDialog(mContext!, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  Future<void> showDistanceSaleContract(
      {required String packageName, required String price}) async {
    UserAccount userAccount = getIt<UserNotifier>().getUserAccount();
    String filledForm = await fillAllFormFields(
      LocaleProvider.current.distance_sales_contract_context,
      (userAccount.name! + ' ' + userAccount.surname!),
      userAccount.electronicMail!,
      userAccount.phoneNumber!,
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    showGradientDialog(mContext!, packageName, filledForm);
  }

  Future<void> showCancellationAndRefund(
      {required String packageName, required String price}) async {
    UserAccount userAccount = getIt<UserNotifier>().getUserAccount();
    String filledForm = await fillAllFormFields(
      LocaleProvider.current.preinformation_form_context,
      (userAccount.name! + ' ' + userAccount.surname!),
      userAccount.electronicMail!,
      userAccount.phoneNumber!,
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    showGradientDialog(mContext!, packageName, filledForm);
  }

  Future<String> fillAllFormFields(
    String formContext,
    String userNameAndSurname,
    String userEmail,
    String phoneNumber,
    String packageName,
    String currentDate,
  ) async {
    String tmpContexHolder = fillAllFields(formContext, userNameAndSurname,
        userEmail, phoneNumber, currentDate, packageName);
    return tmpContexHolder;
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text, hasScrollable: true);
      },
    );
  }
}
