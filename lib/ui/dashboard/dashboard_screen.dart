import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../core/core.dart';
import 'dashboard_navigation.dart';

class DashboardScreen extends StatefulWidget {
  bool isDefault;
  String deepLinkPath;
  final Widget child;
  final int currentIndex;

  DashboardScreen({
    this.isDefault = true,
    this.deepLinkPath = "",
    this.child,
    this.currentIndex,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FocusNode focusSearch = FocusNode();
  List<int> pageQueryHolder = [2];

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      DeepLinkHandler().initDynamicLinks(context);
      if (widget.deepLinkPath != "") {
        LoggerUtils.instance.i(widget.deepLinkPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backBtnPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: widget.currentIndex != 0
            ? MainAppBar(
                actions: getActions(context),
                context: context,
                title: getTitleBar(context),
              )
            : null,
        body: widget.child,
        bottomNavigationBar: _builBottomNavigationBar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _builBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF3F6FE),
        border: Border(
          top: BorderSide(color: R.color.dark_white),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          if (pageQueryHolder.last != index) {
            pageQueryHolder.add(index);
          }

          sendTabClickEvent(index);

          if (index == 0) {
            DashboardNavigation.toSearch(context);
          } else if (index == 1) {
            DashboardNavigation.toAppointment(context);
          } else if (index == 2) {
            DashboardNavigation.toHome(context);
          } else if (index == 3) {
            DashboardNavigation.toSupport(context);
          } else if (index == 4) {
            DashboardNavigation.toAccount(context);
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(R.image.search_grey),
            activeIcon: SvgPicture.asset(R.image.search_red),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(R.image.appointments_grey),
            activeIcon: SvgPicture.asset(
              R.image.appointments_red,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Container(),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(R.image.ic_phone_grey),
            activeIcon: SvgPicture.asset(R.image.ic_phone_red),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(R.image.my_profile_grey),
            activeIcon: SvgPicture.asset(R.image.my_profile_red),
            title: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: CircularGradientButton(
        child: SvgPicture.asset(widget.currentIndex == 2
            ? R.image.ic_tabbar_services_white
            : R.image.ic_tabbar_services_grey),
        callback: widget.currentIndex == 2
            ? null
            : () {
                AnalyticsManager().sendEvent(new HomePageTabClickEvent());
                DashboardNavigation.toHome(context);
              },
        gradient: widget.currentIndex == 2
            ? BlueGradient()
            : LinearGradient(
                colors: [Color(0xFFF3F6FE), Color(0xFFF3F6FE)],
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight),
        shadowColor: Gradients.rainbowBlue.colors.last.withOpacity(0.5),
      ),
      onPressed: null,
    );
  }

  Widget getTitle(BuildContext context) {
    switch (widget.currentIndex) {
      case 0:
        return TitleAppBarWhite(title: LocaleProvider.of(context).search);

      case 1:
        return TitleAppBarWhite(
            title: LocaleProvider.of(context).my_appointments);
      case 2:
        return SvgPicture.asset(R.image.guven_logo_white);
      case 3:
        return TitleAppBarWhite(title: LocaleProvider.of(context).chat);

      case 4:
        return TitleAppBarWhite(
            title: LocaleProvider.of(context).title_user_profile);

      default:
        return SizedBox();
    }
  }

  Widget getTitleBar(BuildContext context) {
    return getTitle(context);
  }

  List<Widget> getActions(BuildContext context) {
    switch (widget.currentIndex) {
      case 2:
        return [
          /*IconButton(
            icon: SvgPicture.asset(R.image.ic_mail),
            onPressed: () {},
          ),*/
        ];

      case 1:
        return [
          /*IconButton(
            icon: SvgPicture.asset(R.image.ic_search),
            onPressed: () {
              setState(() {
                isSearching = true;
              });

              focusSearch.requestFocus();
            },
          ),*/
        ];
      case 3:
        return [
          kIsWeb
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(right: 20, top: 10),
                  child: GestureDetector(
                    onTap: () => {
                      shareFile(context, LocaleProvider.of(context).tawkto_url)
                    },
                    child: Platform.isIOS
                        ? SvgPicture.asset(R.image.ic_ios_share)
                        : SvgPicture.asset(R.image.ic_android_share),
                  ),
                )
        ];
      default:
        return [];
    }
  }

  void shareFile(BuildContext context, String url) async {
    await FlutterShare.share(
        title: LocaleProvider.of(context).chat, linkUrl: url);
  }

  void sendTabClickEvent(int index) {
    switch (index) {
      case 0:
        AnalyticsManager().sendEvent(new FindDoctorTabClickEvent());
        return;
      case 1:
        AnalyticsManager().sendEvent(new MyAppointmentsTabClickEvent());
        return;
      case 3:
        AnalyticsManager().sendEvent(new LiveSupportClickEvent());
        return;
      case 4:
        AnalyticsManager().sendEvent(new ProfileTabClickEvent());
        return;
      default:
        return;
    }
  }

  Future<bool> _backBtnPressed() async {
    // if (widget.currentIndex != 2) {
    //   if (pageQueryHolder.length > 1) {
    //     setState(() {
    //       pageController.animateToPage(
    //         pageQueryHolder[pageQueryHolder.indexOf(pageQueryHolder.last) - 1],
    //         duration: Duration(milliseconds: 400),
    //         curve: Curves.linear,
    //       );
    //       pageQueryHolder.removeLast();
    //       currentPage =
    //           pageQueryHolder[pageQueryHolder.indexOf(pageQueryHolder.last)];
    //     });
    //   }
    // } else {
    //   SystemNavigator.pop();
    // }

    return true;
  }
}
