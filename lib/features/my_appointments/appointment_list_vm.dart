import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../model/model.dart';
import '../shared/necessary_identity/necessary_identity_screen.dart';
import '../shared/rate_dialog/rate_dialog.dart';
import 'widget/question_dialog.dart';

class AppointmentListVm extends RbioVm {
  @override
  BuildContext mContext;

  List<TranslatorResponse> _translator;
  List<TranslatorResponse> get translators => _translator;

  LoadingProgress _progress;
  LoadingProgress get progress => _progress;

  List<PatientAppointmentsResponse> _patientAppointments;
  List<PatientAppointmentsResponse> get patientAppointments =>
      _patientAppointments;

  late int _patientId;
  bool showProgressOverlay;
  DateTime? _startDate, _endDate;
  CancelAppointmentRequest cancelAppointmentRequest;

  AppointmentListVm(this.mContext, {String? jitsiRoomId}) {
    _patientId = getIt<UserNotifier>().getPatient().id ?? 0;
    showProgressOverlay = false;

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (getIt<UserNotifier>().canAccessHospital()) {
        await fetchAllTranslator();
        await fetchPatientAppointments();
      } else {
        showNecessary();
      }

      if (jitsiRoomId != null) {
        await joinMeeting(jitsiRoomId, null);
      }
    });
  }

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate!.year, _startDate!.month, _startDate!.day)
      : DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

  void setStartDate(DateTime d) {
    _startDate = d;
    fetchPatientAppointments();
    notifyListeners();
  }

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59)
      : DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  void setEndDate(DateTime d) {
    _endDate = d;
    fetchPatientAppointments();
    notifyListeners();
  }

  Future<void> fetchAllTranslator() async {
    try {
      _progress = LoadingProgress.loading;
      notifyListeners();
      _translator = await getIt<UserManager>().getAllTranslator();
      _progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      showInfoDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      _progress = LoadingProgress.error;
      notifyListeners();
    }
  }

  Future<void> requestTranslator(
    String appointmentId,
    TranslatorRequest translatorPost,
  ) async {
    try {
      await getIt<UserManager>().requestTranslator(
        appointmentId,
        translatorPost,
      );
    } on RbioDisplayException catch (e) {
      showInfoDialog(
        LocaleProvider.current.warning,
        e.message,
      );
    } catch (e) {
      showInfoDialog(
        LocaleProvider.current.warning,
        e.toString().replaceAll("Exception: ", ""),
      );
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
            requestTranslator(
              appointmentId,
              TranslatorRequest(
                interpreterId: translators[value].id,
              ),
            );
          },
        );
      },
    );
  }

  void setCancelAppointmentRequest(int id) {
    cancelAppointmentRequest = CancelAppointmentRequest(
        id: id, cancellationNote: "CancelFromMobile", cancellationReasonId: 3);
    notifyListeners();
  }

  Future<void> fetchPatientAppointments() async {
    _progress = LoadingProgress.loading;
    notifyListeners();
    try {
      _patientAppointments = await getIt<Repository>().getPatientAppointments(
        PatientAppointmentRequest(
          patientId: _patientId,
          to: endDate.toString(),
          from: startDate.toString(),
        ),
      );
      _progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      _progress = LoadingProgress.error;
      notifyListeners();
      showInfoDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
    }
  }

  Future<void> joinMeeting(String webConsultantId, int? availabilityId) async {
    //webConsultantId = webConsultantId.substring(webConsultantId.indexOf('='));
    showProgressOverlay = true;
    notifyListeners();

    try {
      if (kIsWeb) {
        if (Atom.url != PagePaths.webConferance) {
          Atom.to(
            PagePaths.webConferance,
            queryParameters: {
              'webConsultAppId': webConsultantId.toString(),
              'availability': availabilityId.toString(),
            },
          );
        }
      } else {
        if (availabilityId != null) {
          await getIt<UserManager>().startMeeting(
            mContext,
            webConsultantId,
            availabilityId,
          );
        }
      }
      showProgressOverlay = false;
      notifyListeners();
    } catch (e) {
      showProgressOverlay = false;
      notifyListeners();
      if (e.toString().contains("show")) {
        showInfoDialog(
          LocaleProvider.current.warning,
          e.toString().replaceAll("Exception: show", ""),
        );
      } else {
        showInfoDialog(
          LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction,
        );
      }
    }
  }

  Future<Uint8List?> getSelectedFile() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['svg', 'pdf', 'png', 'jpg', 'bmp']);
    PlatformFile? file = filePickerResult?.files[0];
    Uint8List? fileBytes;
    if (file != null) {
      fileBytes = file.bytes;
    }
    return fileBytes;
  }

  Future<bool> uploadFile(Uint8List file) async {
    try {
      showProgressOverlay = true;
      notifyListeners();
      await getIt<Repository>().uploadPatientDocuments(
          SecretUtils.instance.get(SecretKeys.mockAppointment),
          file.toList() as Uint8List);
      return true;
    } catch (e) {
      showInfoDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      showProgressOverlay = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> cancelAppointment() async {
    try {
      showProgressOverlay = true;
      notifyListeners();
      await getIt<Repository>().cancelAppointment(cancelAppointmentRequest);
      await fetchPatientAppointments();
      showProgressOverlay = false;
      notifyListeners();
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      showInfoDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      showProgressOverlay = false;
      notifyListeners();
    }
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
          return const NecessaryIdentityScreen();
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
    showProgressOverlay = true;
    notifyListeners();
    try {
      await getIt<Repository>().checkOnlineAppointmentPayment(
        CheckPaymentRequest(appointmentId: id),
      );
      showProgressOverlay = false;
      notifyListeners();
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> handleAppointment(PatientAppointmentsResponse data) async {
    if (data.type == R.dynamicVar.onlineAppointmentType) {
      try {
        late bool result;
        if (data.id != null) {
          result = await isOnlineAppointmentPaid(data.id!);
        }

        if (result) {
          if (data.videoGuid != null) {
            joinMeeting(data.videoGuid!, data.id);
          }
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
                  const SizedBox(
                    width: 20,
                  ),

                  //
                  GuvenAlert.buildMaterialAction(
                    LocaleProvider.of(mContext).confirm,
                    () {
                      Navigator.pop(mContext);
                      Atom.to(
                        PagePaths.appointmentSummary,
                        queryParameters: {
                          'tenantId': data.tenantId.toString(),
                          'departmentId':
                              data.resources![0].departmentId.toString(),
                          'resourceId':
                              data.resources![0].resourceId.toString(),
                          'doctorName':
                              Uri.encodeFull(data.resources![0].resource ?? ''),
                          'departmentName': Uri.encodeFull(
                              data.resources![0].department ?? ''),
                          'from': data.from ?? '',
                          'to': data.to ?? '',
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
        showProgressOverlay = false;
        notifyListeners();
        showInfoDialog(
          LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction,
        );
      }
    } else {
      if (data.id != null) {
        setCancelAppointmentRequest(data.id!);
      }

      showQuestionDialog(
        LocaleProvider.of(mContext).warning,
        LocaleProvider.of(mContext).cancel_appo_question,
      );
    }
  }
}
