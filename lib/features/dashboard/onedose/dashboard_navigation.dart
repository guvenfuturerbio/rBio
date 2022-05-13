import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import '../../../core/core.dart';
import '../../chat/view/consultation_screen.dart';
import '../../chronic_tracking/home/view/mt_home_screen.dart';
import 'dashboard_screen.dart';
import '../home/view/home_screen.dart';
import '../notification_inbox/view/notification_inbox_screen.dart';
import '../search/view/search_screen.dart';

class DashboardNavigation extends IProductDashboard {
  DashboardNavigation();

  static String search = 'search';
  static String chat = 'chat';
  static String home = '';
  static String graph = 'graph';
  static String notifications = 'notifications';

  static void toSearch(BuildContext context) => Atom.to('/home/$search');
  static void toChat(BuildContext context) => Atom.to('/home/$chat');
  static void toHome(BuildContext context) => Atom.to('/home/$home');
  static void toGraph(BuildContext context) => Atom.to('/home/$graph');
  static void toNotifications(BuildContext context) =>
      Atom.to('/home/$notifications');

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

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
            child,
            getCurrent(state),
            drawerKey,
          );
        },
        nestedRoutes: [
          VWidget(
            path: search,
            name: search,
            widget: SearchScreen(drawerKey: drawerKey),
          ),

          //
          VWidget(
            path: chat,
            name: chat,
            widget: ConsultationScreen(drawerKey: drawerKey),
          ),

          //
          VWidget(
            path: home,
            name: home,
            widget: HomeScreen(drawerKey: drawerKey),
          ),

          //
          VWidget(
            path: graph,
            name: graph,
            widget: MeasurementTrackingHomeScreen(drawerKey: drawerKey),
          ),

          //
          VWidget(
            path: notifications,
            name: notifications,
            widget: NotificationInboxScreen(drawerKey: drawerKey),
          ),
        ],
      ),
    ];
  }

  int getCurrent(VRouterData state) {
    if (state.names.contains(search)) {
      return 0;
    } else if (state.names.contains(chat)) {
      return 1;
    } else if (state.names.contains(home)) {
      return 2;
    } else if (state.names.contains(graph)) {
      return 3;
    } else if (state.names.contains(notifications)) {
      return 4;
    }

    return 2;
  }
}
