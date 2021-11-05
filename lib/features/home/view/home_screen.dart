import 'package:atom/atom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../core/core.dart';
import '../viewmodel/home_vm.dart';

enum ShakeMod { shaken, notShaken }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          child: Scaffold(
            appBar: _buildAppBar(val),
            body: _buildBody(val),
          ),
        );
      },
    );
  }

  PreferredSize _buildAppBar(HomeVm val) {
    return RbioAppBar(
      leading: Center(
        child: RbioSwitcher(
          showFirstChild: val.status.isShaken,
          child1: InkWell(
            onTap: () {
              val.showRemovedWidgets();
            },
            child: Icon(
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
            showFirstChild: val.status.isShaken,
            child1: SizedBox(
              child: InkWell(
                onTap: () {
                  val.changeStatus();
                },
                child: Text(
                  LocaleProvider.current.done,
                  style: context.xHeadline3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            child2: InkWell(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  R.image.chat_icon,
                  color: Colors.white,
                  width: R.sizes.iconSize,
                ),
              ),
              onTap: () {},
            ),
          ),
        ),

        //
        SizedBox(width: Atom.isWeb ? Atom.width * 0.01 : Atom.width * 0.04),
      ],
    );
  }

  Widget _buildBody(HomeVm val) {
    return ReorderableWrap(
      alignment: WrapAlignment.center,
      buildDraggableFeedback: (_, __, children) {
        return children;
      },
      spacing: Atom.width * 0.0099,
      runSpacing: Atom.width * .03,
      needsLongPressDraggable: true,
      children: val.widgetsInUse,
      onReorder: val.onReorder,
      scrollDirection: Axis.vertical,
      padding: R.sizes.screenPadding,
    );
  }
}
