import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../model/model.dart';
import '../shared/necessary_identity/necessary_identity_screen.dart';
import '../shared/rate_dialog/rate_dialog.dart';
import 'widget/question_dialog.dart';

class AppointmentListVm extends ChangeNotifier {
  List<TranslatorResponse> _translator;
  BuildContext mContext;
  int _patientId;
  LoadingProgress _progress;
  bool _showProgressOverlay;
  DateTime _startDate, _endDate;
  List<PatientAppointmentsResponse> _patientAppointments;
  CancelAppointmentRequest _cancelAppointmentRequest;
  List<TranslatorResponse> get translators => this._translator;

  AppointmentListVm({BuildContext context, String jitsiRoomId}) {
    this.mContext = context;
    this._patientId = getIt<UserNotifier>().getPatient().id;
    this._showProgressOverlay = false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (getIt<UserNotifier>().canAccessHospital()) {
        await fetchAllTranslator();
        await fetchPatientAppointments();
      } else {
        showNecessary();
      }
      if (jitsiRoomId != null) await joinMeeting(jitsiRoomId, null);
    });
  }

  LoadingProgress get progress => this._progress;

  List<PatientAppointmentsResponse> get patientAppointments =>
      this._patientAppointments;

  bool get showProgressOverlay => this._showProgressOverlay;

  CancelAppointmentRequest get cancelAppointmentRequest =>
      this._cancelAppointmentRequest;

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

  void setStartDate(DateTime d) {
    this._startDate = d;
    fetchPatientAppointments();
    notifyListeners();
  }

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59)
      : DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  void setEndDate(DateTime d) {
    this._endDate = d;
    fetchPatientAppointments();
    notifyListeners();
  }

  Future<void> fetchAllTranslator() async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      this._translator = await getIt<UserManager>().getAllTranslator();
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      showGradientDialog(LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  Future<void> requestTranslator(
      String appointmentId, TranslatorRequest translatorPost) async {
    try {
      await getIt<UserManager>()
          .requestTranslator(appointmentId, translatorPost);
    } catch (e) {
      print("requestTranslator error " + e.toString());
      showGradientDialog(LocaleProvider.current.warning,
          e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<void> showRateDialog(int availabilityId) async {
    await showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return RateDialog(
          availabilityId: availabilityId,
        );
      },
    );
  }

  void showTranslatorSelector(String appointmentId) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomPopUpDropDown(
          title: LocaleProvider.of(context).get_translator,
          translators: translators,
          onChange: (value) {
            requestTranslator(appointmentId,
                TranslatorRequest(interpreterId: translators[value].id));
          },
        );
      },
    );
  }

  void setCancelAppointmentRequest(int id) {
    this._cancelAppointmentRequest = CancelAppointmentRequest(
        id: id, cancellationNote: "CancelFromMobile", cancellationReasonId: 3);
    notifyListeners();
  }

  Future<void> fetchPatientAppointments() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._patientAppointments =
          await getIt<Repository>().getPatientAppointments(
        PatientAppointmentRequest(
          patientId: _patientId,
          to: endDate.toString(),
          from: startDate.toString(),
        ),
      );
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
      showGradientDialog(LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  Future<void> joinMeeting(String webConsultantId, int availabilityId) async {
    //webConsultantId = webConsultantId.substring(webConsultantId.indexOf('='));
    this._showProgressOverlay = true;
    notifyListeners();

    try {
      if (kIsWeb) {
        if (Atom.url != PagePaths.WEBCONFERANCE) {
          Atom.to(
            PagePaths.WEBCONFERANCE,
            queryParameters: {
              'webConsultAppId': webConsultantId.toString(),
              'availability': availabilityId.toString(),
            },
          );
        }
      } else {
        //await UserService().checkOnlineMeetingAccessible(webConsultantId);
        await getIt<UserManager>()
            .startMeeting(mContext, webConsultantId, availabilityId);
      }
      this._showProgressOverlay = false;
      notifyListeners();
    } catch (e) {
      this._showProgressOverlay = false;
      notifyListeners();

      if (e.toString().contains("show")) {
        showGradientDialog(LocaleProvider.current.warning,
            e.toString().replaceAll("Exception: show", ""));
      } else {
        showGradientDialog(LocaleProvider.current.warning,
            LocaleProvider.current.sorry_dont_transaction);
      }
    }
  }

  Future<Uint8List> getSelectedFile() async {
    FilePickerResult filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['svg', 'pdf', 'png', 'jpg', 'bmp']);
    PlatformFile file = filePickerResult.files[0];
    Uint8List fileBytes;
    if (file != null) {
      print('file selected');
      fileBytes = file.bytes;
    }
    return fileBytes;
  }

  Future<bool> uploadFile(Uint8List file) async {
    try {
      this._showProgressOverlay = true;
      notifyListeners();
      await getIt<Repository>().uploadPatientDocuments(
          SecretUtils.instance.get(SecretKeys.MOCK_APPOINTMENT), file.toList());
      return true;
    } catch (e) {
      showGradientDialog(LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._showProgressOverlay = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> cancelAppointment() async {
    try {
      this._showProgressOverlay = true;
      notifyListeners();
      await getIt<Repository>().cancelAppointment(cancelAppointmentRequest);
      await fetchPatientAppointments();
      this._showProgressOverlay = false;
      notifyListeners();
    } catch (e, stk) {
      print(e);
      debugPrintStack(stackTrace: stk);
      showGradientDialog(LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._showProgressOverlay = false;
      notifyListeners();
    }
  }

  void showGradientDialog(String title, String text) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }

  void showQuestionDialog(String title, String text) {
    showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return QuestionDialog(title, text);
        }).then((value) async {
      if (value) {
        await cancelAppointment();
      } else {}
    });
  }

  void showNecessary() {
    showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return NecessaryIdentityScreen();
        }).then((value) async {
      if ((value ?? false) == true) {
        await fetchAllTranslator();
        await fetchPatientAppointments();
      } else {
        Navigator.of(mContext).pop();
      }
    });
  }

  Future<bool> isOnlineAppointmentPaid(int id) async {
    this._showProgressOverlay = true;
    notifyListeners();
    try {
      await getIt<Repository>().checkOnlineAppointmentPayment(
          CheckPaymentRequest(appointmentId: id));
      this._showProgressOverlay = false;
      notifyListeners();
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> handleAppointment(PatientAppointmentsResponse data) async {
    if (data.type == R.dynamicVar.onlineAppointmentType) {
      try {
        bool result = await isOnlineAppointmentPaid(data.id);

        if (result) {
          joinMeeting(data.videoGuid, data.id);
        } else {
          showDialog(
            context: mContext,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return GuvenAlert(
                backgroundColor: Colors.white,
                title: GuvenAlert.buildTitle(
                  LocaleProvider.current.fee_information,
                ),
                content: GuvenAlert.buildDescription(
                  LocaleProvider.current.payment_question_tag,
                ),
                actions: [
                  GuvenAlert.buildMaterialAction(
                    LocaleProvider.of(mContext).btn_cancel,
                    () {
                      Navigator.pop(mContext);
                    },
                  ),

                  //
                  SizedBox(
                    width: 20,
                  ),

                  //
                  GuvenAlert.buildMaterialAction(
                    LocaleProvider.of(mContext).confirm,
                    () {
                      Navigator.pop(mContext);
                      Atom.to(
                        PagePaths.APPOINTMENT_SUMMARY,
                        queryParameters: {
                          'tenantId': data.tenantId.toString(),
                          'departmentId':
                              data.resources[0].departmentId.toString(),
                          'resourceId': data.resources[0].resourceId.toString(),
                          'doctorName':
                              Uri.encodeFull(data.resources[0].resource),
                          'departmentName':
                              Uri.encodeFull(data.resources[0].department),
                          'from': data.from,
                          'to': data.to,
                          'forOnline': true.toString(),
                          'imageUrl': data.id.toString(),
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        this._showProgressOverlay = false;
        notifyListeners();
        showGradientDialog(LocaleProvider.current.warning,
            LocaleProvider.current.sorry_dont_transaction);
      }
    } else {
      await setCancelAppointmentRequest(data.id);
      showQuestionDialog(LocaleProvider.of(mContext).warning,
          LocaleProvider.of(mContext).cancel_appo_question);
    }
  }
}
