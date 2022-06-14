import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'do_mobil_payment_voucher.dart';
import 'iyzico_response_sms_payment_page.dart';

class DoMobilePaymentScreenVm extends ChangeNotifier {
  BuildContext mContext;
  AppointmentRequest? appointmentRequest;
  String? voucherCode;
  bool? _showOverlay;
  bool? _isSalesContractConfirmed;
  bool? _cancellationFormConfirmed;
  late GuvenResponseModel _paymentResponse;

  DoMobilePaymentScreenVm(
      {required this.mContext, this.appointmentRequest, this.voucherCode});

  bool get showOverlay => _showOverlay ?? false;

  GuvenResponseModel get paymentResponse => _paymentResponse;

  bool get isSalesContractConfirmed => _isSalesContractConfirmed ?? false;

  bool get cancellationFormConfirmed => _cancellationFormConfirmed ?? false;
  final AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  AutovalidateMode? get autovalidateMode => _autovalidateMode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? get formKey => _formKey;

  Future<void> doMobilePayment(ERandevuCCResponse cc, int appointmentId) async {
    if (checkRequiredFields(cc)) {
      _showOverlay = true;
      cc.expirationMonth = cc.expirationMonth?.substring(0, 2);
      cc.expirationYear = "20" + cc.expirationYear!.substring(3, 5);
      notifyListeners();

      try {
        _paymentResponse = await getIt<Repository>().doMobilePaymentWithVoucher(
          DoMobilePaymentWithVoucherRequest(
            appointmentId: appointmentId,
            cc: cc,
            appointmentRequest: appointmentRequest?.saveAppointmentsRequest,
            voucherCode: voucherCode,
          ),
        );

        final html = Map.from(_paymentResponse.datum)['do_result'];
        final transId = _paymentResponse.datum['trans_id'];
        RegisterViews.instance.doMobilePayment(html);
        Navigator.push(
          mContext,
          MaterialPageRoute(
            builder: (context) => IyzicoResponseSmsPaymentScreen(
              html: html,
              uid: transId,
            ),
            settings:
                const RouteSettings(name: PagePaths.iyzicoResponseSmsPayment),
          ),
        );
        _showOverlay = false;
        notifyListeners();
      } catch (e) {
        showGradientDialog(LocaleProvider.current.warning,
            LocaleProvider.current.sorry_dont_transaction);
        _showOverlay = false;
        notifyListeners();
      }
    }
  }

  Future<void> showDistanceSaleContract({
    required String packageName,
    required String price,
  }) async {
    UserAccount userAccount = getIt<UserNotifier>().getUserAccount();
    String filledForm = await fillAllFormFields(
      LocaleProvider.current.distance_sales_contract_context,
      (userAccount.name! + ' ' + userAccount.surname!),
      userAccount.electronicMail ?? "",
      userAccount.phoneNumber ?? "",
      packageName,
      (DateTime.now().toString().substring(0, 10)),
    );
    showGradientDialog(packageName, filledForm);
  }

  Future<void> showCancellationAndRefund({
    required String packageName,
    required String price,
  }) async {
    UserAccount userAccount = getIt<UserNotifier>().getUserAccount();
    String filledForm = await fillAllFormFields(
      LocaleProvider.current.preinformation_form_context,
      (userAccount.name! + ' ' + userAccount.surname!),
      userAccount.electronicMail ?? "",
      userAccount.phoneNumber ?? "",
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
    String currentDate,
  ) async {
    final tmpContexHolder = fillAllFields(
      formContext,
      userNameAndSurname,
      userEmail,
      phoneNumber,
      currentDate,
      packageName,
    );
    return tmpContexHolder;
  }

  toggleSalesContract() {
    _isSalesContractConfirmed = !isSalesContractConfirmed;
    notifyListeners();
  }

  toggleCancellationForm() {
    _cancellationFormConfirmed = !cancellationFormConfirmed;
    notifyListeners();
  }

  bool checkRequiredFields(ERandevuCCResponse cc) {
    bool isCorrect = false;
    try {
      if (cc.cardHolder!.isNotEmpty) {
        if (cc.cardNumber!.replaceAll(" ", "").length == 16) {
          if (cc.cvv!.length > 2) {
            if ((cc.expirationYear?.length ?? 0) == 5) {
              if ((cc.expirationMonth?.length ?? 0) == 5) {
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
    } catch (e) {
      showGradientDialog(LocaleProvider.of(mContext).warning,
          LocaleProvider.of(mContext).check_and_try_again);
      return false;
    }
  }

  void showGradientDialog(String title, String text) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return RbioMessageDialog(
          description: text,
          buttonTitle: LocaleProvider.of(context).Ok,
          isAtom: false,
        );
      },
    );
  }
}
