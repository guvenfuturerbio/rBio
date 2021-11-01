import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../take_appointment/do_mobile_payment/iyzico_response_sms_payment_page.dart';

class CreditCardScreenVm extends ChangeNotifier {
  CreditCardScreenVm({BuildContext context, PaymentType paymentType}) {
    this.mContext = context;
    this._paymentType = paymentType;
  }

  LoadingDialog progressDialog;

  LoadingProgress _progress;

  PaymentType _paymentType;

  BuildContext mContext;

  bool _isDistanceContractSelected;

  bool _isInformationFormAccepted;

  LoadingProgress get progress => this._progress;

  bool get isDistanceContractSelected =>
      this._isDistanceContractSelected ?? false;

  bool get isInformationFormAccepted =>
      this._isInformationFormAccepted ?? false;

  PaymentType get paymentType => this._paymentType;

  void toggleDistanceContract() {
    this._isDistanceContractSelected = !isDistanceContractSelected;
    notifyListeners();
  }

  void toggleInformationForm() {
    this._isInformationFormAccepted = !isInformationFormAccepted;
    notifyListeners();
  }

  bool checkRequiredFields({
    String cardHolder,
    String cardNumber,
    String cvv,
    String date,
  }) {
    bool isCorrect = false;
    if (isDistanceContractSelected) {
      if (isInformationFormAccepted) {
        if (cardHolder.length > 0) {
          if (cardNumber.replaceAll(" ", "").length == 16) {
            if (cvv.length > 2) {
              if (date.length == 5) {
                isCorrect = true;
              } else {
                showGradientDialog(mContext, LocaleProvider.current.warning,
                    LocaleProvider.current.expiration_date_should_be);
              }
            } else {
              showGradientDialog(mContext, LocaleProvider.current.warning,
                  LocaleProvider.current.cvv_code_least_3_digit);
            }
          } else {
            showGradientDialog(mContext, LocaleProvider.current.warning,
                LocaleProvider.current.credit_card_lenght_should);
          }
        } else {
          showGradientDialog(mContext, LocaleProvider.current.warning,
              LocaleProvider.current.card_holder_cannot_empty);
        }
      } else {
        showGradientDialog(mContext, LocaleProvider.current.warning,
            LocaleProvider.current.check_information);
      }
    } else {
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.check_distance_sales_contract);
    }
    return isCorrect;
  }

  Future<void> doPackagePayment(PackagePaymentRequest packagePayment) async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 500));
      final paymentResponse =
          await getIt<Repository>().doPackagePayment(packagePayment);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
      Navigator.push(
        mContext,
        MaterialPageRoute(
          builder: (context) =>
              IyzicoResponseSmsPaymentScreen(html: paymentResponse),
          settings: RouteSettings(name: PagePaths.IYZICORESPONSESMSPAYMENT),
        ),
      );
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  Future<void> showDistanceSaleContract(
      {String packageName, String price}) async {
    UserAccount userAccount = getIt<UserInfo>().getUserAccount();
    String filledForm = await fillAllFormFields(
      LocaleProvider.current.distance_sales_contract_context,
      (userAccount.name + ' ' + userAccount.surname),
      userAccount.electronicMail,
      userAccount.phoneNumber,
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    showGradientDialog(mContext, packageName, filledForm);
  }

  Future<void> showCancellationAndRefund(
      {String packageName, String price}) async {
    UserAccount userAccount = getIt<UserInfo>().getUserAccount();
    String filledForm = await fillAllFormFields(
      LocaleProvider.current.preinformation_form_context,
      (userAccount.name + ' ' + userAccount.surname),
      userAccount.electronicMail,
      userAccount.phoneNumber,
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    showGradientDialog(mContext, packageName, filledForm);
  }

  Future<String> fillAllFormFields(
    String formContext,
    String userNameAndSurname,
    String userEmail,
    String phoneNumber,
    String packageName,
    String currentDate,
  ) async {
    String tmpContexHolder = await fillAllFields(formContext,
        userNameAndSurname, userEmail, phoneNumber, currentDate, packageName);
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
