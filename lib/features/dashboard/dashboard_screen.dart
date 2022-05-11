import 'dart:developer';

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/dashboard/home/model/drawer_model.dart';

import '../../core/core.dart';
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
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
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
                  child: GestureDetector(
                    onTap: () {
                      getIt<FirebaseAnalyticsManager>()
                          .logEvent(MenuElementTiklamaEvent('profil'));
                      Atom.to(PagePaths.profile);
                    },
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
                        color: getIt<IAppConfig>().theme.secondaryColor,
                        borderRadius: R.sizes.borderRadiusCircular,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          CircleAvatar(
                            backgroundImage:
                                Utils.instance.getCacheProfileImage,
                            radius: R.sizes.iconSize2,
                            backgroundColor:
                                getIt<IAppConfig>().theme.cardBackgroundColor,
                          ),

                          //
                          R.sizes.wSizer12,

                          //
                          Expanded(
                            child: Text(
                              getIt<UserNotifier>().getCurrentUserNameAndSurname(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.xHeadline4.copyWith(
                                  color: getIt<IAppConfig>()
                                      .theme
                                      .textContrastColor),
                            ),
                          ),
                        ],
                      ),
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
                    getIt<FirebaseAnalyticsManager>()
                        .logEvent(MenuButonTiklamaEvent());
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
                              color: getIt<IAppConfig>().theme.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          //
                          R.sizes.hSizer8,

                          //
                          Divider(
                            color: getIt<IAppConfig>().theme.textColor,
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
          color: getIt<IAppConfig>().theme.textColor,
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
                getIt<IAppConfig>().theme.cardBackgroundColor,
              ),
            ),

            //
            Center(
              heightFactor: 0.80,
              child: SizedBox(
                height: 60,
                width: 60,
                child: FloatingActionButton(
                  backgroundColor: getIt<IAppConfig>().theme.mainColor,
                  child: SvgPicture.asset(
                    R.image.bottomNavigationHome,
                    width: R.sizes.iconSize,
                  ),
                  elevation: 0,
                  onPressed: () {
                    getIt<FirebaseAnalyticsManager>()
                        .logEvent(AltBarTiklamaEvent('Logo'));
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
                      getIt<FirebaseAnalyticsManager>()
                          .logEvent(AltBarTiklamaEvent('Arama'));
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
                      getIt<FirebaseAnalyticsManager>()
                          .logEvent(AltBarTiklamaEvent('Chat'));
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
                      getIt<FirebaseAnalyticsManager>()
                          .logEvent(AltBarTiklamaEvent('Grafik'));
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
                      getIt<FirebaseAnalyticsManager>()
                          .logEvent(AltBarTiklamaEvent('Bildirim'));
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
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('profil'));
            Atom.to(PagePaths.profile);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.lbl_find_hospital,
          onTap: () {
            log("clicked");

            AdjustEvent adjustEvent = AdjustEvent('e3bfvq');
            
            Adjust.trackEvent(adjustEvent);

            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('hastane_randevusu_olustur'));
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
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('online_randevu_olustur'));
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
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('saglik_takibi'));
            Atom.to(PagePaths.measurementTrackingHome);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.my_appointments,
          onTap: () {
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('randevu'));
            Atom.to(PagePaths.appointment);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.results,
          onTap: () {
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('sonuclar'));
            Atom.to(PagePaths.eResult);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.for_you,
          onTap: () {
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('size_ozel'));
            Atom.to(PagePaths.forYouCategories);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.symptom_checker,
          onTap: () {
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('symptom_checker'));
            Atom.to(PagePaths.symptomMainMenu);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.devices,
          onTap: () {
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('cihazlarim'));
            Atom.to(PagePaths.devices);
          },
        ),
        if (getIt<IAppConfig>().functionality.mediminder)
          DrawerModel(
            title: LocaleProvider.current.reminders,
            onTap: () {
              getIt<FirebaseAnalyticsManager>()
                  .logEvent(MenuElementTiklamaEvent('hatirlaticilar'));
              Atom.to(PagePaths.reminderList);
            },
          ),
        DrawerModel(
          title: LocaleProvider.current.request_and_suggestions,
          onTap: () {
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('oneriler'));
            Atom.to(PagePaths.suggestResult);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.detailed_symptom,
          onTap: () {
            getIt<FirebaseAnalyticsManager>()
                .logEvent(DetailedSymptomCheckerEvent());
            Atom.to(
              PagePaths.detailedSymptom,
            );
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.log_out,
          onTap: () async {
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('cikis'));
            await getIt<UserNotifier>().logout(context);
          },
        ),
      ];
}
