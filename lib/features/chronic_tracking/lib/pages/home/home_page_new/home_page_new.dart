import 'package:atom/atom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/services/user_service.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../extension/size_extension.dart';
import '../../../helper/resources.dart';
import '../../../models/user_profiles/person.dart';
import '../../../notifiers/user_profiles_notifier.dart';
import '../../../widgets/custom_app_bar/custom_app_bar.dart';
import '../../../widgets/utils.dart';
import '../../progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import '../../progress_pages/scale_progress_page/scale_progress_page_view_model.dart';
import '../../../../home/utils/card_widget.dart';
import '../../../../home/model/page_model.dart';

part 'home_page_new_wm.dart';

class HomePageNew extends StatelessWidget {
  HomePageNew({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final menuOptions = [
      MenuOption(
          title: LocaleProvider.current.home,
          navigateRoute: Routes.HOME_PAGE,
          icon: R.image.dashboard_icon,
          iconWidth: 62.7995,
          iconHeight: 74),
      MenuOption(
          title: LocaleProvider.current.blood_glucose_progress,
          navigateRoute: Routes.BG_PROGRESS_PAGE,
          icon: R.image.bg_icon,
          iconWidth: 41.67,
          iconHeight: 70.0),
      MenuOption(
          title: LocaleProvider.current.scale_progress,
          navigateRoute: Routes.SCALE_PROGRESS_PAGE,
          icon: R.image.scale_icon,
          iconWidth: 41.67,
          iconHeight: 70.0),
      MenuOption(
          title: LocaleProvider.current.device_connections,
          navigateRoute: Routes.PAIRED_DEVICES,
          icon: R.image.connect_device_icon,
          iconWidth: 70.0,
          iconHeight: 50.6075),
      MenuOption(
          title: LocaleProvider.current.reminders,
          navigateRoute: Routes.MY_MEDICINES_PAGE,
          icon: R.image.reminder_icon),
      MenuOption(
          title: LocaleProvider.current.consultation,
          navigateRoute: Routes.CONSULTATION_PAGE,
          icon: R.image.consultation_icon,
          iconWidth: 36.3881,
          iconHeight: 70.0),
      /*MenuOption(
        title: LocaleProvider.current.premium,
        navigateRoute: Routes.PREMIUM_STORE_PAGE,
        icon: R.image.premium_icon,
        iconWidth: 41.794,
        iconHeight: 70.0),*/ //
      MenuOption(
          title: LocaleProvider.current.settings,
          navigateRoute: Routes.SETTINGS_PAGE,
          icon: R.image.settings_icon,
          iconWidth: 70.0,
          iconHeight: 70.0)
    ];
    return ChangeNotifierProvider(
      create: (_) => HomePageNewVm(context: context),
      child: Consumer<HomePageNewVm>(
        builder: (_, val, ___) {
          SystemChrome.setPreferredOrientations(val.activeItem != null
              ? [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]
              : [
                  DeviceOrientation.portraitUp,
                ]);
          return val.loading
              ? Scaffold(
                  body: Center(
                    child: CircularPercentIndicator(
                      radius: 25,
                    ),
                  ),
                )
              : OrientationBuilder(builder: (context, orientation) {
                  if (val.activeItem != null &&
                      orientation == Orientation.landscape) {
                    SystemChrome.setEnabledSystemUIMode(
                      SystemUiMode.immersive,
                    );
                  } else {
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
                        overlays: SystemUiOverlay.values);
                  }
                  return Scaffold(
                    key: _scaffoldKey,
                    appBar: val.activeItem == null ||
                            orientation == Orientation.portrait
                        ? CustomAppBar(
                            preferredSize:
                                Size.fromHeight(context.HEIGHT * .18),
                            leading: InkWell(
                                child: SvgPicture.asset(R.image.back_icon),
                                onTap: () => Atom.historyBack()),
                            title: val.activeItem != null
                                ? TitleAppBarWhite(title: val.activeItem.title)
                                : Consumer<UserProfilesNotifier>(
                                    builder: (context, value, child) {
                                      return TitleAppBarWhite(
                                          title: value?.selection?.name ?? "-");
                                    },
                                  ),
                            actions: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(Routes.CHAT_PAGE);
                                  },
                                  child: SvgPicture.asset(
                                    R.image.dmchat_icon_white,
                                  ),
                                )
                              ])
                        : null,
                    floatingActionButton: SizedBox(
                      width: context.WIDTH * .92,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          val.activeItem != null
                              ? FloatingActionButton(
                                  heroTag: 'adder',
                                  onPressed: () {
                                    val.activeItem.manuelEntry();
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft,
                                          colors: <Color>[
                                            R.btnLightBlue,
                                            R.btnDarkBlue
                                          ],
                                        )),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: SvgPicture.asset(
                                        R.image.add_icon,
                                        color: R.color.white,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: R.color.white,
                                )
                              : SizedBox(),
                          orientation == Orientation.portrait
                              ? FloatingActionButton(
                                  heroTag: 'menu',
                                  onPressed: () {
                                    _scaffoldKey.currentState.openEndDrawer();
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: SvgPicture.asset(
                                      R.image.menu_icon,
                                      color: R.color.black,
                                    ),
                                  ),
                                  backgroundColor: R.color.white,
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    endDrawer: _drawer(context, menuOptions),
                    extendBodyBehindAppBar: true,
                    body: ListView(
                      padding: val.activeItem == null
                          ? EdgeInsets.only(top: context.HEIGHT * .18)
                          : EdgeInsets.zero,
                      children: [
                        ...val.items
                            .map(
                              (element) => SectionCard(
                                isActive: val.activeItem != null &&
                                    val.activeItem.key == element.key,
                                isVisible: val.activeItem == null,
                                color: element.color,
                                smallChild: element.smallChild,
                                largeChild: element.largeChild,
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  );
                });
        },
      ),
    );
  }

  Drawer _drawer(BuildContext context, menuOptions) {
    return Drawer(
      child: Container(
          padding: EdgeInsets.only(top: 32),
          color: R.drawerBgLightBlue,
          child: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
              },
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Visibility(
                      visible: false,
                      child: DrawerHeader(
                          padding: EdgeInsets.only(top: 0),
                          child: Container(
                              height: 20,
                              child: SvgPicture.asset(R.image.banner_menu)))),
                  Consumer<UserProfilesNotifier>(
                      builder: (BuildContext context, userProfilesNotifier, _) {
                    return Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 24, bottom: 24),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              elevation: 4,
                              child: Center(
                                  child: Container(
                                padding: EdgeInsets.all(8),
                                height: 50,
                                width: 180,
                                child: Center(
                                    child: Text(
                                        (userProfilesNotifier.selection ??
                                                    Person())
                                                .name ??
                                            "")),
                              ))),
                        )
                      ],
                    );
                  }),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: menuOptions.length,
                      itemBuilder: (context, index) {
                        return MenuItem(
                            context: context, menuOption: menuOptions[index]);
                      }),
                  Padding(
                      padding: EdgeInsets.only(right: 32, top: 32),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            height: 52,
                            width: 52,
                            child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                shadowColor: Colors.grey,
                                child: Center(
                                    child: Container(
                                        child: ClipOval(
                                  child: Material(
                                    color: Colors.white, // button color
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child:
                                          SvgPicture.asset(R.image.close_icon),
                                    ),
                                  ),
                                ))))),
                      ))
                ],
              ))),
    );
  }
}

