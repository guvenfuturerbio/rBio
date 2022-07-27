import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/rbio_height_required_info_dialog.dart';
import '../../../bluetooth_v2/bluetooth_v2.dart';
import '../utils/home_sizer.dart';
import '../viewmodel/home_vm.dart';

part '../enum/home_widgets.dart';
part '../enum/shake_mod.dart';

bool kAutoConnect = true;

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
      if (kAutoConnect) {
        context.read<DeviceSelectedCubit>().connectAndListen(context);
        final widgetsBinding = WidgetsBinding.instance;
        widgetsBinding.addPostFrameCallback((_) {
          AppInheritedWidget.of(context)?.listenLocalNotification();
        });
        kAutoConnect = false;
      }
    } else {
      final allUsersModel = getIt<UserFacade>()
          .getHomeWidgets(getIt<UserNotifier>().firebaseEmail ?? "");
      context.read<HomeVm>().init(allUsersModel);
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
      context: context,
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
            color: context.xAppBarTheme.iconTheme?.color,
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
        //
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
                color: context.xAppBarTheme.iconTheme?.color,
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
        if (!kIsWeb) {
          vm.changeStatus();
        }
      },
      child: Column(
        children: [
          ReorderableWrap(
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
            crossAxisAlignment: WrapCrossAlignment.center,
            padding: EdgeInsets.only(
              bottom: R.sizes.bottomNavigationBarHeight + 16,
            ),
          ),
        ],
      ),
    );
  }
}
