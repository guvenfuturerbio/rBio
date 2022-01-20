import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'bottom_navbar_painter.dart';
import 'dashboard_navigation.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  final int currentIndex;

  DashboardScreen({
    Key key,
    @required this.child,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double get kBarHeight => Atom.safeBottom + 56;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //
        widget.child,

        //
        _buildBottomNavigationBar(),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.transparent,
        width: size.width,
        height: kBarHeight,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            //
            CustomPaint(
              size: Size(size.width, kBarHeight),
              painter: BottomNavbarCustomPainter(
                backgroundColor: getIt<ITheme>().cardBackgroundColor,
              ),
            ),

            //
            Center(
              heightFactor: 0.80,
              child: SizedBox(
                height: 60,
                width: 60,
                child: FloatingActionButton(
                  backgroundColor: getIt<ITheme>().mainColor,
                  child: Icon(Icons.shopping_basket),
                  elevation: 0,
                  onPressed: () {
                    DashboardNavigation.toHome(context);
                  },
                ),
              ),
            ),

            //
            Container(
              width: size.width,
              height: kBarHeight,
              padding: EdgeInsets.only(
                bottom: Atom.safeBottom,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: _getIconColor(0),
                    ),
                    onPressed: () {
                      DashboardNavigation.toSearch(context);
                    },
                    splashColor: Colors.white,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: _getIconColor(1),
                    ),
                    onPressed: () {
                      DashboardNavigation.toChat(context);
                    },
                  ),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: _getIconColor(3),
                    ),
                    onPressed: () {
                      DashboardNavigation.toStatics(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: _getIconColor(4),
                    ),
                    onPressed: () {
                      DashboardNavigation.toNotifications(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor(int iconIndex) => widget.currentIndex == iconIndex
      ? getIt<ITheme>().mainColor
      : Colors.grey.shade400;
}
