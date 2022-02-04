import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../features/auth/auth.dart';
import '../../features/chat/controller/chat_vm.dart';
import '../../features/chat/view/chat_screen.dart';
import '../../features/chat/view/consultation_screen.dart';
import '../../features/chronic_tracking/home/view/mt_home_screen.dart';
import '../../features/chronic_tracking/progress_sections/glucose_progress/view/bg_progress_page.dart';
import '../../features/chronic_tracking/progress_sections/pressure_progress/view/pressure_progres_page.dart';
import '../../features/chronic_tracking/progress_sections/scale_progress/view/scale_progress_page.dart';
import '../../features/chronic_tracking/treatment/treatment_detail/view/treatment_edit_view.dart';
import '../../features/chronic_tracking/treatment/treatment_process/view/treatment_process_screen.dart';
import '../../features/dashboard/dashboard_navigation.dart';
import '../../features/detailed_symptom/detailed_symptom_checker.dart';
import '../../features/doctor/blood_glucose_patient_detail/view/blood_glucose_patient_detail_screen.dart';
import '../../features/doctor/blood_pressure_patient_detail/view/blood_pressure_detail_screen.dart';
import '../../features/doctor/bmi_patient_detail/view/bmi_patient_detail_screen.dart';
import '../../features/doctor/home/view/doctor_home_screen.dart';
import '../../features/doctor/patient_list/view/patient_list_screen.dart';
import '../../features/doctor/patient_treatment_edit/view/patient_treatment_edit_view.dart';
import '../../features/doctor/treatment_process/view/treatment_process_screen.dart';
import '../../features/mediminder/view/hba1c_reminder_add_screen.dart';
import '../../features/mediminder/view/hba1c_reminderlist_screen.dart';
import '../../features/mediminder/view/home_mediminder_screen.dart';
import '../../features/mediminder/view/medication_date_screen.dart';
import '../../features/mediminder/view/medication_period_selection_screen.dart';
import '../../features/mediminder/view/medication_screen.dart';
import '../../features/mediminder/view/strip_screen.dart';
import '../../features/my_appointments/all_files_screen.dart';
import '../../features/my_appointments/appointment_list_screen.dart';
import '../../features/my_appointments/web_conferance_screen.dart';
import '../../features/profile/devices/devices.dart';
import '../../features/profile/health_information/view/health_information_screen.dart';
import '../../features/profile/personal_information/view/personal_information_screen.dart';
import '../../features/profile/profile/view/profile_screen.dart';
import '../../features/profile/profile/viewmodel/profile_vm.dart';
import '../../features/profile/request_suggestions/view/request_suggestions_screen.dart';
import '../../features/profile/terms_and_privacy/terms_and_privacy.dart';
import '../../features/relatives/relatives.dart';
import '../../features/results/e_result_screen.dart';
import '../../features/results/e_result_vm.dart';
import '../../features/results/visit_detail_screen.dart';
import '../../features/search/search_screen.dart';
import '../../features/shared/full_pdf_viewer_screen.dart';
import '../../features/shared/webview_screen.dart';
import '../../features/store/covid_19/covid_19_screen.dart';
import '../../features/store/credit_card/credit_card_screen.dart';
import '../../features/store/for_you_categories/for_you_categories_screen.dart';
import '../../features/store/for_you_order_summary/order_summary.dart';
import '../../features/store/for_you_sub_categories/for_you_sub_categories_screen.dart';
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
import '../../features/take_appointment/doctor_cv/doctor_cv_screen.dart';
import '../core.dart';
import '../widgets/chronic_error_alert.dart';

