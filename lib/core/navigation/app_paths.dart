import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../features/auth/auth.dart';
import '../../features/auth/view/change_password_screen.dart';
import '../../features/chronic_tracking/home/view/mt_home_screen.dart';
import '../../features/home/view/home_screen.dart';
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
import '../../features/profile/health_information/view/health_information.dart';
import '../../features/profile/health_information/viewmodel/health_information_vm.dart';
import '../../features/profile/personal_information/view/personal_information_screen.dart';
import '../../features/profile/profile/view/profile_screen.dart';
import '../../features/profile/profile/viewmodel/profile_vm.dart';
import '../../features/profile/request_suggestions/view/request_suggestions_screen.dart';
import '../../features/relatives/relatives.dart';
import '../../features/results/e_result_screen.dart';
import '../../features/results/e_result_vm.dart';
import '../../features/results/visit_detail_screen.dart';
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

class VRouterRoutes {
  static var routes = [
    VWidget(
      path: PagePaths.LOGIN,
      widget: LoginScreen(), // LoginScreen(),
    ),

    VWidget(
      path: PagePaths.MAIN,
      widget: HomeScreen(),
    ),

    VWidget(
      path: PagePaths.PROFILE,
      widget: ChangeNotifierProvider<ProfileVm>(
        create: (context) => ProfileVm(),
        child: ProfileScreen(),
      ),
    ),

    VWidget(
      path: PagePaths.DEVICES,
      widget: DevicesScreen(),
    ),

    VWidget(
      path: PagePaths.ALL_DEVICES,
      widget: AvailableDevices(),
    ),
    VWidget(
      path: PagePaths.SELECTED_DEVICE,
      widget: SelectedDevicesScreen(),
    ),

    // Create Appointment
    VGuard(
      beforeEnter: (vRedirector) async {
        if (vRedirector.toUrl.contains('forOnline=true')) {
          if (!getIt<AppConfig>().takeOnlineAppointment) {
            vRedirector.to(PagePaths.MAIN);
          }
        } else if (vRedirector.toUrl.contains('forOnline=false')) {
          if (!getIt<AppConfig>().takeHospitalAppointment) {
            vRedirector.to(PagePaths.MAIN);
          }
        }
      },
      stackedRoutes: [
        VWidget(
          path: PagePaths.CREATE_APPOINTMENT,
          widget: CreateAppointmentScreen(),
          stackedRoutes: [
            VWidget(
              path: PagePaths.CREATE_APPOINTMENT_EVENTS,
              widget: CreateAppointmentEventsScreen(),
              stackedRoutes: [
                VWidget(
                  path: PagePaths.CREATE_APPOINTMENT_SUMMARY,
                  widget: CreateAppointmentSummaryScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    VWidget(
      path: PagePaths.REGISTER_FIRST,
      widget: RegisterStep1Screen(),
    ),

    VWidget(
      path: PagePaths.REGISTER_STEP_2,
      widget: RegisterStep2Screen(),
    ),

    VWidget(
      path: PagePaths.REGISTER_STEP_3,
      widget: RegisterStep3Screen(),
    ),

    VWidget(
      path: PagePaths.FORGOT_PASSWORD_STEP_1,
      widget: ForgotPasswordStep1Screen(),
    ),

    VWidget(
      path: PagePaths.FORGOT_PASSWORD_STEP_2,
      widget: ForgotPasswordStep2Screen(),
    ),

    VWidget(
      path: PagePaths.DOCTOR_CV,
      widget: DoctorCvScreen(),
    ),

    VWidget(
      path: PagePaths.COVID19,
      widget: Covid19Screen(),
    ),

    VWidget(
      path: PagePaths.ERESULT,
      widget: ChangeNotifierProvider<EResultScreenVm>(
        create: (context) => EResultScreenVm(),
        child: EResultScreen(),
      ),
    ),

    VWidget(
      path: PagePaths.VISIT_DETAIL,
      widget: VisitDetailScreen(),
    ),

    VWidget(
      path: PagePaths.FOR_YOU_CATEGORIES,
      widget: ForYouCategoriesScreen(),
    ),

    VWidget(
      path: PagePaths.FOR_YOU_SUB_CATEGORIES,
      widget: ForYouSubCategoriesScreen(),
    ),

    VWidget(
      path: PagePaths.FOR_YOU_SUB_CATEGORIES_DETAIL,
      widget: ForYouSubCategoriesDetailScreen(),
    ),

    VWidget(
      path: PagePaths.PERSONAL_INFORMATION,
      widget: PersonalInformationScreen(),
    ),

    VWidget(
      path: PagePaths.ORDER_SUMMARY,
      widget: OrderSummaryScreen(),
    ),

    VWidget(
      path: PagePaths.ALL_FILES,
      widget: AllFilesScreen(),
    ),

    VWidget(
      path: PagePaths.RELATIVES,
      widget: ChangeNotifierProvider<RelativesVm>(
        create: (context) => RelativesVm(),
        child: RelativesScreen(),
      ),
    ),

    VWidget(
      path: PagePaths.CHANGE_PASSWORD,
      widget: ChangePasswordScreen(),
    ),

    VWidget(
      path: PagePaths.APPOINTMENTS,
      widget: AppointmentListScreen(true),
    ),

    VWidget(
      path: PagePaths.SHOPPING_CART,
      widget: ShoppingCartScreen(),
    ),

    VWidget(
      path: PagePaths.CREDIT_CARD,
      widget: CreditCardScreen(),
    ),

    VWidget(
      path: PagePaths.WEBVIEW,
      widget: WebViewScreen(),
    ),

    VWidget(
      path: PagePaths.ADDPATIENTRELATIVES,
      widget: AddPatientRelativesScreen(),
    ),

    VWidget(
      path: PagePaths.FULLPDFVIEWER,
      widget: FullPdfViewerScreen(),
    ),

    VWidget(
      path: PagePaths.WEBCONFERANCE,
      widget: WebConferanceScreen(),
    ),

    // Symptom Checker
    VGuard(
      beforeEnter: (vRedirector) async {
        if (!getIt<AppConfig>().symptomChecker) {
          vRedirector.to(PagePaths.MAIN);
        }
      },
      stackedRoutes: [
        VWidget(
          path: PagePaths.SYMPTOM_MAIN_MENU,
          widget: SymptomsHomeScreen(),
        ),
        VWidget(
          path: PagePaths.SYMPTOM_BODY_LOCATIONS,
          widget: SymptomsBodyLocationsScreen(),
        ),
        VWidget(
          path: PagePaths.SYMPTOM_SUB_BODY_LOCATIONS,
          widget: BodySubLocationsPage(),
        ),
        VWidget(
          path: PagePaths.SYMPTOM_SELECT_PAGE,
          widget: BodySymptomsSelectionPage(),
        ),
        VWidget(
          path: PagePaths.SYMPTOM_RESULT_PAGE,
          widget: SymptomsResultPage(),
        ),
      ],
    ),

    VWidget(
      path: PagePaths.MEASUREMENT_TRACKING,
      widget: MeasurementTrackingHomeScreen(),
    ),

    VWidget(
      path: PagePaths.SUGGEST_REQUEST,
      widget: RequestSuggestionsScreen(),
    ),

    // Mediminder
    VGuard(
      beforeEnter: (vRedirector) async {
        if (!getIt<AppConfig>().mediminder) {
          vRedirector.to(PagePaths.MAIN);
        }
      },
      stackedRoutes: [
        VWidget(
          path: PagePaths.MEDIMINDER_INITIAL,
          widget: HomeMediminderScreen(),
        ),
        VWidget(
          path: PagePaths.MEDICATION_SCREEN,
          widget: MedicationScreen(),
        ),
        VWidget(
          path: PagePaths.MEDICATION_PERIOD,
          widget: MedicationPeriodSelectionScreen(),
        ),
        VWidget(
          path: PagePaths.MEDICATION_DATE,
          widget: MedicationDateScreen(),
        ),
        VWidget(
          path: PagePaths.HBA1C_REMINDER_ADD,
          widget: Hba1cReminderAddScreen(),
        ),
        VWidget(
          path: PagePaths.HBA1C_LIST,
          widget: Hba1cReminderListScreen(),
        ),
        VWidget(
          path: PagePaths.BLOOD_GLUCOSE_PAGE,
          widget: MedicationScreen(),
        ),
        VWidget(
          path: PagePaths.STRIP_PAGE,
          widget: StripScreen(),
        ),
      ],
    ),

    VWidget(
        path: PagePaths.HEALTH_INFORMATION,
        widget: ChangeNotifierProvider<HealthInformationVm>(
            create: (context) => HealthInformationVm(),
            child: HealthInformation())),

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

  static const MAIN = '/home';
  static const PROFILE = '/profile';
  static const FOLLOWERS = '/followers';
  static const DEVICES = '/devices';
  static const ALL_DEVICES = '/available_devices';
  static const SELECTED_DEVICE = '/selected_device/';
  static const CREATE_APPOINTMENT = '/create-appointment';
  static const CREATE_APPOINTMENT_EVENTS = '/create-appointment-events';
  static const CREATE_APPOINTMENT_SUMMARY = '/create-appointment-summary';
  static const CREATE_ONLINE_APPO = '/create-online-appointment';

  static const LOGIN = '/login';
  static const REGISTER_FIRST = '/register-first';
  static const REGISTER_STEP_2 = '/register-2';
  static const REGISTER_STEP_3 = '/register-3';
  static const FORGOT_PASSWORD_STEP_1 = '/forgot-password';
  static const FORGOT_PASSWORD_STEP_2 = '/change-password-with-old';
  static const DOCTOR_CV = '/doctor-cv';
  static const APPOINTMENT_SUMMARY = '/appointment-summary';

  static const COVID19 = '/covid19';
  static const ERESULT = '/results';
  static const VISIT_DETAIL = '/visit-detail';
  static const FOR_YOU_CATEGORIES = '/for-you';
  static const FOR_YOU_SUB_CATEGORIES = '/for-you-categories';
  static const FOR_YOU_SUB_CATEGORIES_DETAIL = '/for-you-categories-detail';
  static const PERSONAL_INFORMATION = '/personel-info';
  static const ORDER_SUMMARY = '/order-summary';
  static const ALL_FILES = '/all-files';
  static const RELATIVES = '/relatives';
  static const CHANGE_PASSWORD = '/change-password';
  static const DEPARTMENTS = '/departments';
  static const RESOURCES = '/resources';
  static const EVENTS = '/events';
  static const APPOINTMENTS = '/appointments';
  static const SHOPPING_CART = '/shopping-cart';
  static const CREDIT_CARD = '/credit-card';
  static const YOUTUBEVIEWERMOBILE = '/stream';
  static const YOUTUBEVIEWERWEB = '/stream';
  static const WEBVIEW = '/webview';
  static const PROFILEIMAGEVIEWER = '/profile-image';
  static const ADDPATIENTRELATIVES = '/add-patient-relatives';
  static const FULLIMAGEVIEWER = '/full-image-viewer';
  static const FULLPDFVIEWER = '/full-pdf-viewer';
  static const WEBCONFERANCE = '/web-conferance';
  static const SUGGEST_REQUEST = '/suggest-request';
  static const HEALTH_INFORMATION = '/health-information';

  static const DOMOBILEPAYMENT = '/online-payment';
  static const IYZICORESPONSESMSPAYMENT = '/form-submit';

  //Mediminder
  static const MEDIMINDER_INITIAL = '/mediminder';
  static const BLOOD_GLUCOSE_PAGE = '/mediminder/blood-glucose';
  static const MEDICATION_SCREEN = '/mediminder/medication';
  static const HBA1C_LIST = '/mediminder/hba1c-list';
  static const HBA1C_REMINDER_ADD = '/mediminder/hba1c-reminder-add';
  static const STRIP_PAGE = '/mediminder/strips';
  static const MEDICATION_PERIOD = '/mediminder/medication-period';
  static const MEDICATION_DATE = '/mediminder/medication-date';

  // Chroic Tracking
  static const SETTINGS = '/ct-settings';
  static const MEASUREMENT_TRACKING = '/measurement-tracking';
  static const BLOOD_GLUCOSE_PROGRESS = '/blood-gluecose-progress';

  // Symptom Checker
  static const SYMPTOM_MAIN_MENU = '/symptom-main';
  static const SYMPTOM_BODY_LOCATIONS = '/symptom-body-locations';
  static const SYMPTOM_SUB_BODY_LOCATIONS = '/symptom-sub-body-locations';
  static const SYMPTOM_SELECT_PAGE = '/symptom-selection-page';
  static const SYMPTOM_RESULT_PAGE = '/symptom-result-page';
}
