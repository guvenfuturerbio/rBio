import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../create_appointment/model/voucher_price_request.dart';
import '../../do_mobile_payment/do_mobile_payment_screen.dart';
import '../model/get_video_call_price_request.dart';
import '../model/get_video_call_price_response.dart';
import '../model/synchronize_onedose_user_req.dart';

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
  int? patientId;
  final bool forOnline;
  final String to;
  final String from;
  CountryListResponse countryList = CountryListResponse();

  bool appointmentSuccess = false;

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
    required this.forOnline,
    required this.to,
    required this.from,
  }) {
    if (forOnline) {
      summaryButton = SummaryButtons.add;
      hospitalName = LocaleProvider.current.online_appo;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await getResourceVideoCallPrice();
        await getCountries();
      });
    } else if (tenantId == 1) {
      hospitalName = LocaleProvider.current.guven_hospital_ayranci;
    } else if (tenantId == 7) {
      hospitalName = LocaleProvider.current.guven_cayyolu_campus;
    }
    textDate = DateTime.parse(from).xFormatTime2();

    DateTime fromDateTime = DateTime.parse(from);
    DateTime toDateTime = DateTime.parse(to);
    fromDateTime = fromDateTime.xTurkishTimeToLocal();
    toDateTime = toDateTime.xTurkishTimeToLocal();
    appointmentRange = fromDateTime.toString().xGetUTCLocalTime() +
        " - " +
        toDateTime.toString().xGetUTCLocalTime();
  }

  bool _showOverlayLoading = false;
  bool get showOverlayLoading => _showOverlayLoading;
  set showOverlayLoading(bool value) {
    _showOverlayLoading = value;
    notifyListeners();
  }

  Future<void> getCountries() async {
    try {
      _showOverlayLoading = true;
      final response = await getIt<Repository>().getCountries();
      notifyListeners();
      countryList = CountryListResponse.fromMap(response.toJson());
      _showOverlayLoading = false;
    } catch (error) {
      LoggerUtils.instance.i(error);
      //
    }
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
    } catch (e) {
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
    required bool forFree,
    int? appointmentId,
    String? price,
  }) async {
    showOverlayLoading = true;
    try {
      final patientDetail = await getIt<Repository>().getPatientDetail();
      final oneDoseAccount = getIt<UserNotifier>().getUserAccount();
      if (patientDetail?.id == null) {
        SynchronizeOneDoseUserRequest synchronizeOneDoseUserRequest =
            SynchronizeOneDoseUserRequest(
                birthDate: oneDoseAccount.patients?.first.birthDate,
                email: oneDoseAccount.electronicMail,
                firstName: oneDoseAccount.name,
                gender: oneDoseAccount.patients?.first.gender,
                gsm: oneDoseAccount.phoneNumber,
                // countryCode: oneDoseAccount.c,
                //TODO       countryCode: oneDoseAccount.,
                hasEtkApproval: true,
                hasKvkkApproval: true,
                identityNumber: oneDoseAccount.identificationNumber,
                lastName: oneDoseAccount.surname,
                nationalityId: int.parse(oneDoseAccount.nationality!),
                passportNumber: oneDoseAccount.passaportNumber,
                patientType: 1);
        await getIt<Repository>()
            .synchronizeOneDoseUser(synchronizeOneDoseUserRequest);
        final patientDetailResponse =
            await getIt<Repository>().getPatientDetail();
        patientId = patientDetailResponse?.id!;
      } else {
        patientId = patientDetail?.id;
      }
    } catch (e) {
      LoggerUtils.instance.e("Error in synchronization");
    }
    try {
      List<ResourcesRequest> resourcesRequest = <ResourcesRequest>[];
      resourcesRequest.add(
        ResourcesRequest(
          tenantId: forOnline ? R.constants.tenantAyranciId : tenantId,
          to: to,
          from: from,
          departmentId: departmentId,
          resourceId: resourceId,
        ),
      );

      SaveAppointmentsRequest saveAppointmentsRequest = SaveAppointmentsRequest(
        patientId: patientId,
        tenantId: forOnline ? R.constants.tenantAyranciId : tenantId,
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
              appointmentId: appointmentId ?? 0,
              voucherCode: voucherCode,
            ),
            settings: const RouteSettings(name: PagePaths.doMobilePayment),
          ),
        );
        _showOverlayLoading = false;
        notifyListeners();
      } else {
        try {
          int datum = await getIt<Repository>().saveAppointment(
            AppointmentRequest(
                saveAppointmentsRequest: saveAppointmentsRequest,
                voucherCode: voucherCode),
          );

          _showOverlayLoading = false;
          if (datum == 1) {
            appointmentSuccess = true;

            // showGradientDialog(
            //   mContext,
            //   LocaleProvider.current.info,
            //   LocaleProvider.current.appo_created,
            //   true,
            // );
          } else if (datum == 2) {
            _showOverlayLoading = false;

            showGradientDialog(
              mContext,
              LocaleProvider.current.info,
              LocaleProvider.current.appointment_created_but_error,
              true,
            );
          }

          notifyListeners();
        } catch (error) {
          LoggerUtils.instance.e(error);
          _showOverlayLoading = false;
          notifyListeners();
          showPossibleProblemsDialog(
            mContext,
            LocaleProvider.current.warning,
            RbioMessageDialog(
              description: LocaleProvider.current.warning,
              buttonTitle: LocaleProvider.current.ok,
              isAtom: false,
            ),
            false,
          );
        }
      }
    } catch (e) {
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
        return RbioMessageDialog(
          description: text,
          buttonTitle: LocaleProvider.current.ok,
          isAtom: false,
        );
      },
    ).then(
      (value) async {
        if (closeAfter) {
          Atom.to(PagePaths.main, isReplacement: true);
        }
      },
    );
  }

  List<String> province = [
    'Adana',
    'Adıyaman',
    'Afyonkarahisar',
    'Ağrı',
    'Aksaray',
    'Amasya',
    'Ankara',
    'Antalya',
    'Ardahan',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bartın',
    'Batman',
    'Bayburt',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Düzce',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkâri',
    'Hatay',
    'Iğdır',
    'Isparta',
    'İstanbul',
    'İzmir',
    'Kahramanmaraş',
    'Karabük',
    'Karaman',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kilis',
    'Kırıkkale',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Mardin',
    'Mersin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Osmaniye',
    'Rize',
    'Sakarya',
    'Samsun',
    'Şanlıurfa',
    'Siirt',
    'Sinop',
    'Sivas',
    'Şırnak',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Uşak',
    'Van',
    'Yalova',
    'Yozgat',
    'Zonguldak'
  ];
}
