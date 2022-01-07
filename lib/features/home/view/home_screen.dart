import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/notifiers/notification_badge_notifier.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../core/core.dart';
import '../utils/home_sizer.dart';
import '../viewmodel/home_vm.dart';

enum ShakeMod { shaken, notShaken }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (!Atom.isWeb) {
      DeepLinkHandler().initDynamicLinks(context);
      FirebaseMessagingManager.instance;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(
      builder: (
        BuildContext context,
        HomeVm vm,
        Widget child,
      ) {
        return GestureDetector(
          onLongPress: () {
            vm.changeStatus();
          },
          child: RbioScaffold(
            scaffoldKey: scaffoldKey,
            drawerEnableOpenDragGesture: true,
            drawer: _buildDrawer(vm),
            appbar: _buildAppBar(vm),
            body: _buildBody(vm),
          ),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(HomeVm vm) {
    return RbioAppBar(
      leading: Center(
        child: RbioSwitcher(
          showFirstChild: vm.status.isShaken,
          child1: IconButton(
            onPressed: () {
              vm.changeStatus();
              vm.showRemovedWidgets();
            },
            icon: Icon(
              Icons.add,
              size: R.sizes.iconSize,
              color: Colors.white,
            ),
          ),
          child2: SizedBox(
            child: InkWell(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  R.image.menu_icon,
                  color: Colors.white,
                  width: R.sizes.iconSize2,
                ),
              ),
              onTap: () {
                scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
        ),
      ),
      actions: [
        //
        Center(
          child: RbioSwitcher(
            showFirstChild: vm.status.isShaken,
            child1: SizedBox(
              child: IconButton(
                onPressed: () {
                  vm.changeStatus();
                },
                icon: Text(
                  LocaleProvider.current.done,
                  style: context.xHeadline3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            child2: SizedBox(
              height: 50,
              width: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  //
                  Positioned.fill(
                    child: IconButton(
                      icon: Container(
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          R.image.chat_icon,
                          color: Colors.white,
                          width: R.sizes.iconSize,
                        ),
                      ),
                      onPressed: () {
                        vm.openConsultation();
                      },
                    ),
                  ),

                  //
                  Consumer<NotificationBadgeNotifier>(
                    builder: (context, badgeNotifier, child) {
                      if (badgeNotifier.value) {
                        return Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            backgroundColor: R.color.darkRed,
                            radius: 9,
                          ),
                        );
                      }

                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        //
        R.sizes.wSizer8,
      ],
    );
  }

  Drawer _buildDrawer(HomeVm vm) {
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
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 4,
                    ),
                    margin: EdgeInsets.only(
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
                            '${getIt<UserNotifier>().getPatient().firstName} ${getIt<UserNotifier>().getPatient().lastName}',
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
                      R.image.cancel_icon,
                      color: Colors.white,
                      width: R.sizes.iconSize2,
                    ),
                  ),
                  onPressed: () {
                    if (scaffoldKey.currentState.isDrawerOpen) {
                      scaffoldKey.currentState.openEndDrawer();
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
                padding: EdgeInsets.only(left: 15, top: 12),
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemCount: vm.drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openDrawer();
                      vm.drawerList[index].values.first();
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
                            vm.drawerList[index].keys.first,
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
          ],
        ),
      ),
    );
  }

  Widget _buildBody(HomeVm val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: ReorderableWrap(
            alignment: WrapAlignment.center,
            buildDraggableFeedback: (_, __, children) {
              return children;
            },
            spacing: HomeSizer.instance.getRunSpacing(),
            runSpacing: HomeSizer.instance.getBodyGapHeight(),
            needsLongPressDraggable: true,
            children: val.widgetsInUse,
            onReorder: val.onReorder,
            scrollDirection: Axis.vertical,
            maxMainAxisCount: 2,
            minMainAxisCount: 1,
          ),
        ),

        //
        SizedBox(height: Atom.safeBottom),
      ],
    );
  }
}
