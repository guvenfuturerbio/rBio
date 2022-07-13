import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../core/core.dart';

import '../../shared/necessary_identity/necessary_identity_screen.dart';
import '../model/model.dart';

part 'my_appointments_state.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState> {
  MyAppointmentsCubit(this.repository, this.userNotifier, this.sentryManager,
      String? jitsiRoomId)
      : super(MyAppointmentsState()) {
    setInitState(jitsiRoomId);
  }

  late final Repository repository;
  late final UserNotifier userNotifier;
  late final SentryManager sentryManager;
  late int _patientId;
  CancelAppointmentRequest? cancelAppointmentRequest;

  Future<void> setInitState(String? jitsiRoomId) async {
    _patientId = userNotifier.getPatient().id ?? 0;

    if (userNotifier.canAccessHospital()) {
      // await fetchAllTranslator();
      await fetchPatientAppointments();
    } else {
      showNecessary();

      if (jitsiRoomId != null) {
        await joinMeeting(jitsiRoomId, null, "");
      }
    }
  }

  Future<void> showRateDialog(int availabilityId) async {
    emit(
      state.copyWith(
        overlayStatus: MyAppointmentsOverlayStatus.showRateDialog,
        availabilityId: availabilityId,
      ),
    );
  }

  void setStartDate(DateTime value) {
    emit(
      state.copyWith(
        startDate: value,
      ),
    );
    fetchPatientAppointments();
  }

  void setEndDate(DateTime value) {
    emit(
      state.copyWith(
        endDate: value,
      ),
    );
    fetchPatientAppointments();
  }

