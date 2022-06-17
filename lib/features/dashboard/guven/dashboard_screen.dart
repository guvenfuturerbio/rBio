import 'package:flutter/material.dart';
import 'package:flutter_facebook_sdk/flutter_facebook_sdk.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../../core/core.dart';
import 'dashboard_navigation.dart';

class GuvenDashboardScreen extends StatefulWidget {
  bool isDefault;
  String deepLinkPath;
  final Widget child;
  final int currentIndex;
  FlutterFacebookSdk? _facebookSdk;

  GuvenDashboardScreen({
    Key? key,
    this.isDefault = true,
    this.deepLinkPath = "",
    required this.child,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _GuvenDashboardScreenState createState() => _GuvenDashboardScreenState();
}

class _GuvenDashboardScreenState extends State<GuvenDashboardScreen> {
  FocusNode focusSearch = FocusNode();
  List<int> pageQueryHolder = [2];
  @override
  void initState() {
    widget._facebookSdk = FlutterFacebookSdk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backBtnPressed,
      child: Scaffold(
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
        color: getIt<IAppConfig>().theme.white,
        border: Border(
          top: BorderSide(color: getIt<IAppConfig>().theme.darkWhite),
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
            GuvenDashboardNavigation.toSearch(context);
          } else if (index == 1) {
            GuvenDashboardNavigation.toAppointment(context);
          } else if (index == 2) {
            GuvenDashboardNavigation.toHome(context);
          } else if (index == 3) {
            GuvenDashboardNavigation.toSupport(context);
          } else if (index == 4) {
            GuvenDashboardNavigation.toAccount(context);
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(R.image.searchGrey),
            activeIcon: SvgPicture.asset(R.image.searchRed),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(R.image.appointmentsGrey),
            activeIcon: SvgPicture.asset(
              R.image.appointmentsRed,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(R.image.icPhoneGrey),
            activeIcon: SvgPicture.asset(R.image.icPhoneRed),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(R.image.myProfileGrey),
            activeIcon: SvgPicture.asset(R.image.myProfileRed),
            label: "",
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: CircularGradientButton(
        child: SvgPicture.asset(widget.currentIndex == 2
            ? R.image.icTabbarServicesWhite
            : R.image.icTabbarServicesGrey),
        callback: widget.currentIndex == 2
            ? () {
                //
              }
            : () {
                GuvenDashboardNavigation.toHome(context);
              },
        gradient: widget.currentIndex == 2
            ? Utils.instance.appGradient()
            : LinearGradient(colors: [
                getIt<IAppConfig>().theme.white,
                getIt<IAppConfig>().theme.white
              ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
        shadowColor: Gradients.rainbowBlue.colors.last.withOpacity(0.5),
      ),
      onPressed: null,
    );
  }

  Widget getTitle(BuildContext context) {
    switch (widget.currentIndex) {
      case 0:
        return RbioAppBar();

      case 1:
        return RbioAppBar();

      case 2:
        return SvgPicture.asset(R.image.guvenLogoWhite);

      case 3:
        return RbioAppBar();

      case 4:
        return RbioAppBar();

      default:
        return const SizedBox();
    }
  }

  Widget getTitleBar(BuildContext context) {
    return getTitle(context);
  }

  void shareFile(BuildContext context, String url) async {
    await FlutterShare.share(
        title: LocaleProvider.of(context).chat, linkUrl: url);
  }

  void sendTabClickEvent(int index) {
    switch (index) {
      case 0:
        //AnalyticsManager().sendEvent(new FindDoctorTabClickEvent());
        return;
      case 1:
        //AnalyticsManager().sendEvent(new MyAppointmentsTabClickEvent());
        return;
      case 3:
        //AnalyticsManager().sendEvent(new LiveSupportClickEvent());
        return;
      case 4:
        //AnalyticsManager().sendEvent(new ProfileTabClickEvent());
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
