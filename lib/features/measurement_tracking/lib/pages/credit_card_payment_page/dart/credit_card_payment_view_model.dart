import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/loading_dialog.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/appointment_models/Appointment.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/appointment_models/doctor.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/payment/payment.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/payment/payment_appointment.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/payment/payment_cc.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/payment/payment_response.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/services/appointment_service.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/gradient_dialog.dart';

enum Stage { ERROR, LOADING, DONE }

class CreditCardPaymentPageViewModel with ChangeNotifier {
  BuildContext context;
  Stage _stage;
  Appointment _appointment;
  Doctor _doctor;
  Payment _payment;
  CC _cc;
  PaymentAppointment _paymentAppointment;
  String _errorMessage;
  LoadingDialog _loadingDialog;
  PaymentResponse _paymentResponse;
  bool _isCorrect = false;
  CreditCardPaymentPageViewModel(
      {BuildContext context, Appointment appointment, Doctor doctor}) {
    this.context = context;
    this._doctor = doctor;
    this._appointment = appointment;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setPaymentAppointment();
    });
  }

  Stage get stage => this._stage;

  Appointment get appointment => this._appointment;

  Doctor get doctor => this._doctor;

  PaymentAppointment get paymentAppointment => this._paymentAppointment;

  Payment get payment => this._payment;

  CC get cc => this._cc;

  String get errorMessage => this._errorMessage;

  LoadingDialog get loadingDialog => this._loadingDialog;

  PaymentResponse get paymentResponse => this._paymentResponse;

  bool get isCorrect => this._isCorrect;

  setPaymentAppointment() {
    PaymentAppointment paymentAppointment = new PaymentAppointment();
    paymentAppointment.appointmentDate = null;
    paymentAppointment.appointmentTypeCategoryId = 20;
    paymentAppointment.availabilityId = appointment.id;
    paymentAppointment.doctorHospitalDepartmentId =
        doctor.doctorHospitalDepartments[0].id;
    paymentAppointment.doctorId = null;
    paymentAppointment.isNormalPaymentAppointment = true;
    paymentAppointment.patientId = -1;
    paymentAppointment.patientIdentificationId = null;
    paymentAppointment.patientUserName = null;
    paymentAppointment.patientUserPhoneNumber = null;
    this._paymentAppointment = paymentAppointment;
    notifyListeners();
  }

  setCreditCart(
      {String cardHolder, String cardNumber, String expireDate, String cvv}) {
    CC cc = new CC();
    cc.cardHolder = cardHolder;
    cc.cardNumber = cardNumber.replaceAll(" ", "");
    cc.expirationYear =
        expireDate.length == 5 ? "20" + expireDate.substring(3, 5) : "";
    cc.expirationMonth =
        expireDate.length == 5 ? expireDate.substring(0, 2) : "";
    cc.cvv = cvv;
    this._cc = cc;
    notifyListeners();
  }

  setPayment() {
    Payment payment = Payment();
    payment.appointment = paymentAppointment;
    payment.cc = cc;
    payment.entegration_id = UserProfilesNotifier().selection.id;
    this._payment = payment;
    notifyListeners();
  }

  doPayment() async {
    setPayment();
    showLoadingDialog(context);
    this._stage = Stage.LOADING;
    notifyListeners();
    try {
      final response = await AppointmentService().doPayment(payment);
      this._paymentResponse = response;
      this._stage = Stage.DONE;
      hideDialog(context);
      Navigator.pushNamed(context, Routes.PAYMENT_RESPONSE,
          arguments: paymentResponse.datum.doResult);
    } catch (e) {
      this._stage = Stage.ERROR;
      hideDialog(context);
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
    }
    notifyListeners();
  }

  checkRequiredFields() {
    this._isCorrect = false;
    if (cc?.cardHolder != null && cc.cardHolder.length > 0) {
      if (cc.cardNumber.replaceAll(" ", "").length == 16 ||
          cc.cardNumber.replaceAll(" ", "").length == 15) {
        if (cc.cvv.length > 2) {
          if ((cc.expirationYear + "/" + cc.expirationMonth).length == 7) {
            this._isCorrect = true;
          } else {
            this._errorMessage =
                LocaleProvider.current.expiration_date_should_be;
          }
        } else {
          this._errorMessage = LocaleProvider.current.cvv_code_least_3_digit;
        }
      } else {
        this._errorMessage = LocaleProvider.current.credit_card_lenght_should;
      }
    } else {
      this._errorMessage = LocaleProvider.current.card_holder_cannot_empty;
    }
    notifyListeners();
  }

  showInformationDialog(String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }

  void showLoadingDialog(BuildContext context) async {
    await new Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            this._loadingDialog = loadingDialog ?? LoadingDialog());
    notifyListeners();
  }

  Future hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      this._loadingDialog = null;
      notifyListeners();
    }
  }
}