class VRouterRoutes {
  static var routes = [
    VWidget(
      path: PagePaths.login,
      widget: const LoginScreen(),
    ),

    VWidget(
      path: PagePaths.main,
      widget: Container(),
      stackedRoutes: [
        DashboardNavigation(),
      ],
    ),
    // VWidget(
    //   path: PagePaths.MAIN,
    //   widget: HomeScreen(),
    // ),

    VWidget(
      path: PagePaths.profile,
      widget: ChangeNotifierProvider<ProfileVm>(
        create: (context) => ProfileVm(),
        child: const ProfileScreen(),
      ),
      stackedRoutes: [
        //
        VWidget(
          path: PagePaths.suggestResult,
          widget: const RequestSuggestionsScreen(),
        ),
      ],
    ),

    VWidget(
      path: PagePaths.detailedSymptom,
      widget: const DetailedSymptomChecker(),
    ),

    VWidget(
      path: PagePaths.personalInformation,
      widget: const PersonalInformationScreen(),
    ),

    VWidget(
      path: PagePaths.devices,
      widget: const DevicesScreen(),
    ),

    VWidget(
      path: PagePaths.allDevices,
      widget: const AvailableDevices(),
    ),

    VWidget(
      path: PagePaths.selectedDevice,
      widget: SelectedDevicesScreen(),
    ),

    VWidget(
      path: PagePaths.searchPage,
      widget: const SearchScreen(),
    ),

    // Create Appointment
    VGuard(
      beforeEnter: (vRedirector) async {
        if (vRedirector.toUrl?.contains('forOnline=true') ?? false) {
          if (!getIt<AppConfig>().takeOnlineAppointment) {
            vRedirector.to(PagePaths.main);
          }
        } else if (vRedirector.toUrl?.contains('forOnline=false') ?? false) {
          if (!getIt<AppConfig>().takeHospitalAppointment) {
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
                  widget: CreateAppointmentSummaryScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    VWidget(
      path: PagePaths.registerStep1,
      widget: const RegisterStep1Screen(key: Key('RegisterStep1Screen')),
    ),

    VWidget(
      path: PagePaths.registerStep2,
      widget: RegisterStep2Screen(),
    ),

    VWidget(
      path: PagePaths.registerStep3,
      widget: RegisterStep3Screen(),
    ),

    VWidget(
      path: PagePaths.forgotPasswordStep1,
      widget: const ForgotPasswordStep1Screen(
          key: Key('ForgotPasswordStep1Screen')),
    ),

    VWidget(
      path: PagePaths.forgotPasswordStep2,
      widget: ForgotPasswordStep2Screen(),
    ),

    VWidget(
      path: PagePaths.doctorCv,
      widget: DoctorCvScreen(),
    ),

    VWidget(
      path: PagePaths.covid19,
      widget: const Covid19Screen(key: Key('Covid19Screen')),
    ),

    VWidget(
      path: PagePaths.eResult,
      widget: ChangeNotifierProvider<EResultScreenVm>(
        create: (context) => EResultScreenVm(context),
        child: const EResultScreen(key: Key('EResultScreen')),
      ),
    ),

    VWidget(
      path: PagePaths.visitDetail,
      widget: VisitDetailScreen(),
    ),

    VWidget(
      path: PagePaths.forYouCategories,
      widget: const ForYouCategoriesScreen(key: Key('ForYouCategoriesScreen')),
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
      path: PagePaths.orderSummary,
      widget: OrderSummaryScreen(),
    ),

    VWidget(
      path: PagePaths.allFiles,
      widget: const AllFilesScreen(key: Key('AllFilesScreen')),
    ),

    VWidget(
      path: PagePaths.relatives,
      widget: ChangeNotifierProvider<RelativesVm>(
        create: (context) => RelativesVm(),
        child: const RelativesScreen(),
      ),
    ),

    VWidget(
      path: PagePaths.changePassword,
      widget: const ChangePasswordScreen(key: Key('ChangePasswordScreen')),
    ),

    VWidget(
      path: PagePaths.appointment,
      widget: AppointmentListScreen(),
    ),

    VWidget(
      path: PagePaths.shoppingChart,
      widget: const ShoppingCartScreen(key: Key('ShoppingCartScreen')),
    ),

    VWidget(
      path: PagePaths.creditCard,
      widget: CreditCardScreen(),
    ),

    VWidget(
      path: PagePaths.webView,
      widget: WebViewScreen(),
    ),

    VWidget(
      path: PagePaths.addPatientRelatives,
      widget: const AddPatientRelativesScreen(
          key: Key('AddPatientRelativesScreen')),
    ),

    VWidget(
      path: PagePaths.fullPdfViewer,
      widget: FullPdfViewerScreen(),
    ),
    VWidget(
      path: PagePaths.termsAndPrivacy,
      widget: const TermsAndPrivacyScreen(key: Key('TermsAndPrivacyScreen')),
    ),
    VWidget(
      path: PagePaths.webConferance,
      widget: WebConferanceScreen(),
    ),

    VGuard(
      beforeEnter: (vRedirector) async {
        if (!(getIt<UserNotifier>().isCronic ||
            getIt<UserNotifier>().isDoctor)) {
          vRedirector.stopRedirection();
          Atom.show(NotChronicWarning());
        } else {
          FlutterAppBadger.removeBadge();
        }
      },
      stackedRoutes: [
        VWidget(
          path: PagePaths.consultation,
          widget: ConsultationScreen(),
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

    // Symptom Checker
    VGuard(
      beforeEnter: (vRedirector) async {
        if (!getIt<AppConfig>().symptomChecker) {
          vRedirector.to(PagePaths.main);
        }
      },
      stackedRoutes: [
        VWidget(
          path: PagePaths.symptomMainMenu,
          widget: const SymptomsHomeScreen(key: Key('SymptomsHomeScreen')),
        ),
        VWidget(
          path: PagePaths.symptomBodyLocations,
          widget: SymptomsBodyLocationsScreen(),
        ),
        VWidget(
          path: PagePaths.symptomSubBodyLocations,
          widget: BodySubLocationsPage(),
        ),
        VWidget(
          path: PagePaths.symptomSelectPage,
          widget: BodySymptomsSelectionPage(),
        ),
        VWidget(
          path: PagePaths.symptomResultPage,
          widget: SymptomsResultPage(),
        ),
      ],
    ),

    VGuard(
      beforeEnter: (vRedirector) async {
        if (!getIt<UserNotifier>().isCronic) {
          vRedirector.stopRedirection();
          Atom.show(NotChronicWarning());
        }
      },
      stackedRoutes: [
        VWidget(
            path: PagePaths.measurementTracking,
            widget: const MeasurementTrackingHomeScreen(),
            stackedRoutes: [
              VWidget(
                path: PagePaths.bmiProgress,
                widget: const ScaleProgressPage(key: Key('ScaleProgressPage')),
              ),
              VWidget(
                path: PagePaths.bpProgress,
                widget: const BpProgressPage(key: Key('BpProgressPage')),
              ),
              VWidget(
                path: PagePaths.bloodGlucoseProgress,
                widget: const BgProgressPage(key: Key('BgProgressPage')),
              ),
            ]),
      ],
    ),
    VGuard(
        beforeEnter: (vRedirector) async {
          if (!getIt<UserNotifier>().isCronic) {
            vRedirector.stopRedirection();
            Atom.show(NotChronicWarning());
          }
        },
        stackedRoutes: [
          VWidget(
              path: PagePaths.treatmentProgress,
              widget: TreatmentProcessScreen())
        ]),
    VGuard(
        beforeEnter: (vRedirector) async {
          if (!getIt<UserNotifier>().isCronic) {
            vRedirector.stopRedirection();
            Atom.show(NotChronicWarning());
          }
        },
        stackedRoutes: [
          VWidget(
              path: PagePaths.treatmentEditProgress,
              widget: const TreatmentEditView(key: Key('TreatmentEditView')))
        ]),

    // Mediminder
    VGuard(
      beforeEnter: (vRedirector) async {
        if (!getIt<AppConfig>().mediminder) {
          vRedirector.to(PagePaths.main);
        }
      },
      stackedRoutes: [
        VWidget(
          path: PagePaths.mediminderInitial,
          widget: const HomeMediminderScreen(key: Key('HomeMediminderScreen')),
        ),
        VWidget(
          path: PagePaths.medicationPage,
          widget: MedicationScreen(),
        ),
        VWidget(
          path: PagePaths.medicationPeriod,
          widget: MedicationPeriodSelectionScreen(),
        ),
        VWidget(
          path: PagePaths.medicationDate,
          widget: MedicationDateScreen(),
        ),
        VWidget(
          path: PagePaths.hba1cReminderAdd,
          widget: Hba1cReminderAddScreen(),
        ),
        VWidget(
          path: PagePaths.hba1cList,
          widget: Hba1cReminderListScreen(),
        ),
        VWidget(
          path: PagePaths.bloodGlucosePage,
          widget: MedicationScreen(),
        ),
        VGuard(
          beforeEnter: (vRedirector) async {
            if (Mediminder.instance.selection.deviceUUID == null ||
                Mediminder.instance.selection.deviceUUID == '') {
              await Atom.show(
                GuvenAlert(
                  backgroundColor: getIt<ITheme>().cardBackgroundColor,
                  title: GuvenAlert.buildTitle(LocaleProvider.current.info),
                  content: GuvenAlert.buildDescription(
                      LocaleProvider.current.device_register),
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
          },
          stackedRoutes: [
            VWidget(
              path: PagePaths.stripPage,
              widget: StripScreen(),
            ),
          ],
        ),
      ],
    ),

    // Doctor
    VWidget(
      path: PagePaths.doctorHome,
      widget: DoctorHomeScreen(),
      stackedRoutes: [
        VWidget(
          path: PagePaths.doctorPatientList,
          widget: DoctorPatientListScreen(),
          stackedRoutes: [
            VWidget(
              path: PagePaths.doctorBmiPatientDetail,
              widget: const BmiPatientDetailScreen(
                  key: Key('BmiPatientDetailScreen')),
            ),
            VWidget(
              path: PagePaths.doctorGlucosePatientDetailL,
              widget: BloodGlucosePatientDetailScreen(),
            ),
            VWidget(
              path: PagePaths.doctorPatientList,
              widget: BloodPressurePatientDetailScreen(),
            ),
            VWidget(
              path: PagePaths.doctorTreatmentProgress,
              widget: DoctorTreatmentProcessScreen(),
              stackedRoutes: [
                VWidget(
                  path: PagePaths.doctorTreatmentEdit,
                  widget: const PatientTreatmentEditView(
                      key: Key('PatientTreatmentEditView')),
                ),
              ],
            ),
            VWidget(
              path: PagePaths.doctorCosultation,
              widget: ConsultationScreen(),
            ),
          ],
        ),

        //
      ],
    ),
    VGuard(
        beforeEnter: (vRedirector) async {
          if (!getIt<UserNotifier>().isCronic) {
            vRedirector.stopRedirection();
            Atom.show(NotChronicWarning());
          }
        },
        stackedRoutes: [
          VWidget(
            path: PagePaths.healthInformation,
            widget:
                const HealthInformationScreen(key: Key('RegisterStep1Screen')),
          ),
        ]),
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

  static const main = '/home';
  static const profile = '/profile';
  static const follwer = '/followers';
  static const devices = '/devices';
  static const allDevices = '/available_devices';
  static const selectedDevice = '/selected_device/';
  static const createAppointment = '/create-appointment';
  static const createAppointmentEvents = '/create-appointment-events';
  static const createAppointmentSummary = '/create-appointment-summary';
  static const createOnlineAppo = '/create-online-appointment';
  static const consultation = '/e-consultation';
  static const chat = '/chat';
  static const termsAndPrivacy = '/terms-and-privacy';
  static const login = '/login';
  static const registerStep1 = '/register-first';
  static const registerStep2 = '/register-2';
  static const registerStep3 = '/register-3';
  static const forgotPasswordStep1 = '/forgot-password';
  static const forgotPasswordStep2 = '/change-password-with-old';
  static const doctorCv = '/doctor-cv';
  static const appointmentSummary = '/appointment-summary';

  static const covid19 = '/covid19';
  static const eResult = '/results';
  static const visitDetail = '/visit-detail';
  static const forYouCategories = '/for-you';
  static const forYouSubCategories = '/for-you-categories';
  static const forYouSubCategoriesDetail = '/for-you-categories-detail';
  static const personalInformation = '/personel-info';
  static const orderSummary = '/order-summary';
  static const allFiles = '/all-files';
  static const relatives = '/relatives';
  static const changePassword = '/change-password';
  static const departments = '/departments';
  static const resources = '/resources';
  static const events = '/events';
  static const appointment = '/appointments';
  static const shoppingChart = '/shopping-cart';
  static const creditCard = '/credit-card';
  static const youtubeViewerMobile = '/stream';
  static const youtubeViewerWeb = '/stream';
  static const webView = '/webview';
  static const profileImageViewer = '/profile-image';
  static const addPatientRelatives = '/add-patient-relatives';
  static const fullImageViewer = '/full-image-viewer';
  static const fullPdfViewer = '/full-pdf-viewer';
  static const webConferance = '/web-conferance';
  static const suggestResult = '/suggest-request';
  static const healthInformation = '/health-information';

  static const doMobilePayment = '/online-payment';
  static const iyzicoResponseSmsPayment = '/form-submit';

  //Search
  static const searchPage = '/search-page';

  //Mediminder
  static const mediminderInitial = '/mediminder';
  static const bloodGlucosePage = '/mediminder/blood-glucose';
  static const medicationPage = '/mediminder/medication';
  static const hba1cList = '/mediminder/hba1c-list';
  static const hba1cReminderAdd = '/mediminder/hba1c-reminder-add';
  static const stripPage = '/mediminder/strips';
  static const medicationPeriod = '/mediminder/medication-period';
  static const medicationDate = '/mediminder/medication-date';

  // Chroic Tracking
  static const settings = '/ct-settings';
  static const measurementTracking = '/measurement-tracking';
  static const bloodGlucoseProgress = '/blood-gluecose-progress';
  static const bmiProgress = '/bmi-progress';
  static const bpProgress = '/blood-pressure-progress';
  static const treatmentProgress = '/treatment-progress';
  static const treatmentEditProgress = '/tretment-edit-progress';

  // Symptom Checker
  static const symptomMainMenu = '/symptom-main';
  static const symptomBodyLocations = '/symptom-body-locations';
  static const symptomSubBodyLocations = '/symptom-sub-body-locations';
  static const symptomSelectPage = '/symptom-selection-page';
  static const symptomResultPage = '/symptom-result-page';

  //Detailed Symptom
  static const detailedSymptom = '/detailed-symptom';

  // Doctor
  static const doctorHome = '/doctor';
  static const doctorPatientList = '/doctor-patient-list';
  static const doctorGlucosePatientDetailL = '/blood-glucose-patient-detail';
  static const doctorBmiPatientDetail = '/bmi-patient-detail';
  static const doctorPressurePatientDetail = '/bp-patient-detail';
  static const doctorTreatmentProgress = '/doctor-treatment_process';
  static const doctorTreatmentEdit = '/doctor-patient-treatment-edit';
  static const doctorCosultation = '/doctor-consultation';
}
