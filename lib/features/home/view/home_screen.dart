import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../app/bluetooth_v2/bluetooth_v2.dart';
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
      DeepLinkHelper.instance.initDynamicLinks(context);
      getIt<FirebaseMessagingManager>().userInit();
      context.read<DeviceSelectedCubit>().connectAndListen(context);
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
      leading: RbioSwitcher(
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
        ),
      ],
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
