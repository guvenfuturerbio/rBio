import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/core.dart';
import 'bottom_navbar_painter.dart';
import 'dashboard_navigation.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  final int currentIndex;

  DashboardScreen(
    this.child,
    this.currentIndex, {
    Key? key,
  }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
        height: R.sizes.bottomNavigationBarHeight,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            //
            CustomPaint(
              size: Size(size.width, R.sizes.bottomNavigationBarHeight),
              painter: BottomNavbarCustomPainter(
                 getIt<ITheme>().cardBackgroundColor,
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
                  child: SvgPicture.asset(
                    R.image.bottomNavigationHome,
                    width: R.sizes.iconSize,
                  ),
                  elevation: 0,
                  onPressed: () {
                    if (Atom.url != '/home/') {
                      DashboardNavigation.toHome(context);
                    }
                  },
                ),
              ),
            ),

            //
            Container(
              width: size.width,
              height: R.sizes.bottomNavigationBarHeight,
              padding: EdgeInsets.only(
                bottom: Atom.safeBottom,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: _getSvgChild(
                      0,
                      R.image.bottomNavigationSearch,
                      R.image.bottomNavigationSearchGreen,
                    ),
                    onPressed: () {
                      DashboardNavigation.toSearch(context);
                    },
                    splashColor: Colors.white,
                  ),
                  IconButton(
                    icon: _getSvgChild(
                      1,
                      R.image.bottomNavigationChat,
                      R.image.bottomNavigationChatGreen,
                    ),
                    onPressed: () {
                      DashboardNavigation.toChat(context);
                    },
                  ),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                    icon: _getSvgChild(
                      3,
                      R.image.bottomNavigationGraph,
                      R.image.bottomNavigationGraphGreen,
                    ),
                    onPressed: () {
                      DashboardNavigation.toGraph(context);
                    },
                  ),
                  IconButton(
                    icon: _getSvgChild(
                      4,
                      R.image.bottomNavigationNotification,
                      R.image.bottomNavigationNotificationGreen,
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

  Widget _getSvgChild(
    int iconIndex,
    String passiveImage,
    String activeImage,
  ) =>
      widget.currentIndex != iconIndex
          ? SvgPicture.asset(passiveImage, width: R.sizes.iconSize2)
          : SvgPicture.asset(activeImage, width: R.sizes.iconSize2);
}
