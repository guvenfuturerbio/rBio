import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../core/core.dart';
import '../utils/home_sizer.dart';
import '../viewmodel/home_vm.dart';

part '../enum/home_widgets.dart';
part '../enum/shake_mod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (!Atom.isWeb) {
      Utils.instance.forcePortraitOrientation();
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
        Widget? child,
      ) {
        return RbioScaffold(
          scaffoldKey: scaffoldKey,
          drawerEnableOpenDragGesture: true,
          drawer: _buildDrawer(vm),
          appbar: _buildAppBar(vm),
          body: _buildBody(vm),
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
                    R.image.menu,
                    color: Colors.white,
                    width: R.sizes.iconSize2,
                  ),
                ),
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          ),
        ),
        actions: [
          Visibility(
            visible: vm.status.isShaken,
            replacement: SizedBox.fromSize(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.done,
                  size: R.sizes.iconSize,
                  color: Colors.transparent,
                ),
              ),
            ),
            child: SizedBox(
              child: IconButton(
                  onPressed: () {
                    vm.changeStatus();
                  },
                  icon: Icon(
                    Icons.done,
                    size: R.sizes.iconSize,
                    color: getIt<ITheme>().cardBackgroundColor,
                  )),
            ),
          )
        ]
        /*
        Center(
          child: RbioSwitcher(
            showFirstChild: vm.status.isShaken,
            child1: SizedBox(
              child: IconButton(
                  onPressed: () {
                    vm.changeStatus();
                  },
                  icon: Icon(
                    Icons.done,
                    size: R.sizes.iconSize,
                    color: getIt<ITheme>().cardBackgroundColor,
                  )),
            ),
            child2: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                SizedBox(
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
                            Atom.to(PagePaths.CONSULTATION);
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

                //
                IconButton(
                  icon: Container(
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      R.image.search_icon,
                      color: Colors.white,
                      width: R.sizes.iconSize,
                    ),
                  ),
                  onPressed: () {
                    Atom.to(PagePaths.SEARCH_PAGE);
                  },
                ),
              ],
            ),
          ),
        ),

        //
        R.sizes.wSizer8,
      ],*/
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
                    if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
                      scaffoldKey.currentState?.openEndDrawer();
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
                itemCount: vm.drawerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                      vm.drawerList[index].onTap();
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
                            vm.drawerList[index].title,
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
            R.sizes.defaultBottomPadding,
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

  Widget _buildBody(HomeVm vm) {
    return GestureDetector(
      onLongPress: () {
        vm.changeStatus();
      },
      child: ReorderableWrap(
        alignment: WrapAlignment.center,
        buildDraggableFeedback: (_, __, children) {
          return children;
        },
        spacing: HomeSizer.instance.getRunSpacing(),
        runSpacing: HomeSizer.instance.getBodyGapHeight(),
        needsLongPressDraggable: true,
        children: vm.widgetsInUse,
        onReorder: vm.onReorder,
        scrollDirection: Axis.vertical,
        maxMainAxisCount: 2,
        minMainAxisCount: 1,
        padding: EdgeInsets.only(
          bottom: R.sizes.bottomNavigationBarHeight + 16,
        ),
      ),
    );
  }
}