//TODO: Burası silinmeyecek.(USBS İÇİN)
  // Future<void> fetchAllTranslator() async {
  //   final currentState = state;
  //   try {
  //     emit(currentState.copyWith(
  //         progressStatus: MyAppointmentsProgressStatus.loadingProgress));

  //     translator = await getIt<Repository>().getAllTranslator();
  //     emit(currentState.copyWith(
  //         progressStatus: MyAppointmentsProgressStatus.succes));
  //   } catch (e) {
  //     emit(currentState.copyWith(overlayStatus: MyAppointmentsOverlayStatus.showErrorDialog));
  //     _showDialog();
  //   }
  // }

  Future<void> fetchPatientAppointments() async {
    final currentState = state;
    emit(
      currentState.copyWith(
        bodyStatus: MyAppointmentsBodyStatus.loadingProgress,
      ),
    );

    try {
      final patientAppointments =
          await getIt<Repository>().getPatientAppointments(
        PatientAppointmentRequest(
          patientId: _patientId,
          to: currentState.endDate.toString(),
          from: currentState.startDate.toString(),
        ),
      );
      emit(
        currentState.copyWith(
          bodyStatus: MyAppointmentsBodyStatus.success,
          patientAppointments: patientAppointments,
        ),
      );
    } catch (e, stackTrace) {
      sentryManager.captureException(e, stackTrace: stackTrace);
      emit(
        currentState.copyWith(
          bodyStatus: MyAppointmentsBodyStatus.error,
        ),
      );
    }
  }

  void setCancelAppointmentRequest(int id) {
    cancelAppointmentRequest = CancelAppointmentRequest(
      id: id,
      cancellationNote: "CancelFromMobile",
      cancellationReasonId: 3,
    );
  }

  Future<void> joinMeeting(
    String webConsultantId,
    int? availabilityId,
    String fromDate,
  ) async {
    final currentState = state;
    //webConsultantId = webConsultantId.substring(webConsultantId.indexOf('='));
    emit(
      currentState.copyWith(
        overlayStatus: MyAppointmentsOverlayStatus.showProgressOverlay,
      ),
    );

    try {
      if (kIsWeb) {
        if (Atom.url != PagePaths.webConferance) {
          Atom.to(
            PagePaths.webConferance,
            queryParameters: {
              'webConsultAppId': webConsultantId.toString(),
              'availability': availabilityId.toString(),
              'fromDate': fromDate.toString(),
            },
          );
        }
      } else {
        if (availabilityId != null) {
          emit(
            currentState.copyWith(
                overlayStatus: MyAppointmentsOverlayStatus.joinMeeting,
                webConsultantId: webConsultantId,
                availabilityId: availabilityId,
                fromDate: fromDate),
          );
        }
      }
      emit(
        currentState.copyWith(
          overlayStatus: MyAppointmentsOverlayStatus.initial,
        ),
      );
    } catch (e, stackTrace) {
      sentryManager.captureException(e, stackTrace: stackTrace);
      _showDialog();
    }
  }

  Future<void> cancelAppointment() async {
    if (cancelAppointmentRequest == null) return;
    final currentState = state;

    try {
      emit(
        currentState.copyWith(
          overlayStatus: MyAppointmentsOverlayStatus.showProgressOverlay,
        ),
      );

      await getIt<Repository>().cancelAppointment(cancelAppointmentRequest!);
      emit(
        currentState.copyWith(
          overlayStatus: MyAppointmentsOverlayStatus.initial,
        ),
      );
      await Future.delayed(
        const Duration(
          milliseconds: 300,
        ),
      );
      await fetchPatientAppointments();
    } catch (e, stackTrace) {
      sentryManager.captureException(e, stackTrace: stackTrace);
      _showDialog();
    }
  }

  void showQuestionDialog(String title, String text) {
    final currentState = state;
    emit(
      currentState.copyWith(
        overlayStatus: MyAppointmentsOverlayStatus.questionDialog,
      ),
    );
    // showDialog(
    //     context: mContext,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return const QuestionDialog();
    //     }).then((value) async {
    //   if (value) {
    //     await cancelAppointment();
    //   } else {}
    // });
  }

  Future<void> showNecessary() async {
    final result = await Atom.show(
      const NecessaryIdentityScreen(),
      barrierDismissible: false,
    );
    if ((result ?? false) == true) {
      // await fetchAllTranslator();
      await fetchPatientAppointments();
    } else {
      Atom.historyBack();
    }
  }

  Future<bool> isOnlineAppointmentPaid(int id) async {
    final currentState = state;
    emit(currentState.copyWith(
        overlayStatus: MyAppointmentsOverlayStatus.showProgressOverlay));

    try {
      await getIt<Repository>().checkOnlineAppointmentPayment(
        CheckPaymentRequest(appointmentId: id),
      );
      emit(currentState.copyWith(
          overlayStatus: MyAppointmentsOverlayStatus.initial));

      return true;
    } on Exception {
      return false;
    }
  }

  void _doPayment(PatientAppointmentsResponse data) {
    final currentState = state;
    emit(currentState.copyWith(
      overlayStatus: MyAppointmentsOverlayStatus.doPayment,
    ));
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
            joinMeeting(
              data.videoGuid!,
              data.id,
              data.resources?.first.from ?? '',
            );
          }
        } else {
          _doPayment(data);
          // showDialog(
          //   context: mContext,
          //   barrierDismissible: true,
          //   builder: (BuildContext context) {
          //     return GuvenAlert(
          //       backgroundColor: Colors.white,
          //       title: GuvenAlert.buildTitle(
          //         LocaleProvider.current.fee_information,
          //       ),
          //       content: GuvenAlert.buildDescription(
          //         LocaleProvider.current.payment_question_tag,
          //       ),
          //       actions: [
          //         GuvenAlert.buildMaterialAction(
          //           LocaleProvider.current.btn_cancel,
          //           () {
          //             Navigator.pop(mContext);
          //           },
          //         ),

          //         //
          //         const SizedBox(
          //           width: 20,
          //         ),

          //         //
          //         GuvenAlert.buildMaterialAction(
          //           LocaleProvider.current.confirm,
          //           () {
          //             Navigator.pop(mContext);
          //             Atom.to(
          //               PagePaths.appointmentSummary,
          //               queryParameters: {
          //                 'tenantId': data.tenantId.toString(),
          //                 'departmentId':
          //                     data.resources![0].departmentId.toString(),
          //                 'resourceId':
          //                     data.resources![0].resourceId.toString(),
          //                 'doctorName':
          //                     Uri.encodeFull(data.resources![0].resource ?? ''),
          //                 'departmentName': Uri.encodeFull(
          //                     data.resources![0].department ?? ''),
          //                 'from': data.from ?? '',
          //                 'to': data.to ?? '',
          //                 'forOnline': true.toString(),
          //                 'imageUrl': data.id.toString(),
          //               },
          //             );
          //           },
          //         ),
          //       ],
          //     );
          //   },
          // );
        }
      } catch (e, stackTrace) {
        sentryManager.captureException(e, stackTrace: stackTrace);
        _showDialog();
      }
    } else {
      if (data.id != null) {
        setCancelAppointmentRequest(data.id!);
      }

      showQuestionDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.cancel_appo_question,
      );
    }
  }

  void _showDialog() {
    final currentState = state;
    emit(currentState.copyWith(
      overlayStatus: MyAppointmentsOverlayStatus.showErrorDialog,
    ));
    Future.delayed(
      const Duration(milliseconds: 250),
      () {
        emit(currentState.copyWith(
          overlayStatus: MyAppointmentsOverlayStatus.initial,
        ));
      },
    );
  }

  // Future<File?> getSelectedFile() async {
  //   FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: R.constants.supportedFileExtensions,
  //   );
  //   PlatformFile? platformFile = filePickerResult?.files[0];
  //   File? file;
  //   if (platformFile != null) {
  //     file = File(platformFile.path!);
  //   }
  //   return file;
  // }

  // Future<bool> uploadFile(File file) async {
  //   try {
  //     showProgressOverlay = true;
  //     notifyListeners();
  //     await getIt<Repository>().uploadPatientDocuments(
  //       getIt<KeyManager>().get(Keys.mockAppointment),
  //       await file.readAsBytes(),
  //     );
  //     return true;
  //   } catch (e) {
  //     showInfoDialog(
  //       LocaleProvider.current.warning,
  //       LocaleProvider.current.sorry_dont_transaction,
  //     );
  //     showProgressOverlay = false;
  //     return false;
  //   } finally {
  //     showProgressOverlay = false;
  //     notifyListeners();
  //   }
  // }
}
