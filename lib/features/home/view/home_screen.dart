import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        HomeVm val,
        Widget child,
      ) {
        return GestureDetector(
          onLongPress: () {
            val.changeStatus();
          },
          child: RbioScaffold(
            appbar: _buildAppBar(val),
            body: _buildBody(val),
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
                  R.image.ic_relatives,
                  color: Colors.white,
                  width: R.sizes.iconSize,
                ),
              ),
              onTap: () {
                Atom.to(PagePaths.RELATIVES);
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
            child2: IconButton(
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
        ),

        //
        R.sizes.wSizer8,
      ],
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
            maxMainAxisCount: 3,
          ),
        ),

        //
        SizedBox(height: Atom.safeBottom),
      ],
    );
  }
}
