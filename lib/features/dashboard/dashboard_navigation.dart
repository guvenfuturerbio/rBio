import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/core.dart';
import 'dashboard_screen.dart';

class DashboardNavigation extends VRouteElementBuilder {
  DashboardNavigation();

  static final String search = 'search';
  static final String chat = 'chat';
  static final String home = '';
  static final String statics = 'support';
  static final String notifications = 'notifications';

  static void toSearch(BuildContext context) => Atom.to('/home/$search');
  static void toChat(BuildContext context) => Atom.to('/home/$chat');
  static void toHome(BuildContext context) => Atom.to('/home/$home');
  static void toStatics(BuildContext context) => Atom.to('/home/$statics');
  static void toNotifications(BuildContext context) =>
      Atom.to('/home/$notifications');

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
            widget: SizedBox.expand(
              child: Container(
                alignment: Alignment.center,
                color: getIt<ITheme>().scaffoldBackgroundColor,
                child: Text('Search'),
              ),
            ),
          ),

          //
          VWidget(
            path: chat,
            name: chat,
            widget: SizedBox.expand(
              child: Container(
                alignment: Alignment.center,
                color: getIt<ITheme>().scaffoldBackgroundColor,
                child: Text('Chat'),
              ),
            ),
          ),

          //
          VWidget(
            path: home,
            name: home,
            widget: SizedBox.expand(
              child: Container(
                alignment: Alignment.center,
                color: getIt<ITheme>().scaffoldBackgroundColor,
                child: Text('Home'),
              ),
            ),
          ),

          //
          VWidget(
            path: statics,
            name: statics,
            widget: SizedBox.expand(
              child: Container(
                alignment: Alignment.center,
                color: getIt<ITheme>().scaffoldBackgroundColor,
                child: Text('Statics'),
              ),
            ),
          ),

          //
          VWidget(
            path: notifications,
            name: notifications,
            widget: SizedBox.expand(
              child: Container(
                alignment: Alignment.center,
                color: getIt<ITheme>().scaffoldBackgroundColor,
                child: Text('Notifications'),
              ),
            ),
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
    } else if (state.names.contains(statics)) {
      return 3;
    } else if (state.names.contains(notifications)) {
      return 4;
    }

    return 2;
  }
}
