import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import 'package:onedosehealth/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:onedosehealth/widgets/custom_bar_pie.dart';
import 'package:provider/provider.dart';

import '../../../extension/size_extension.dart';
import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../locator.dart';
import '../../../models/user_profiles/person.dart';
import '../../../notifiers/ble_operators/ble_scanner.dart';
import '../../../notifiers/user_profiles_notifier.dart';
import '../../../widgets/charts/CustomScale.dart';
import '../../../widgets/graph_header_widget.dart';
import '../../../widgets/landscape_graph_widget.dart';
import '../../../widgets/utils.dart';
import '../../../widgets/utils/chart_filter_pop_up.dart';
import '../../progress_pages/bg_progress_page/bg_progress_page_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageNew();
  }
}

class _HomePageNew extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey previewContainer = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<MenuOption> menuOptions = [];

  @override
  void initState() {
    super.initState();
    //NotificationHandler().initializeFCMNotification(context);
    locator<BleScannerOps>().startScan();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          SystemChrome.setEnabledSystemUIOverlays([]);
        } else {
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        }
        return Consumer<BgProgressPageViewModel>(
          builder: (context, value, child) {
            /// MGD1
            if (orientation == Orientation.portrait) {
              return _portraitHome(context, value);
            } else {
              return _glucoseLandScapeHome(context, value);
            }
          },
        );
      },
    );
  }

  Scaffold _glucoseLandScapeHome(
      BuildContext context, BgProgressPageViewModel value) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'adder',
        onPressed: () {
          value.showBleReadingTagger(context);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: <Color>[R.btnLightBlue, R.btnDarkBlue],
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
      ),
      body: LandScapeGraphWidget(
        graph: value.currentGraph,
        value: value,
        filterAction: () {
          showDialog(
              context: context,
              barrierColor: Colors.black12,
              builder: (ctx) => BGChartFilterPopUp(
                    height: context.HEIGHT * .9,
                    width: context.WIDTH * .3,
                  ));
        },
        changeGraphAction: () => value.changeGraphType(),
      ),
    );
  }

  Scaffold _portraitHome(BuildContext context, BgProgressPageViewModel value) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          leading: SvgPicture.asset(
            R.image.guven_logo,
          ),
          title: Consumer<UserProfilesNotifier>(
            builder: (context, value, child) {
              return TitleAppBarWhite(title: value?.selection?.name ?? "-");
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.CHAT_PAGE);
              },
              child: SvgPicture.asset(
                R.image.dmchat_icon_white,
              ),
            )
          ]),
      resizeToAvoidBottomInset: false,
      endDrawer: _drawer(context),
      extendBodyBehindAppBar: true,
      // Disable opening the end drawer with a swipe gesture.
      endDrawerEnableOpenDragGesture: false,
      floatingActionButton: SizedBox(
        width: context.WIDTH * .92,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
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
            ),
            FloatingActionButton(
              heroTag: 'adder',
              onPressed: () {
                value.showBleReadingTagger(context);
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: <Color>[R.btnLightBlue, R.btnDarkBlue],
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
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: context.HEIGHT * .18,
              ),

              /// MG5
              SizedBox(
                  height: (context.HEIGHT * .38) * context.TEXTSCALE,
                  child: GraphHeader(value: value)),
              BottomActionsOfGraph(
                value: value,
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(5, 5))
                ]),
                padding: EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CustomBarPie(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: (context.HEIGHT * 0.06) * context.TEXTSCALE,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SizedBox(
                        height: (context.HEIGHT * .27) * context.TEXTSCALE,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: CustomScaleGaguge(),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: Container(
          padding: EdgeInsets.only(top: 32),
          color: R.drawerBgLightBlue,
          child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
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
