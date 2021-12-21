import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/model/home/take_appointment/do_mobil_payment_voucher.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'iyzico_response_sms_payment_page.dart';

class DoMobilePaymentScreenVm extends ChangeNotifier {
  BuildContext mContext;
  AppointmentRequest appointmentRequest;
  String voucherCode;
  bool _showOverlay;
  bool _isSalesContractConfirmed;
  bool _cancellationFormConfirmed;
  GuvenResponseModel _paymentResponse;

  DoMobilePaymentScreenVm(
      {BuildContext context,
      AppointmentRequest appointmentRequest,
      String voucherCode}) {
    this.appointmentRequest = appointmentRequest;
    this.mContext = context;
    this.voucherCode = voucherCode;
  }

  bool get showOverlay => this._showOverlay ?? false;

  GuvenResponseModel get paymentResponse => this._paymentResponse;

  bool get isSalesContractConfirmed => this._isSalesContractConfirmed ?? false;

  bool get cancellationFormConfirmed =>
      this._cancellationFormConfirmed ?? false;

  Future<void> doMobilePayment(ERandevuCCResponse cc, int appointmentId) async {
    if (checkRequiredFields(cc)) {
      this._showOverlay = true;
      cc.expirationMonth = cc.expirationMonth.substring(0, 2);
      cc.expirationYear = "20" + cc.expirationYear.substring(3, 5);
      notifyListeners();

      try {
        this._paymentResponse =
            await getIt<Repository>().doMobilePaymentWithVoucher(
          DoMobilePaymentWithVoucherRequest(
              appointmentId: appointmentId,
              cc: cc,
              appointmentRequest:
                  this.appointmentRequest.saveAppointmentsRequest,
              voucherCode: voucherCode),
        );

        final html = Map.from(this._paymentResponse.datum)['do_result'];
        RegisterViews.instance.doMobilePayment(html);
        Navigator.push(
          mContext,
          MaterialPageRoute(
            builder: (context) => IyzicoResponseSmsPaymentScreen(
              html: html,
            ),
            settings: RouteSettings(name: PagePaths.IYZICORESPONSESMSPAYMENT),
          ),
        );
        this._showOverlay = false;
        notifyListeners();
      } catch (e, stackTrace) {
        Sentry.captureException(e, stackTrace: stackTrace);
        print("DoMobilePaymentException" + e.toString());
        showGradientDialog(LocaleProvider.current.warning,
            LocaleProvider.current.sorry_dont_transaction);
        this._showOverlay = false;
        notifyListeners();
      }
    }
  }

  Future<void> showDistanceSaleContract({
    String packageName,
    String price,
  }) async {
    UserAccount userAccount = getIt<UserNotifier>().getUserAccount();
    String filledForm = await fillAllFormFields(
      LocaleProvider.current.distance_sales_contract_context,
      (userAccount.name + ' ' + userAccount.surname),
      userAccount.electronicMail,
      userAccount.phoneNumber,
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    showGradientDialog(packageName, filledForm);
  }

  Future<void> showCancellationAndRefund({
    String packageName,
    String price,
  }) async {
    UserAccount userAccount = getIt<UserNotifier>().getUserAccount();
    String filledForm = await fillAllFormFields(
      LocaleProvider.current.preinformation_form_context,
      (userAccount.name + ' ' + userAccount.surname),
      userAccount.electronicMail,
      userAccount.phoneNumber,
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    showGradientDialog(packageName, filledForm);
  }

  Future<String> fillAllFormFields(
      String formContext,
      String userNameAndSurname,
      String userEmail,
      String phoneNumber,
      String packageName,
      String currentDate) async {
    String tmpContexHolder = await fillAllFields(formContext,
        userNameAndSurname, userEmail, phoneNumber, currentDate, packageName);
    return tmpContexHolder;
  }

  toggleSalesContract() {
    this._isSalesContractConfirmed = !isSalesContractConfirmed;
    notifyListeners();
  }

  toggleCancellationForm() {
    this._cancellationFormConfirmed = !cancellationFormConfirmed;
    notifyListeners();
  }

  bool checkRequiredFields(ERandevuCCResponse cc) {
    bool isCorrect = false;
    if (cc.cardHolder.length > 0) {
      if (cc.cardNumber.replaceAll(" ", "").length == 16) {
        if (cc.cvv.length > 2) {
          if ((cc?.expirationYear?.length ?? 0) == 5) {
            if ((cc?.expirationMonth?.length ?? 0) == 5) {
              isCorrect = true;
            } else {
              showGradientDialog(LocaleProvider.of(mContext).warning,
                  LocaleProvider.of(mContext).expiration_date_should_be);
            }
          } else {
            showGradientDialog(LocaleProvider.of(mContext).warning,
                LocaleProvider.of(mContext).expiration_date_should_be);
          }
        } else {
          showGradientDialog(LocaleProvider.of(mContext).warning,
              LocaleProvider.of(mContext).cvv_code_least_3_digit);
        }
      } else {
        showGradientDialog(LocaleProvider.of(mContext).warning,
            LocaleProvider.of(mContext).credit_card_lenght_should);
      }
    } else {
      showGradientDialog(LocaleProvider.of(mContext).warning,
          LocaleProvider.of(mContext).card_holder_cannot_empty);
    }
    return isCorrect;
  }

  void showGradientDialog(String title, String text) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text, hasScrollable: true);
      },
    );
  }
}
