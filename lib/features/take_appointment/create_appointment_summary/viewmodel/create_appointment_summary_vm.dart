import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/take_appointment/do_mobile_payment/do_mobile_payment_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class CreateAppointmentSummaryVm extends ChangeNotifier {
  final BuildContext mContext;
  final int tenantId;
  final int departmentId;
  final int resourceId;
  final int patientId;
  final bool forOnline;
  final String to;
  final String from;

  String _appointmentRange;
  String _textDate;
  String _hospitalName;
  GetVideoCallPriceResponse _getVideoCallPriceResponse;
  bool _priceLoading;

  String get hospitalName => this._hospitalName;
  String get textDate => this._textDate;
  String get appointmentRange => this._appointmentRange;
  bool get priceLoading => this._priceLoading ?? false;
  GetVideoCallPriceResponse get getVideoCallPriceResponse =>
      this._getVideoCallPriceResponse;

  CreateAppointmentSummaryVm({
    @required this.mContext,
    @required this.tenantId,
    @required this.departmentId,
    @required this.resourceId,
    @required this.patientId,
    @required this.forOnline,
    @required this.to,
    @required this.from,
  }) {
    if (forOnline) {
      this._hospitalName = LocaleProvider.current.online_appo;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await getResourceVideoCallPrice();
      });
    } else if (tenantId == 1) {
      this._hospitalName = LocaleProvider.current.guven_hospital_ayranci;
    } else if (tenantId == 7) {
      this._hospitalName = LocaleProvider.current.guven_cayyolu_campus;
    }
    this._textDate = DateFormat("d MMMM yyyy").format(DateTime.parse(from));

    this._appointmentRange =
        from.substring(11, 16) + " - " + to.substring(11, 16);
  }

  bool _showOverlayLoading = false;
  bool get showOverlayLoading => _showOverlayLoading;
  set showOverlayLoading(bool value) {
    _showOverlayLoading = value;
    notifyListeners();
  }

  Future getResourceVideoCallPrice() async {
    this._priceLoading = true;
    this._showOverlayLoading = true;
    notifyListeners();

    try {
      this._getVideoCallPriceResponse =
          await getIt<Repository>().getResourceVideoCallPrice(
        GetVideoCallPriceRequest(
          resourceId: this.resourceId,
          departmentId: this.departmentId,
          tenantId: this.tenantId,
        ),
      );
      
      this._priceLoading = false;
      this._showOverlayLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      this._priceLoading = false;
      this._showOverlayLoading = false;
      notifyListeners();
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction, true);
    }
  }

  Future<void> saveAppointment({
    bool forOnline,
    bool forFree,
    int appointmentId,
    String price,
  }) async {
    showOverlayLoading = true;

    try {
      List<ResourcesRequest> resourcesRequest = <ResourcesRequest>[];
      resourcesRequest.add(
        ResourcesRequest(
          tenantId: forOnline ? R.dynamicVar.tenantAyranciId : tenantId,
          to: to,
          from: from,
          departmentId: departmentId,
          resourceId: resourceId,
        ),
      );

      SaveAppointmentsRequest saveAppointmentsRequest = SaveAppointmentsRequest(
        patientId: patientId,
        tenantId: forOnline ? R.dynamicVar.tenantAyranciId : tenantId,
        type: forOnline ? 256 : 1, // poliklinik
        status: 1, // bekliyor
        patientType: 0, // bilinmiyor
        appointmentSource: 3, // from mobile App
        videoCallLink: null,
        resourcesRequestList: resourcesRequest,
      );

      if (forOnline && !forFree) {
        Navigator.push(
          mContext,
          MaterialPageRoute(
            builder: (context) => DoMobilePaymentScreen(
              price: price,
              appointment: AppointmentRequest(
                saveAppointmentsRequest: saveAppointmentsRequest,
              ),
              appointmentId: appointmentId,
            ),
            settings: RouteSettings(name: PagePaths.DOMOBILEPAYMENT),
          ),
        );
        this._showOverlayLoading = false;
        notifyListeners();
      } else {
        try {
          int datum = await getIt<Repository>().saveAppointment(
              AppointmentRequest(
                  saveAppointmentsRequest: saveAppointmentsRequest));
          this._showOverlayLoading = false;
          notifyListeners();
          if (datum == 1) {
            showGradientDialog(mContext, LocaleProvider.current.info,
                LocaleProvider.current.appo_created, true);
          } else if (datum == 2) {
            showGradientDialog(mContext, LocaleProvider.current.info,
                LocaleProvider.current.appointment_created_but_error, true);
          }
        } catch (error, stackTrace) {
          LoggerUtils.instance.e(error);
          Sentry.captureException(error, stackTrace: stackTrace);
          this._showOverlayLoading = false;
          notifyListeners();
          showPossibleProblemsDialog(
            mContext,
            LocaleProvider.current.warning,
            DetailedGradientMessageWidget(
                currentLocale: ui.window.locale.toString()),
            false,
          );
        }
      }
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showPossibleProblemsDialog(
        mContext,
        LocaleProvider.current.warning,
        DetailedGradientMessageWidget(
          currentLocale: ui.window.locale.toString(),
        ),
        false,
      );
    } finally {
      showOverlayLoading = false;
    }
  }

  void showPossibleProblemsDialog(
    BuildContext context,
    String title,
    Widget body,
    bool closeAfter,
  ) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogForPossibleErrorDialog(title: title, body: body);
        }).then((value) async {
      if (closeAfter) {
        Atom.to(PagePaths.MAIN, isReplacement: true);
      }
    });
  }

  void showGradientDialog(
    BuildContext context,
    String title,
    String text,
    bool closeAfter,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    ).then(
      (value) async {
        if (closeAfter) {
          Atom.to(PagePaths.MAIN, isReplacement: true);
        }
      },
    );
  }
}
