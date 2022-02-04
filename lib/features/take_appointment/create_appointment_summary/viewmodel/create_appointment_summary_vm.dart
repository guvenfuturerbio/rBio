import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:onedosehealth/features/take_appointment/create_appointment/model/voucher_price_request.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../do_mobile_payment/do_mobile_payment_screen.dart';

enum SummaryButtons {
  add,
  applyPassive,
  applyActive,
  cancel,
  none,
}

class CreateAppointmentSummaryVm extends ChangeNotifier {
  final BuildContext mContext;
  final int tenantId;
  final int departmentId;
  final int resourceId;
  final int patientId;
  final bool forOnline;
  final String to;
  final String from;

  SummaryButtons _summaryButton = SummaryButtons.none;
  SummaryButtons get summaryButton => _summaryButton;
  set summaryButton(SummaryButtons val) {
    _summaryButton = val;
    notifyListeners();
  }

  bool _showCodeField = false;
  bool get showCodeField => _showCodeField;
  set showCodeField(bool val) {
    _showCodeField = val;
    notifyListeners();
  }

  String? voucherCode;
  String? appointmentRange;
  String? textDate;
  late String hospitalName;
  GetVideoCallPriceResponse? orgVideoCallPriceResponse;
  GetVideoCallPriceResponse? newVideoCallPriceResponse;
  bool? _priceLoading;

  bool get priceLoading => _priceLoading ?? false;

  CreateAppointmentSummaryVm({
   required this.mContext,
    required this.tenantId,
    required this.departmentId,
    required this.resourceId,
    required this.patientId,
    required this.forOnline,
    required this.to,
    required this.from,
  }) {
    if (forOnline) {
      summaryButton = SummaryButtons.add;
      hospitalName = LocaleProvider.current.online_appo;
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
        await getResourceVideoCallPrice();
      });
    } else if (tenantId == 1) {
      hospitalName = LocaleProvider.current.guven_hospital_ayranci;
    } else if (tenantId == 7) {
      hospitalName = LocaleProvider.current.guven_cayyolu_campus;
    }
    textDate = DateTime.parse(from).xFormatTime2();

    appointmentRange =
        from.substring(11, 16) + " - " + to.substring(11, 16);
  }

  bool _showOverlayLoading = false;
  bool get showOverlayLoading => _showOverlayLoading;
  set showOverlayLoading(bool value) {
    _showOverlayLoading = value;
    notifyListeners();
  }

  Future getResourceVideoCallPrice() async {
    _priceLoading = true;
    _showOverlayLoading = true;
    notifyListeners();

    try {
      orgVideoCallPriceResponse =
          await getIt<Repository>().getResourceVideoCallPrice(
        GetVideoCallPriceRequest(
          resourceId: resourceId,
          departmentId: departmentId,
          tenantId: tenantId,
        ),
      );

      _priceLoading = false;
      _showOverlayLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      _priceLoading = false;
      _showOverlayLoading = false;
      notifyListeners();
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
        true,
      );
    }
  }

  Future<void> saveAppointment({
    required bool forOnline,
   required  bool forFree,
   required  int appointmentId,
    required String price,
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
              voucherCode: voucherCode,
            ),
            settings:const RouteSettings(name: PagePaths.doMobilePayment),
          ),
        );
        _showOverlayLoading = false;
        notifyListeners();
      } else {
        try {
          int datum = await getIt<Repository>().saveAppointment(
              AppointmentRequest(
                  saveAppointmentsRequest: saveAppointmentsRequest));
          _showOverlayLoading = false;
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
          _showOverlayLoading = false;
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

  Future<void> applyCode(String message) async {
    newVideoCallPriceResponse = null;
    showOverlayLoading = true;
    var response = await getIt<Repository>()
        .getResourceVideoCallPriceWithVoucher(VoucherPriceRequest(
            resourceId: resourceId.toString(),
            tenantId: tenantId.toString(),
            departmentId: departmentId.toString(),
            voucherCode: message));
    voucherCode = message;
    newVideoCallPriceResponse = orgVideoCallPriceResponse?.copyWith(
      patientPrice: response.datum,
    );
    showOverlayLoading = false;
  }

  Future<void> codeCancel() async {
    newVideoCallPriceResponse = null;
    voucherCode = null;
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
        }).then(
      (value) async {
        if (closeAfter) {
          Atom.to(PagePaths.main, isReplacement: true);
        }
      },
    );
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
          Atom.to(PagePaths.main, isReplacement: true);
        }
      },
    );
  }
}