class MenuOption {
  String title;
  String navigateRoute;
  String icon;
  bool visible;
  double iconHeight;
  double iconWidth;
  MenuOption(
      {this.title,
      this.navigateRoute,
      this.icon,
      this.visible = true,
      this.iconHeight = 44.0,
      this.iconWidth: 44.0});
}

Widget MenuItem({BuildContext context, MenuOption menuOption}) => Visibility(
      visible: menuOption.visible,
      child: GestureDetector(
        onTap: () async {
          /*  if (menuOption.navigateRoute == null) {*/

          /*  } else {
        if (menuOption.navigateRoute == Routes.PROFILES_PAGE) {
          BaseProvider baseProvider =
          BaseProvider.create(TokenProvider().authToken);
          final response = await baseProvider.getAllProfiles();
          bool statusCode = response.statusCode == HttpStatus.ok;
          var profilesBody = jsonDecode(utf8.decode(response.bodyBytes));
          List datum = profilesBody["datum"];
          List<Person> personList = new List(); //datum;

          for (var person in datum) {
            Person p = new Person.fromJson(person);
            //final resp = await baseProvider.deleteProfile(p.id);
            //print(resp);
            personList.add(p);
            if (p.id == UserProfilesNotifier().selection.id) {
              UserProfilesNotifier().selection = p;
              GlucoseRepository().notify();
            }
          }

          for (int i = 0; i < personList.length; i++) {
            if (i == 0) {
              personList[i].isFirstUser = true;
            } else {
              personList[i].isFirstUser = false;
            }
            await ProfileRepository().updateProfile(personList[
            i]); // Update existing pd in case if there are updates from doctor app
          }
        }

      }*/
          Navigator.of(context).pop();
          if (menuOption.navigateRoute != Routes.HOME_PAGE) {
            Navigator.of(context).pushNamed(menuOption.navigateRoute);
          }
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              )), //             <--- BoxDecoration here
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      menuOption.icon,
                      height: 25 * context.TEXTSCALE,
                      width: 25 * context.TEXTSCALE,
                    )),
              ),
              Expanded(
                flex: 7,
                child: Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "${menuOption.title}",
                    )),
              )
            ],
          ),
        ),
      ),
    );
