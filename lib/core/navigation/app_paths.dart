import 'package:flutter/cupertino.dart';
import 'package:vrouter/vrouter.dart';

import '../../ui/account/ada/ada_symptom_analyzer.dart';
import '../../ui/account/add_patient_relatives/add_patient_relatives_screen.dart';
import '../../ui/account/all_files/all_files_screen.dart';
import '../../ui/account/change_password/change_password_screen.dart';
import '../../ui/account/full_image_viewer_screen.dart';
import '../../ui/account/patient_relatives/patient_relatives_screen.dart';
import '../../ui/account/personal_information/personal_information_screen.dart';
import '../../ui/account/profile_image_viewer_screen.dart';
import '../../ui/account/youtube/youtube_viewer_mobile_screen.dart';
import '../../ui/account/youtube/youtube_viewer_web_screen.dart';
import '../../ui/dashboard/dashboard_navigation.dart';
import '../../ui/dashboard/home/e_result/e_result_screen.dart';
import '../../ui/dashboard/home/e_result/visit_detail_screen.dart';
import '../../ui/dashboard/patient_appointments/patient_appointments_screen.dart';
import '../../ui/dashboard/patient_appointments/web_conferance_screen.dart';
import '../../ui/dashboard/search/search_screen.dart';
import '../../ui/home/for_you/covid_19/covid_19_screen.dart';
import '../../ui/home/for_you/credit_card/credit_card_screen.dart';
import '../../ui/home/for_you/for_you_categories/for_you_categories_screen.dart';
import '../../ui/home/for_you/for_you_order_summary/order_summary.dart';
import '../../ui/home/for_you/for_you_sub_categories/for_you_sub_categories_screen.dart';
import '../../ui/home/for_you/for_you_sub_category_detail/for_you_sub_categories_detail_screen.dart';
import '../../ui/home/for_you/shopping_cart/shopping_cart_screen.dart';
import '../../ui/home/request_suggestions/request_suggestions_screen.dart';
import '../../ui/home/take_appointment/appointment_summary/appointment_summary_screen.dart';
import '../../ui/home/take_appointment/department_list/department_list_screen.dart';
import '../../ui/home/take_appointment/doctor_cv/doctor_cv_screen.dart';
import '../../ui/home/take_appointment/events/events_screen.dart';
import '../../ui/home/take_appointment/resources/resources_screen.dart';
import '../../ui/home/take_appointment/tenant_list/tenant_list_screen.dart';
import '../../ui/shared/full_pdf_viewer_screen.dart';
import '../../ui/shared/webview_screen.dart';
import '../../ui/authorization/forgot_password/forgot_password_step1_screen.dart';
import '../../ui/authorization/forgot_password/forgot_password_step2_screen.dart';
import '../../ui/authorization/login/login_screen.dart';
import '../../ui/authorization/register/register_step1_screen.dart';
import '../../ui/authorization/register/register_step2_screen.dart';
import '../../ui/authorization/register/register_step3_screen.dart';
import '../locator.dart';
import '../utils/user_info.dart';

class VRouterRoutes {
  static var routes = [
    VGuard(
      beforeEnter: (vRedirector) async =>
          (await getIt<UserInfo>().checkAccessToken()) == false
              ? vRedirector.to(PagePaths.LOGIN)
              : null,
      stackedRoutes: [
        VWidget(
          path: PagePaths.MAIN,
          widget: Container(),
          stackedRoutes: [
            DashboardNavigation(true),
          ],
        ),
      ],
    ),

    VWidget(
      path: PagePaths.LOGIN,
      widget: LoginScreen(),
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
      path: PagePaths.SEARCH,
      widget: SearchScreen(),
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
      path: PagePaths.REQUEST_SUGGESTION,
      widget: RequestSuggestionsScreen(),
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
  static const SEARCH = '/search';
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
  static const REQUEST_SUGGESTION = '/request-suggestion';
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
