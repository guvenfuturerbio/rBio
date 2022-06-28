import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import '../../../core/core.dart';
import '../../my_appointments/view/view.dart';
import '../../profile/profile/view/profile_screen.dart';
import '../search/view/search_screen.dart';
import 'contact_us/contact_us_screen.dart';
import 'dashboard_screen.dart';
import 'home/home_screen.dart';

class GuvenDashboardNavigation extends IProductDashboard {
  GuvenDashboardNavigation();

  static const String search = 'search';
  static const String appointment = 'appointment';
  static const String home = '';
  static const String support = 'support';
  static const String account = 'account';

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
          return GuvenDashboardScreen(
            child: child,
            currentIndex: getCurrent(state),
          );
        },
        nestedRoutes: [
          VWidget(
            path: search,
            name: search,
            widget: const SearchScreen(),
          ),

          //
          VWidget(
            path: appointment,
            name: appointment,
            widget: const AppointmentListScreen(isFromDashboard: true),
          ),

          //
          VWidget(
            path: home,
            name: home,
            widget: const GuvenHomeScreen(),
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
            widget: const ProfileScreen(isFromDashboard: true),
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
