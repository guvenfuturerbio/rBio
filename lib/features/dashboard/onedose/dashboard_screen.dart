import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/core.dart';
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
      backgroundColor: getIt<IAppConfig>().theme.bottomMenuColor,
      child: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            R.widgets.hSizer8,

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
                      getIt<IAppConfig>()
                          .platform
                          .adjustManager
                          ?.trackEvent(MenuElementProfileClickedEvent());
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
                        color: context.xPrimaryColor,
                        borderRadius: R.sizes.borderRadiusCircular,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  Utils.instance.getCacheProfileImage,
                              radius: R.sizes.iconSize2,
                              backgroundColor:
                                  getIt<IAppConfig>().theme.cardBackgroundColor,
                            ),
                          ),

                          //
                          R.widgets.wSizer12,

                          //
                          Expanded(
                            child: Text(
                              getIt<UserFacade>().getNameAndSurname(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.xHeadline4.copyWith(
                                  color: getIt<IAppConfig>().theme.textColor),
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
                      color: getIt<IAppConfig>().theme.iconColor,
                      width: R.sizes.iconSize2,
                    ),
                  ),
                  onPressed: () {
                    getIt<IAppConfig>()
                        .platform
                        .adjustManager
                        ?.trackEvent(MenuButtonClickedEvent());
                    getIt<FirebaseAnalyticsManager>()
                        .logEvent(MenuButonTiklamaEvent());
                    if (widget.drawerKey.currentState?.isDrawerOpen ?? false) {
                      widget.drawerKey.currentState?.openEndDrawer();
                    }
                  },
                ),

                //
                R.widgets.wSizer4,
              ],
            ),

            //
            Expanded(
              child: RbioScrollbar(
                isAlwaysShown: true,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(top: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: drawerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildDrawerListTile(drawerList[index]);
                  },
                ),
              ),
            ),

            //
            R.widgets.hSizer12,

            //
            _buildDrawerListTile(
              DrawerModel(
                title: LocaleProvider.current.log_out,
                svgPath: R.image.drawerLogOut,
                onTap: () async {
                  getIt<IAppConfig>()
                      .platform
                      .adjustManager
                      ?.trackEvent(LogOutEvent());
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('cikis'));
                  await getIt<UserNotifier>().logout(context);
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

  Widget _buildDrawerListTile(DrawerModel model) {
    return InkWell(
      onTap: () {
        widget.drawerKey.currentState?.openDrawer();
        model.onTap();
      },
      overlayColor: MaterialStateProperty.all(context.xPrimaryColor),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              R.widgets.hSizer16,

              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  R.widgets.wSizer4,
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      model.svgPath,
                      color: getIt<IAppConfig>().theme.iconColor,
                    ),
                  ),
                  R.widgets.wSizer16,
                  Expanded(
                    child: Text(
                      model.title,
                      style: context.xHeadline4.copyWith(
                        color: getIt<IAppConfig>().theme.textColorSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              //
              R.widgets.hSizer16,

              // //
              Divider(
                color: Colors.grey.shade200,
                height: 2,
                endIndent: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVersion() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 16,
        right: 8,
        bottom: 8,
      ),
      child: Text(
        "v" + getIt<GuvenSettings>().version,
        textAlign: TextAlign.left,
        style: context.xHeadline5,
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
                getIt<IAppConfig>().theme.bottomMenuColor,
              ),
            ),

            //
            Center(
              heightFactor: 0.80,
              child: SizedBox(
                height: 60,
                width: 60,
                child: RbioSVGFAB(
                  iconColor: null,
                  imagePath: R.image.bottomNavigationHome,
                  elevation: 0,
                  onPressed: () {
                    getIt<IAppConfig>()
                        .platform
                        .adjustManager
                        ?.trackEvent(BottomBarClickedEvent());
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
                  //
                  IconButton(
                    icon: _getSvgChild(
                      0,
                      R.image.bottomNavigationSearch,
                      R.image.bottomNavigationSearchGreen,
                    ),
                    onPressed: () {
                      getIt<IAppConfig>()
                          .platform
                          .adjustManager
                          ?.trackEvent(BottomBarClickedEvent());
                      getIt<FirebaseAnalyticsManager>()
                          .logEvent(AltBarTiklamaEvent('Arama'));
                      DashboardNavigation.toSearch(context);
                    },
                    splashColor: Colors.white,
                  ),

                  //
                  IconButton(
                    icon: _getSvgChild(
                      1,
                      R.image.bottomNavigationChat,
                      R.image.bottomNavigationChatGreen,
                    ),
                    onPressed: () {
                      getIt<IAppConfig>()
                          .platform
                          .adjustManager
                          ?.trackEvent(BottomBarClickedEvent());
                      getIt<FirebaseAnalyticsManager>()
                          .logEvent(AltBarTiklamaEvent('Chat'));
                      DashboardNavigation.toChat(context);
                    },
                  ),

                  //
                  Container(
                    width: size.width * 0.20,
                  ),

                  //
                  IconButton(
                    icon: _getSvgChild(
                      3,
                      R.image.bottomNavigationGraph,
                      R.image.bottomNavigationGraphGreen,
                    ),
                    onPressed: () {
                      getIt<IAppConfig>()
                          .platform
                          .adjustManager
                          ?.trackEvent(BottomBarClickedEvent());
                      getIt<FirebaseAnalyticsManager>()
                          .logEvent(AltBarTiklamaEvent('Grafik'));
                      DashboardNavigation.toGraph(context);
                    },
                  ),

                  //
                  IconButton(
                    icon: _getSvgChild(
                      4,
                      R.image.bottomNavigationNotification,
                      R.image.bottomNavigationNotificationGreen,
                    ),
                    onPressed: () {
                      getIt<IAppConfig>()
                          .platform
                          .adjustManager
                          ?.trackEvent(BottomBarClickedEvent());
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
          ? SvgPicture.asset(
              passiveImage,
              width: R.sizes.iconSize2,
              color: getIt<IAppConfig>().theme.iconColor,
            )
          : SvgPicture.asset(
              activeImage,
              width: R.sizes.iconSize2,
            );

  List<DrawerModel> get drawerList => <DrawerModel>[
        DrawerModel(
          title: LocaleProvider.current.profile,
          svgPath: R.image.drawerProfile,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementProfileClickedEvent());
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('profil'));
            Atom.to(PagePaths.profile);
          },
        ),

        //
        DrawerModel(
          title: LocaleProvider.current.lbl_find_hospital,
          svgPath: R.image.drawerLblFindHospital,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementHospitalAppointmentClickedEvent());
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

        //
        DrawerModel(
          title: LocaleProvider.current.take_video_appointment,
          svgPath: R.image.drawerTakeVideoAppointment,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementOnlineAppoClickedEvent());
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

        //
        DrawerModel(
          title: LocaleProvider.current.chronic_track_home,
          svgPath: R.image.drawerChronicTrackHome,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementHealthTrackerClickedEvent());
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('saglik_takibi'));
            Atom.to(PagePaths.measurementTrackingHome);
          },
        ),

        //
        DrawerModel(
          title: LocaleProvider.current.my_appointments,
          svgPath: R.image.drawerMyAppointments,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementAppointmentsClickedEvent());
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('randevu'));
            Atom.to(PagePaths.appointment);
          },
        ),

        //
        DrawerModel(
          title: LocaleProvider.current.results,
          svgPath: R.image.drawerResults,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementResultsClickedEvent());
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('sonuclar'));
            Atom.to(PagePaths.eResult);
          },
        ),

        //
        DrawerModel(
          title: LocaleProvider.current.for_you,
          svgPath: R.image.drawerForYou,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementForYouClickedEvent());
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('size_ozel'));
            Atom.to(PagePaths.forYouCategories);
          },
        ),

        //
        DrawerModel(
          title: LocaleProvider.current.symptom_checker,
          svgPath: R.image.drawerSymptomChecker,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementSymptomCheckerClickedEvent());
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('symptom_checker'));
            Atom.to(PagePaths.symptomMainMenu);
          },
        ),

        //
        if (!Atom.isWeb && getIt<IAppConfig>().platform.checkDevices())
          DrawerModel(
            title: LocaleProvider.current.devices,
            svgPath: R.image.drawerDevices,
            onTap: () {
              getIt<IAppConfig>()
                  .platform
                  .adjustManager
                  ?.trackEvent(MenuElementDevicesClickedEvent());
              getIt<FirebaseAnalyticsManager>()
                  .logEvent(MenuElementTiklamaEvent('cihazlarim'));
              Atom.to(PagePaths.devices);
            },
          ),

        //
        if (getIt<IAppConfig>().platform.checkMedimender())
          DrawerModel(
            title: LocaleProvider.current.reminders,
            svgPath: R.image.drawerReminders,
            onTap: () {
              getIt<IAppConfig>()
                  .platform
                  .adjustManager
                  ?.trackEvent(MenuElementRemindersClickedEvent());
              getIt<FirebaseAnalyticsManager>()
                  .logEvent(MenuElementTiklamaEvent('hatirlaticilar'));
              Atom.to(PagePaths.reminderList);
            },
          ),

        //
        DrawerModel(
          title: LocaleProvider.current.request_and_suggestions,
          svgPath: R.image.drawerRequestAndSuggestions,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(MenuElementSuggestionsClickedEvent());
            getIt<FirebaseAnalyticsManager>()
                .logEvent(MenuElementTiklamaEvent('oneriler'));
            Atom.to(PagePaths.suggestResult);
          },
        ),

        //
        DrawerModel(
          title: LocaleProvider.current.detailed_symptom,
          svgPath: R.image.drawerDetailedSymptom,
          onTap: () {
            getIt<IAppConfig>()
                .platform
                .adjustManager
                ?.trackEvent(DetailedSymptomEvent());
            getIt<FirebaseAnalyticsManager>()
                .logEvent(DetailedSymptomCheckerEvent());
            Atom.to(
              PagePaths.detailedSymptom,
            );
          },
        ),
      ];
}
