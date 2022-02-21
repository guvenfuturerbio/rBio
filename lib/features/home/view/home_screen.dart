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
  final GlobalKey<ScaffoldState>? drawerKey;

  const HomeScreen({
    Key? key,
    this.drawerKey,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (!Atom.isWeb) {
      Utils.instance.forcePortraitOrientation();
      DeepLinkHandler().initDynamicLinks(context);
      getIt<FirebaseMessagingManager>().userInit();
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
          drawerEnableOpenDragGesture: true,
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
              child: RbioLeadingMenu(
                drawerKey: widget.drawerKey,
                isHome: true,
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
                ),
              ),
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
