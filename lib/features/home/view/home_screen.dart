import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/home/utils/home_sizer.dart';
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
  void initState() {
    if (!Atom.isWeb) {
      DeepLinkHandler().initDynamicLinks(context);
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

  RbioAppBar _buildAppBar(HomeVm val) {
    return RbioAppBar(
      leading: Center(
        child: RbioSwitcher(
          showFirstChild: val.status.isShaken,
          child1: InkWell(
            onTap: () {
              val.changeStatus();
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
              onTap: () {
                Atom.to(PagePaths.CONSULTATION);
              },
            ),
          ),
        ),

        //
        SizedBox(width: Atom.isWeb ? Atom.width * 0.01 : Atom.width * 0.04),
      ],
    );
  }

  Widget _buildBody(HomeVm val) {
    return Align(
      alignment: Alignment.topCenter,
      child: ReorderableWrap(
        alignment: WrapAlignment.center,
        buildDraggableFeedback: (_, __, children) {
          return children;
        },
        spacing: R.sizes.screenHandler<double>(
          context,
          mobile: Atom.width * 0.01,
          tablet: Atom.width * .025,
          desktop: Atom.width * .031,
        ),
        runSpacing: R.sizes.screenHandler<double>(
          context,
          mobile: Atom.width * .020,
          tablet: Atom.width * .025,
          desktop: Atom.width * .02,
        ),
        needsLongPressDraggable: true,
        children: val.widgetsInUse,
        onReorder: val.onReorder,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
