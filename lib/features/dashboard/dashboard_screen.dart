import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/core.dart';
import '../home/model/drawer_model.dart';
import 'bottom_navbar_painter.dart';
import 'dashboard_navigation.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  final GlobalKey<ScaffoldState> drawerKey;

  const DashboardScreen(
    this.child,
    this.currentIndex,
    this.drawerKey, {
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
        Scaffold(
          key: widget.drawerKey,
          drawer: _buildDrawer(),
          body: widget.child,
        ),

        //
        _buildBottomNavigationBar(),
      ],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: getIt<ITheme>().mainColor,
      child: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            R.sizes.hSizer8,

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 4,
                    ),
                    margin: const EdgeInsets.only(
                      left: 15,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      color: getIt<ITheme>().secondaryColor,
                      borderRadius: R.sizes.borderRadiusCircular,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        CircleAvatar(
                          backgroundImage: Utils.instance.getCacheProfileImage,
                          radius: R.sizes.iconSize2,
                          backgroundColor: getIt<ITheme>().cardBackgroundColor,
                        ),

                        //
                        R.sizes.wSizer12,

                        //
                        Expanded(
                          child: Text(
                            Utils.instance.getCurrentUserNameAndSurname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.xHeadline4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //
                IconButton(
                  icon: Container(
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      R.image.cancel,
                      color: Colors.white,
                      width: R.sizes.iconSize2,
                    ),
                  ),
                  onPressed: () {
                    if (widget.drawerKey.currentState?.isDrawerOpen ?? false) {
                      widget.drawerKey.currentState?.openEndDrawer();
                    }
                  },
                ),

                //
                R.sizes.wSizer4,
              ],
            ),

            //
            Card(
              color: Colors.red,
              child: ListTile(
                onTap: () {
                  Atom.to(PagePaths.pairedDeviceListing);
                },
                title: const Text("Open MiScale Devices"),
              ),
            ),

            //
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 15, top: 12),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      widget.drawerKey.currentState?.openDrawer();
                      drawerList[index].onTap();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          R.sizes.hSizer8,

                          //
                          Text(
                            drawerList[index].title,
                            style: context.xHeadline4.copyWith(
                              color: getIt<ITheme>().textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          //
                          R.sizes.hSizer8,

                          //
                          Divider(
                            color: getIt<ITheme>().textColor,
                            endIndent: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            //
            _buildVersion(),

            //
            const SizedBox(height: 65),
          ],
        ),
      ),
    );
  }

  Widget _buildVersion() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "v" + getIt<GuvenSettings>().version,
        textAlign: TextAlign.left,
        style: context.xHeadline5.copyWith(
          color: getIt<ITheme>().textColor,
        ),
      ),
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
          clipBehavior: Clip.none,
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

  List<DrawerModel> get drawerList => <DrawerModel>[
        DrawerModel(
          title: LocaleProvider.current.profile,
          onTap: () {
            Atom.to(PagePaths.profile);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.lbl_find_hospital,
          onTap: () {
            Atom.to(
              PagePaths.createAppointment,
              queryParameters: {
                'forOnline': false.toString(),
                'fromSearch': false.toString(),
                'fromSymptom': false.toString(),
              },
            );
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.take_video_appointment,
          onTap: () {
            Atom.to(
              PagePaths.createAppointment,
              queryParameters: {
                'forOnline': true.toString(),
                'fromSearch': false.toString(),
                'fromSymptom': false.toString(),
              },
            );
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.chronic_track_home,
          onTap: () {
            Atom.to(PagePaths.measurementTracking);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.my_appointments,
          onTap: () {
            Atom.to(PagePaths.appointment);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.results,
          onTap: () {
            Atom.to(PagePaths.eResult);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.for_you,
          onTap: () {
            Atom.to(PagePaths.forYouCategories);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.symptom_checker,
          onTap: () {
            Atom.to(PagePaths.symptomMainMenu);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.devices,
          onTap: () {
            Atom.to(PagePaths.devices);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.reminders,
          onTap: () {
            Atom.to(PagePaths.reminder);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.request_and_suggestions,
          onTap: () {
            Atom.to(PagePaths.suggestResult);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.detailed_symptom,
          onTap: () {
            Atom.to(
              PagePaths.detailedSymptom,
            );
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.log_out,
          onTap: () async {
            await getIt<UserNotifier>().logout(context);
          },
        ),
      ];
}
