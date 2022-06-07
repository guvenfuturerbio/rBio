import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../features/auth/auth.dart';
import '../../features/chat/controller/chat_vm.dart';
import '../../features/chat/view/chat_screen.dart';
import '../../features/chat/view/consultation_screen.dart';
import '../../features/chronic_tracking/blood_glucose/blood_glucose.dart';
import '../../features/chronic_tracking/blood_pressure/blood_pressure.dart';
import '../../features/chronic_tracking/home/view/mt_home_screen.dart';
import '../../features/chronic_tracking/scale/scale.dart';
import '../../features/chronic_tracking/treatment/treatment_detail/view/treatment_edit_view.dart';
import '../../features/chronic_tracking/treatment/treatment_process/view/treatment_process_screen.dart';
import '../../features/dashboard/search/doctor_cv/doctor_cv_screen.dart';
import '../../features/detailed_symptom/detailed_symptom_checker.dart';
import '../../features/doctor/home/view/doctor_home_screen.dart';
import '../../features/doctor/patient_detail/blood_glucose/blood_glucose.dart';
import '../../features/doctor/patient_detail/blood_pressure/blood_pressure.dart';
import '../../features/doctor/patient_detail/scale/view/scale_patient_detail_screen.dart';
import '../../features/doctor/patient_list/view/patient_list_screen.dart';
import '../../features/doctor/patient_treatment_edit/view/patient_treatment_edit_view.dart';
import '../../features/doctor/treatment/diet_add_edit/view/doctor_scale_diet_add_edit_screen.dart';
import '../../features/doctor/treatment/doctor_note_add_edit/doctor_note_add_edit.dart';
import '../../features/doctor/treatment/treatment_add_edit/view/doctor_scale_treatment_add_edit_screen.dart';
import '../../features/doctor/treatment/treatment_list/view/doctor_scale_treatment_list_screen.dart';
import '../../features/doctor/treatment_process/view/treatment_process_screen.dart';
import '../../features/mediminder/mediminder.dart';
import '../../features/my_appointments/my_appointments.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/profile/devices/devices.dart';
import '../../features/profile/health_information/view/health_information_screen.dart';
import '../../features/profile/magazines/magazine_detail.dart';
import '../../features/profile/magazines/magazine_view.dart';
import '../../features/profile/personal_information/view/personal_information_screen.dart';
import '../../features/profile/profile/view/profile_screen.dart';
import '../../features/profile/profile/viewmodel/profile_vm.dart';
import '../../features/profile/request_suggestions/view/request_suggestions_screen.dart';
import '../../features/profile/terms_and_privacy/terms_and_privacy.dart';
import '../../features/relatives/add_patient_relative/view/add_relative_screen.dart';
import '../../features/relatives/patient_relatives/relatives.dart';
import '../../features/results/results.dart';
import '../../features/shared/full_pdf_viewer_screen.dart';
import '../../features/shared/webview_screen.dart';
import '../../features/store/covid_19/covid_19_screen.dart';
import '../../features/store/credit_card/credit_card_screen.dart';
import '../../features/store/for_you_categories/view/for_you_categories_screen.dart';
import '../../features/store/for_you_order_summary/order_summary.dart';
import '../../features/store/for_you_sub_categories/view/for_you_sub_categories_screen.dart';
import '../../features/store/for_you_sub_category_detail/for_you_sub_categories_detail_screen.dart';
import '../../features/store/shopping_cart/shopping_cart_screen.dart';
import '../../features/symptom_checker/home/view/symptoms_home_screen.dart';
import '../../features/symptom_checker/symptoms_body_location/view/symptoms_body_locations_screen.dart';
import '../../features/symptom_checker/symptoms_body_sublocations_page/view/symptoms_body_sublocations_page.dart';
import '../../features/symptom_checker/symptoms_body_symptoms_page/view/symptoms_body_symptoms_page.dart';
import '../../features/symptom_checker/symptoms_result_page/view/symptoms_result_page.dart';
import '../../features/take_appointment/create_appointment/view/create_appointment_screen.dart';
import '../../features/take_appointment/create_appointment_events/view/create_appointment_events_screen.dart';
import '../../features/take_appointment/create_appointment_summary/view/create_appointment_summary_screen.dart';
import '../core.dart';

