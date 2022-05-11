import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../shared/necessary_identity/necessary_identity_screen.dart';
import '../../shared/rate_dialog/rate_dialog.dart';
import '../my_appointments.dart';

class AppointmentListVm extends RbioVm {
  @override
  BuildContext mContext;

  List<TranslatorResponse>? translator;
  List<PatientAppointmentsResponse>? patientAppointments;

  late int _patientId;
  bool showProgressOverlay = false;
  DateTime? _startDate, _endDate;
  CancelAppointmentRequest? cancelAppointmentRequest;

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
      : DateTime.now().subtract(const Duration(days: 15));

  void setStartDate(DateTime d) {
    _startDate = d;
    fetchPatientAppointments();
    notifyListeners();
  }

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59)
      : DateTime.now().add(const Duration(days: 15));

  void setEndDate(DateTime d) {
    _endDate = d;
    fetchPatientAppointments();
    notifyListeners();
  }

  Future<void> fetchAllTranslator() async {
    try {
      progress = LoadingProgress.loading;
      notifyListeners();
      translator = await getIt<Repository>().getAllTranslator();
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      showInfoDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      progress = LoadingProgress.error;
      notifyListeners();
    }
  }

  Future<void> requestTranslator(
    String appointmentId,
    TranslatorRequest translatorPost,
  ) async {
    try {
      await getIt<Repository>().requestTranslator(
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
          translators: translator ?? [],
          onChange: (value) {
            requestTranslator(
              appointmentId,
              TranslatorRequest(
                interpreterId: translator?[value].id,
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
    progress = LoadingProgress.loading;
    notifyListeners();
    try {
      patientAppointments = await getIt<Repository>().getPatientAppointments(
        PatientAppointmentRequest(
          patientId: _patientId,
          to: endDate.toString(),
          from: startDate.toString(),
        ),
      );
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      progress = LoadingProgress.error;
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

  Future<File?> getSelectedFile() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: R.constants.supportedFileExtensions,
    );
    PlatformFile? platformFile = filePickerResult?.files[0];
    File? file;
    if (platformFile != null) {
      file = File(platformFile.path!);
    }
    return file;
  }

  Future<bool> uploadFile(File file) async {
    try {
      showProgressOverlay = true;
      notifyListeners();
      await getIt<Repository>().uploadPatientDocuments(
        getIt<KeyManager>().get(Keys.mockAppointment),
        await file.readAsBytes(),
      );
      return true;
    } catch (e) {
      showInfoDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      showProgressOverlay = false;
      return false;
    } finally {
      showProgressOverlay = false;
      notifyListeners();
    }
  }

  Future<void> cancelAppointment() async {
    if (cancelAppointmentRequest == null) return;

    try {
      showProgressOverlay = true;
      notifyListeners();
      await getIt<Repository>().cancelAppointment(cancelAppointmentRequest!);
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
          return QuestionDialog(
            title: title,
            text: text,
          );
        }).then((value) async {
      if (value) {
        await cancelAppointment();
      } else {}
    });
  }

  Future<void> showNecessary() async {
    final result = await Atom.show(
      const NecessaryIdentityScreen(),
      barrierDismissible: false,
    );

    if ((result ?? false) == true) {
      await fetchAllTranslator();
      await fetchPatientAppointments();
    } else {
      Atom.historyBack();
    }
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
    if (data.type == R.constants.onlineAppointmentType) {
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
