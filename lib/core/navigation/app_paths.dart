import 'package:flutter/cupertino.dart';
import 'package:onedosehealth/features/home/view/home_screen.dart';
import 'package:onedosehealth/features/home/viewmodel/home_vm.dart';
import 'package:provider/provider.dart';
import '../../features/appointments/patient_appointments_screen.dart';
import '../../features/appointments/web_conferance_screen.dart';
import '../../features/results/e_result_screen.dart';
import '../../features/results/visit_detail_screen.dart';
import '../../features/store/covid_19/covid_19_screen.dart';
import '../../features/store/credit_card/credit_card_screen.dart';
import '../../features/store/for_you_categories/for_you_categories_screen.dart';
import '../../features/store/for_you_order_summary/order_summary.dart';
import '../../features/store/for_you_sub_categories/for_you_sub_categories_screen.dart';
import '../../features/store/for_you_sub_category_detail/for_you_sub_categories_detail_screen.dart';
import '../../features/store/shopping_cart/shopping_cart_screen.dart';
import '../../features/take_appointment/appointment_summary/appointment_summary_screen.dart';
import '../../features/take_appointment/department_list/department_list_screen.dart';
import '../../features/take_appointment/doctor_cv/doctor_cv_screen.dart';
import '../../features/take_appointment/events/events_screen.dart';
import '../../features/take_appointment/resources/resources_screen.dart';
import '../../features/take_appointment/tenant_list/tenant_list_screen.dart';
import 'package:vrouter/vrouter.dart';

import '../../features/account/ada/ada_symptom_analyzer.dart';
import '../../features/account/add_patient_relatives/add_patient_relatives_screen.dart';
import '../../features/account/all_files/all_files_screen.dart';
import '../../features/account/change_password/change_password_screen.dart';
import '../../features/account/full_image_viewer_screen.dart';
import '../../features/account/patient_relatives/patient_relatives_screen.dart';
import '../../features/account/personal_information/personal_information_screen.dart';
import '../../features/account/profile_image_viewer_screen.dart';
import '../../features/account/youtube/youtube_viewer_mobile_screen.dart';
import '../../features/account/youtube/youtube_viewer_web_screen.dart';
import '../../features/shared/full_pdf_viewer_screen.dart';
import '../../features/shared/webview_screen.dart';
import '../../features/auth/forgot_password/forgot_password_step1_screen.dart';
import '../../features/auth/forgot_password/forgot_password_step2_screen.dart';
import '../../features/auth/login/login_screen.dart';
import '../../features/auth/register/register_step1_screen.dart';
import '../../features/auth/register/register_step2_screen.dart';
import '../../features/auth/register/register_step3_screen.dart';

class VRouterRoutes {
  static var routes = [
    VWidget(
      path: PagePaths.MAIN,
      widget: HomeScreen(title: 'title'),
    ),

    VWidget(
      path: PagePaths.LOGIN,
      widget: HomeScreen(title: 'title'), // LoginScreen(),
    ),

    VWidget(
      path: PagePaths.REGISTER_STEP_1,
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
      path: PagePaths.APPOINTMENT_SUMMARY,
      widget: AppointmentSummaryScreen(),
    ),

    VWidget(
      path: PagePaths.DOCTOR_CV,
      widget: DoctorCvScreen(),
    ),

    VWidget(
      path: PagePaths.HOSPITALS,
      widget: TenantsScreen(),
    ),

    VWidget(
      path: PagePaths.COVID19,
      widget: Covid19Screen(),
    ),

    VWidget(
      path: PagePaths.ERESULT,
      widget: EResultScreen(),
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
      widget: PatientRelativesScreen(),
    ),

    VWidget(
      path: PagePaths.CHANGE_PASSWORD,
      widget: ChangePasswordScreen(),
    ),

    VWidget(
      path: PagePaths.DEPARTMENTS,
      widget: DepartmentListScreen(),
    ),

    VWidget(
      path: PagePaths.RESOURCES,
      widget: ResourcesScreen(),
    ),

    VWidget(
      path: PagePaths.EVENTS,
      widget: EventsScreen(),
    ),

    VWidget(
      path: PagePaths.APPOINTMENTS,
      widget: PatientAppointmentsScreen(true),
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
      path: PagePaths.YOUTUBEVIEWERMOBILE,
      widget: YoutubeViewerMobileScreen(),
    ),

    VWidget(
      path: PagePaths.YOUTUBEVIEWERWEB,
      widget: YoutubeViewerWebScreen(),
    ),

    VWidget(
      path: PagePaths.ADASYMPTOMANALYZER,
      widget: AdaSymptomAnalyzerScreen(),
    ),

    VWidget(
      path: PagePaths.WEBVIEW,
      widget: WebViewScreen(),
    ),

    VWidget(
      path: PagePaths.PROFILEIMAGEVIEWER,
      widget: ProfileImageViewerScreen(),
    ),

    VWidget(
      path: PagePaths.ADDPATIENTRELATIVES,
      widget: AddPatientRelativesScreen(),
    ),

    VWidget(
      path: PagePaths.FULLIMAGEVIEWER,
      widget: FullImageViewerScreen(),
    ),

    VWidget(
      path: PagePaths.FULLPDFVIEWER,
      widget: FullPdfViewerScreen(),
    ),

    VWidget(
      path: PagePaths.WEBCONFERANCE,
      widget: WebConferanceScreen(),
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

  static const MAIN = '/home';
  static const LOGIN = '/login';
  static const REGISTER_STEP_1 = '/register-1';
  static const REGISTER_STEP_2 = '/register-2';
  static const REGISTER_STEP_3 = '/register-3';
  static const FORGOT_PASSWORD_STEP_1 = '/forgot-password';
  static const FORGOT_PASSWORD_STEP_2 = '/change-password-with-old';
  static const APPOINTMENT_SUMMARY = '/appointment-summary';
  static const DOCTOR_CV = '/doctor-cv';
  static const HOSPITALS = '/hospitals';
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
  static const ADASYMPTOMANALYZER = '/adasymptom-analyzer';
  static const WEBVIEW = '/webview';
  static const PROFILEIMAGEVIEWER = '/profile-image';
  static const ADDPATIENTRELATIVES = '/add-patient-relatives';
  static const FULLIMAGEVIEWER = '/full-image-viewer';
  static const FULLPDFVIEWER = '/full-pdf-viewer';
  static const WEBCONFERANCE = '/web-conferance';

  static const DOMOBILEPAYMENT = '/online-payment';
  static const IYZICORESPONSESMSPAYMENT = '/form-submit';
}
