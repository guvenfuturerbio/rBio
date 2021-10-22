import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:vrouter/vrouter.dart';

import '../../generated/l10n.dart';
import 'account/account_screen.dart';
import 'contact_us/contact_us_screen.dart';
import 'home/home_screen.dart';
import 'dashboard_screen.dart';
import 'patient_appointments/patient_appointments_screen.dart';
import 'search/search_screen.dart';

class DashboardNavigation extends VRouteElementBuilder {
  final bool isDefault;

  DashboardNavigation(this.isDefault);

  static final String search = 'search';
  static final String appointment = 'appointment';
  static final String home = '';
  static final String support = 'support';
  static final String account = 'account';

  static void toHome(BuildContext context) => Atom.to('/home/$home');
  static void toSearch(BuildContext context) => Atom.to('/home/$search');
  static void toAppointment(BuildContext context) =>
      Atom.to('/home/$appointment');
  static void toSupport(BuildContext context) => Atom.to('/home/$support');
  static void toAccount(BuildContext context) => Atom.to('/home/$account');

  @override
  List<VRouteElement> buildRoutes() {
    return [
      VNester.builder(
        path: '',
        widgetBuilder: (
          BuildContext context,
          VRouterData state,
          Widget child,
        ) {
          return DashboardScreen(
            child: child,
            currentIndex: getCurrent(state),
          );
        },
        nestedRoutes: [
          VWidget(
            path: search,
            name: search,
            widget: SearchScreen(isFromHomePage: false),
          ),

          //
          VWidget(
            path: appointment,
            name: appointment,
            widget: PatientAppointmentsScreen(false),
          ),

          //
          VWidget(
            path: home,
            name: home,
            widget: HomeScreen(),
          ),

          //
          VWidget(
            path: support,
            name: support,
            widget: ContactUsScreen(
              url: LocaleProvider.current.tawkto_url,
              title: LocaleProvider.current.chat,
            ),
          ),

          //
          VWidget(
            path: account,
            name: account,
            widget: AccountScreen(isDefault: isDefault),
          ),
        ],
      ),
    ];
  }

  int getCurrent(VRouterData state) {
    if (state.names.contains(search)) {
      return 0;
    } else if (state.names.contains(appointment)) {
      return 1;
    } else if (state.names.contains(home)) {
      return 2;
    } else if (state.names.contains(support)) {
      return 3;
    } else if (state.names.contains(account)) {
      return 4;
    }

    return 2;
  }
}