class VRouterRoutes {
  static routes(IAppConfig config) => [
        // #region Auth
        VWidget(
          path: PagePaths.changePassword,
          widget: const ChangePasswordScreen(),
        ),

        VWidget(
          path: PagePaths.forgotPasswordStep1,
          widget: const ForgotPasswordStep1Screen(),
        ),

        VWidget(
          path: PagePaths.forgotPasswordStep2,
          widget: const ForgotPasswordStep2Screen(),
        ),

        VWidget(
          path: PagePaths.login,
          widget: const LoginScreen(),
        ),

        VWidget(
          path: PagePaths.registerStep1,
          widget: const RegisterStep1Screen(),
        ),

        VWidget(
          path: PagePaths.registerStep2,
          widget: const RegisterStep2Screen(),
        ),

        VWidget(
          path: PagePaths.registerStep3,
          widget: const RegisterStep3Screen(),
        ),
        // #endregion

        // #region Chat
        VGuard(
          beforeEnter: (vRedirector) async {
            if (!(getIt<UserNotifier>().isCronic ||
                getIt<UserNotifier>().isDoctor)) {
              vRedirector.stopRedirection();
              Atom.show(const NotChronicWarning());
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.consultation,
              widget: const ConsultationScreen(),
              stackedRoutes: [
                VWidget(
                  path: PagePaths.chat,
                  widget: ChangeNotifierProvider<ChatVm>(
                    create: (context) => ChatVm(),
                    child: const ChatScreen(key: Key('ChatScreen')),
                  ),
                ),
              ],
            ),
          ],
        ),
        // #endregion

        // #region Chronic Tracking
        VGuard(
          beforeEnter: (vRedirector) async {
            if (!getIt<IAppConfig>().functionality.chronicTracking) {
              openDefaultScreen(vRedirector);
            } else if (!getIt<UserNotifier>().isCronic) {
              vRedirector.stopRedirection();
              Atom.show(const NotChronicWarning());
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.measurementTrackingHome,
              widget: const MeasurementTrackingHomeScreen(),
              stackedRoutes: [
                VWidget(
                  path: PagePaths.bloodGlucoseProgress,
                  widget: const BgProgressScreen(),
                ),
                VWidget(
                  path: PagePaths.bpProgress,
                  widget: const BpProgressScreen(),
                ),
                VGuard(
                  stackedRoutes: [
                    VWidget(
                      path: PagePaths.scaleDetail,
                      widget: const ScaleDetailScreen(),
                    ),
                    VWidget(
                      path: PagePaths.patientScaleTreatmentList,
                      widget: const PatientScaleTreatmentListScreen(),
                    ),
                    VWidget(
                      path: PagePaths.patientScaleDietDetail,
                      widget: const PatientScaleDietDetailScreen(),
                    ),
                    VWidget(
                      path: PagePaths.patientScaleTreatmentDetail,
                      widget: const PatientScaleTreatmentDetailScreen(),
                    ),
                  ],
                ),
                VWidget(
                  path: PagePaths.scaleManuelAdd,
                  widget: const ScaleManuelAddScreen(),
                ),
              ],
            ),
          ],
        ),

        VGuard(
          beforeEnter: (vRedirector) async {
            if (!getIt<UserNotifier>().isCronic) {
              vRedirector.stopRedirection();
              Atom.show(const NotChronicWarning());
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.treatmentEditProgress,
              widget: const TreatmentEditView(),
            ),
          ],
        ),

        VGuard(
          beforeEnter: (vRedirector) async {
            if (!getIt<UserNotifier>().isCronic) {
              vRedirector.stopRedirection();
              Atom.show(const NotChronicWarning());
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.treatmentProgress,
              widget: const TreatmentProcessScreen(),
            )
          ],
        ),
        // #endregion

        // #region Dashboard
        VGuard(
          beforeEnter: (vRedirector) async {
            if (getIt<IAppConfig>().functionality.relatives) {
              if ((await getIt<UserNotifier>().checkAccessToken()) == false) {
                vRedirector.to(PagePaths.login);
              }
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.main,
              widget: Container(),
              stackedRoutes: [
                config.getDashboard(),
              ],
            ),
          ],
        ),

        VWidget(
          path: PagePaths.doctorCv,
          widget: DoctorCvScreen(),
        ),
        // #endregion

        // #region Detailed Symptom
        VWidget(
          path: PagePaths.detailedSymptom,
          widget: const DetailedSymptomChecker(),
        ),
        // #endregion

        // #region Doctor
        VWidget(
          path: PagePaths.doctorHome,
          widget: const DoctorHomeScreen(),
          stackedRoutes: [
            VWidget(
              path: PagePaths.doctorPatientList,
              widget: DoctorPatientListScreen(),
              stackedRoutes: [
                VWidget(
                  path: PagePaths.doctorGlucosePatientDetailL,
                  widget: const BgPatientDetailScreen(),
                ),
                VWidget(
                  path: PagePaths.doctorPressurePatientDetail,
                  widget: const BpPatientDetailScreen(),
                ),
                VWidget(
                  path: PagePaths.doctorBmiPatientDetail,
                  widget: const ScalePatientDetailScreen(),
                ),
                VWidget(
                  path: PagePaths.doctorTreatmentProgress,
                  widget: const DoctorTreatmentProcessScreen(),
                  stackedRoutes: [
                    VWidget(
                      path: PagePaths.doctorTreatmentEdit,
                      widget: const PatientTreatmentEditView(),
                    ),
                  ],
                ),
                VWidget(
                  path: PagePaths.doctorCosultation,
                  widget: const ConsultationScreen(),
                ),
                VWidget(
                  path: PagePaths.doctorScaleTreatmentList,
                  widget: const DoctorScaleTreatmentListScreen(),
                ),
                VWidget(
                  path: PagePaths.doctorScaleDietAddEdit,
                  widget: const DoctorScaleDietAddEditScreen(),
                ),
                VWidget(
                  path: PagePaths.doctorScaleTreatmentAddEdit,
                  widget: const DoctorScaleTreatmentAddEditScreen(),
                ),
                VWidget(
                  path: PagePaths.doctorScaleDoctorNoteAddEdit,
                  widget: const DoctorScaleDoctorNoteAddEditScreen(),
                ),
              ],
            ),
          ],
        ),
        // #endregion

        // #region Mediminder
        VGuard(
          beforeEnter: (vRedirector) async {
            if (!getIt<IAppConfig>().functionality.mediminder) {
              openDefaultScreen(vRedirector);
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.reminderList,
              widget: const ReminderListScreen(),
            ),
            VWidget(
              path: PagePaths.selectReminder,
              widget: const SelectReminderScreen(),
            ),
            VWidget(
              path: PagePaths.bloodGlucoseReminderAddEdit,
              widget: const BloodGlucoseReminderAddEditScreen(),
            ),
            VWidget(
              path: PagePaths.medicationReminderAddEdit,
              widget: const MedicationReminderAddEditScreen(),
            ),
            VWidget(
              path: PagePaths.hba1cReminderAddEdit,
              widget: const Hba1cReminderAddEditScreen(),
            ),
            VWidget(
              path: PagePaths.reminderDetail,
              widget: const ReminderDetailScreen(),
            ),
            VGuard(
              beforeEnter: (vRedirector) async {
                Future<void> showAlert() async {
                  await Atom.show(
                    GuvenAlert(
                      backgroundColor:
                          getIt<IAppConfig>().theme.cardBackgroundColor,
                      title: GuvenAlert.buildTitle(LocaleProvider.current.info),
                      content: GuvenAlert.buildDescription(
                        LocaleProvider.current.device_register,
                      ),
                      actions: [
                        //
                        GuvenAlert.buildMaterialAction(
                          LocaleProvider.current.Ok,
                          () {
                            Atom.dismiss();
                            vRedirector.to(PagePaths.allDevices);
                          },
                        ),
                      ],
                    ),
                  );
                }

                final pairedDevices =
                    getIt<BleDeviceManager>().getPairedDevices();
                if (pairedDevices.isEmpty) {
                  await showAlert();
                  //vRedirector.stopRedirection();
                } else {
                  final hasSugarDevice = pairedDevices.any((item) =>
                      item.deviceType == DeviceType.accuCheck ||
                      item.deviceType == DeviceType.contourPlusOne);
                  if (!hasSugarDevice) {
                    await showAlert();
                    vRedirector.stopRedirection();
                  }
                }
              },
              stackedRoutes: [
                VWidget(
                  path: PagePaths.strip,
                  widget: const StripReminderAddEditScreen(),
                ),
              ],
            ),
          ],
        ),
        // #endregion

        // #region My Appointments
        VWidget(
          path: PagePaths.allFiles,
          widget: const AllFilesScreen(),
        ),

        VWidget(
          path: PagePaths.appointment,
          widget: const AppointmentListScreen(),
        ),

        VWidget(
          path: PagePaths.webConferance,
          widget: WebConferanceScreen(),
        ),
        // #endregion

        // #region Profile
        VWidget(
          path: PagePaths.allDevices,
          widget: const AvailableDevices(),
        ),

        VWidget(
          path: PagePaths.selectedDevice,
          widget: SelectedDevicesScreen(),
        ),

        VGuard(
          beforeEnter: (vRedirector) async {
            if (!getIt<UserNotifier>().isCronic) {
              vRedirector.stopRedirection();
              Atom.show(const NotChronicWarning());
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.devices,
              widget: const DevicesScreen(),
            ),
          ],
        ),

        VGuard(
          beforeEnter: (vRedirector) async {
            if (!getIt<UserNotifier>().isCronic) {
              vRedirector.stopRedirection();
              Atom.show(const NotChronicWarning());
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.healthInformation,
              widget: const HealthInformationScreen(),
            ),
          ],
        ),

        VWidget(
          path: PagePaths.personalInformation,
          widget: const PersonalInformationScreen(),
        ),

        VWidget(
          path: PagePaths.profile,
          widget: ChangeNotifierProvider<ProfileVm>(
            create: (context) => ProfileVm(context),
            child: const ProfileScreen(),
          ),
          stackedRoutes: [
            VWidget(
              path: PagePaths.suggestResult,
              widget: const RequestSuggestionsScreen(),
            ),
          ],
        ),

        VWidget(
          path: PagePaths.termsAndPrivacy,
          widget: const TermsAndPrivacyScreen(),
        ),

        VWidget(
          path: PagePaths.deviceSearch,
          widget: DeviceSearchScreen(),
        ),
        // #endregion

        // #region Onboarding
        VWidget(
          path: PagePaths.onboarding,
          widget: const OnboardingScreen(),
        ),
        // #endregion

        // #region Relatives

        VGuard(
          beforeEnter: (vRedirector) async {
            if (!getIt<IAppConfig>().functionality.relatives) {
              openDefaultScreen(vRedirector);
            }
          },
          stackedRoutes: [
            //
            VWidget(
              path: PagePaths.relatives,
              widget: const PatientRelativesScreen(),
            ),

            //
            VWidget(
              path: PagePaths.addPatientRelatives,
              widget: const AddPatientRelativeScreen(),
            ),
          ],
        ),
        // #endregion

        // #region EResult
        VWidget(
          path: PagePaths.eResult,
          widget: ChangeNotifierProvider<EResultScreenVm>(
            create: (context) => EResultScreenVm(context),
            child: const EResultScreen(),
          ),
        ),

        VWidget(
          path: PagePaths.visitDetail,
          widget: VisitDetailScreen(),
        ),
        // #endregion

        // #region Store
        VWidget(
          path: PagePaths.covid19,
          widget: const Covid19Screen(key: Key('Covid19Screen')),
        ),

        VWidget(
          path: PagePaths.creditCard,
          widget: CreditCardScreen(),
        ),

        VWidget(
          path: PagePaths.forYouCategories,
          widget: const ForYouCategoriesScreen(),
        ),

        VWidget(
          path: PagePaths.orderSummary,
          widget: OrderSummaryScreen(),
        ),

        VWidget(
          path: PagePaths.forYouSubCategories,
          widget: ForYouSubCategoriesScreen(),
        ),

        VWidget(
          path: PagePaths.forYouSubCategoriesDetail,
          widget: ForYouSubCategoriesDetailScreen(),
        ),

        VWidget(
          path: PagePaths.shoppingChart,
          widget: const ShoppingCartScreen(),
        ),
        // #endregion

        // #region Symptom Checker
        VGuard(
          beforeEnter: (vRedirector) async {
            if (!getIt<IAppConfig>().functionality.symptomChecker) {
              openDefaultScreen(vRedirector);
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.symptomMainMenu,
              widget: const SymptomsHomeScreen(),
              stackedRoutes: [
                VWidget(
                  path: PagePaths.symptomBodyLocations,
                  widget: const SymptomsBodyLocationsScreen(),
                  stackedRoutes: [
                    VWidget(
                      path: PagePaths.symptomSubBodyLocations,
                      widget: BodySubLocationsPage(),
                      stackedRoutes: [
                        VWidget(
                          path: PagePaths.symptomSelectPage,
                          widget: BodySymptomsSelectionPage(),
                          stackedRoutes: [
                            VWidget(
                              path: PagePaths.symptomResultPage,
                              widget: SymptomsResultPage(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // #endregion

        // #region Take Appointment
        VGuard(
          beforeEnter: (vRedirector) async {
            if (vRedirector.toUrl?.contains('forOnline=true') ?? false) {
              if (!getIt<IAppConfig>().functionality.takeOnlineAppointment) {
                vRedirector.to(PagePaths.main);
              }
            } else if (vRedirector.toUrl?.contains('forOnline=false') ??
                false) {
              if (!getIt<IAppConfig>().functionality.takeHospitalAppointment) {
                vRedirector.to(PagePaths.main);
              }
            }
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.createAppointment,
              widget: CreateAppointmentScreen(),
              stackedRoutes: [
                VWidget(
                  path: PagePaths.createAppointmentEvents,
                  widget: CreateAppointmentEventsScreen(),
                  stackedRoutes: [
                    VWidget(
                      path: PagePaths.createAppointmentSummary,
                      widget: const CreateAppointmentSummaryScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // #endregion

        VWidget(
          path: PagePaths.webView,
          widget: WebViewScreen(),
        ),

        VWidget(
          path: PagePaths.magazinselection,
          widget: const MagazineSelectionPage(),
        ),
        VWidget(
          path: PagePaths.magazines,
          widget: const MagazinesWebView(),
        ),

        VWidget(
          path: PagePaths.fullPdfViewer,
          widget: FullPdfViewerScreen(),
        ),

        //
        // :_ is a path parameters named _
        // .+ is a regexp to match any path
        VRouteRedirector(
          path: r':_(.+)',
          redirectTo: '/home',
        ),
      ];
}

class PagePaths {
  PagePaths._();
  // #region Auth
  static const changePassword = '/change-password';
  static const forgotPasswordStep1 = '/forgot-password';
  static const forgotPasswordStep2 = '/change-password-with-old';
  static const login = '/login';
  static const registerStep1 = '/register-1';
  static const registerStep2 = '/register-2';
  static const registerStep3 = '/register-3';
  static loginWithSuccessChangePassword() => '/login?changePassword=true';
  static const registerStep1Intro = '/register-1?from=intro';
  // #endregion

  // #region Chat
  static const consultation = '/e-consultation';
  static const chat = '/chat';
  // #endregion

  // #region Chronic Tracking
  static const measurementTrackingHome = '/measurement-tracking-home';
  static const bloodGlucoseProgress = '/blood-glucose-progress';
  static const bpProgress = '/blood-pressure-progress';
  static const treatmentProgress = '/treatment-progress';
  static const treatmentEditProgress = '/tretment-edit-progress';
  static const scaleDetail = '/scale-detail';
  static const scaleManuelAdd = '/scale-manuel-add';

  static const patientScaleTreatmentList =
      "/scale-detail/patient-scale-treatment-list";
  static const patientScaleDietDetail =
      "/scale-detail/patient-scale-diet-detail";
  static const patientScaleTreatmentDetail =
      "/scale-detail/patient-scale-treatment-detail";
  // #endregion

  // #region Dashboard
  static const main = '/home';
  static const doctorCv = '/doctor-cv';
  // #endregion

  // #region Detailed Symptom
  static const detailedSymptom = '/detailed-symptom';
  // #endregion

  // #region Doctor
  static const doctorHome = '/doctor';
  static const doctorPatientList = '/doctor-patient-list';
  static const doctorGlucosePatientDetailL = '/blood-glucose-patient-detail';
  static const doctorBmiPatientDetail = '/bmi-patient-detail';
  static const doctorPressurePatientDetail = '/bp-patient-detail';
  static const doctorTreatmentProgress = '/doctor-treatment_process';
  static const doctorTreatmentEdit = '/doctor-patient-treatment-edit';
  static const doctorCosultation = '/doctor-consultation';

  static const doctorScaleTreatmentList = '/doctor-scale-treatment-list';
  static const doctorScaleDietAddEdit = '/doctor-scale-diet-add-edit';
  static const doctorScaleTreatmentAddEdit = '/doctor-scale-treatment-add-edit';
  static const doctorScaleDoctorNoteAddEdit =
      '/doctor-scale-doctor-note-add-edit';
  // #endregion

  // #region Mediminder
  static const reminderList = "/reminder-list";
  static const selectReminder = '/select-reminder';
  static const bloodGlucoseReminderAddEdit = '/reminder/blood-glucose-add-edit';
  static const medicationReminderAddEdit = '/reminder/medication-add-edit';
  static const hba1cReminderAddEdit = '/reminder/hba1c-add-edit';
  static const reminderDetail = '/reminder/reminder-detail';
  static const strip = '/reminder/strips';
  // #endregion

  // #region My Appointments
  static const allFiles = '/all-files';
  static const appointment = '/appointments';
  static const webConferance = '/web-conferance';
  static const doMobilePayment = '/online-payment';
  // #endregion

  // #region Profile
  static const allDevices = '/available_devices';
  static const selectedDevice = '/selected_device/';
  static const devices = '/devices';
  static const healthInformation = '/health-information';
  static const personalInformation = '/personel-info';
  static const profile = '/profile';
  static const suggestResult = '/suggest-request';
  static const termsAndPrivacy = '/terms-and-privacy';
  static const deviceSearch = '/device-search';
  // #endregion

  // #region Onboarding
  static const onboarding = '/onboarding';
  // #endregion

  // #region Relatives
  static const relatives = '/relatives';
  static const addPatientRelatives = '/add-patient-relatives';
  // #endregion

  // #region Symptom Checker
  static const symptomMainMenu = '/symptom-main';
  static const symptomBodyLocations = '/symptom-body-locations';
  static const symptomSubBodyLocations = '/symptom-sub-body-locations';
  static const symptomSelectPage = '/symptom-selection-page';
  static const symptomResultPage = '/symptom-result-page';
  // #endregion

  // #region Take Appointment
  static const createAppointment = '/create-appointment';
  static const createAppointmentEvents = '/create-appointment-events';
  static const createAppointmentSummary = '/create-appointment-summary';
  static const appointmentSummary = '/appointment-summary';
  // #endregion

  // #region Store
  static const covid19 = '/covid19';
  static const creditCard = '/credit-card';
  static const forYouCategories = '/for-you';
  static const orderSummary = '/order-summary';
  static const forYouSubCategories = '/for-you-categories';
  static const forYouSubCategoriesDetail = '/for-you-categories-detail';
  static const shoppingChart = '/shopping-cart';
  // #endregion

  // #region Eresult
  static const eResult = '/results';
  static const visitDetail = '/visit-detail';
  // #endregion

  static const webView = '/webview';
  static const fullPdfViewer = '/full-pdf-viewer';
  static const iyzicoResponseSmsPayment = '/form-submit';
  static const magazines = '/magazine-detail';
  static const magazinselection = '/magazines';
}

void openDefaultScreen(VRedirector vRedirector) {
  vRedirector.to(PagePaths.main);
}
