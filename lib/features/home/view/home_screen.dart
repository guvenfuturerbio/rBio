import 'package:atom/atom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../core/core.dart';
import '../viewmodel/home_vm.dart';
import '../widgets/card_appo_result.dart';

enum ShakeMod { shaken, notShaken }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListItemVm>(
      builder: (
        BuildContext context,
        ListItemVm val,
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

  PreferredSize _buildAppBar(ListItemVm val) {
    return RbioAppBar(
      leading: AnimatedCrossFade(
        alignment: Alignment.center,
        duration: kTabScrollDuration,
        crossFadeState: val.status.isShaken
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Center(
          child: IconButton(
            onPressed: () {
              val.showRemovedWidgets();
            },
            icon: Icon(
              Icons.add,
              size: Atom.width * 0.08,
              color: Colors.white,
            ),
          ),
        ),
        secondChild: Center(
          child: SvgPicture.asset(
            R.image.ic_relatives,
            color: Colors.white,
            width: Atom.width * 0.07,
          ),
        ),
      ),
      actions: [
        //
        Center(
          child: SizedBox(
            width: Atom.width * 0.15,
            child: AnimatedCrossFade(
              alignment: Alignment.center,
              duration: kTabScrollDuration,
              crossFadeState: val.status.isShaken
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: TextButton(
                onPressed: () {
                  val.changeStatus();
                },
                child: Text(
                  'Done',
                  style: context.xHeadline3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              secondChild: Center(
                child: SvgPicture.asset(
                  R.image.chat_bubble,
                  width: Atom.width * 0.07,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(ListItemVm val) {
    return Padding(
      padding: R.sizes.screenHorizontalPadding,
      child: ReorderableWrap(
        alignment: WrapAlignment.center,
        /*buildItemsContainer: (_, __, children) {
                  print(children);
                  return Wrap(children: val.widgetsInUse);
                },*/
        buildDraggableFeedback: (_, __, children) {
          return children;
        },
        spacing: Atom.width * .02,
        runSpacing: Atom.width * .03,
        needsLongPressDraggable: true,
        children: val.widgetsInUse,
        onReorder: val.onReorder,
      ),
    );
  }

  Widget buildListScreen() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardAppoResult.appointment(
                  date: "10-10-2021",
                  departmentName: "Endokronoloji",
                  doctorName: "Cüneyt Akın",
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey.shade700,
                  ),
                  tenantName: "Güven Hastanesi Ayrancı",
                  time: "10:00"),
              const SizedBox(
                height: 25,
              ),
              CardAppoResult.result(
                date: "10-10-2021",
                departmentName: "Endokronoloji",
                doctorName: "Cüneyt Akın",
                tenantName: "Güven Hastanesi Ayrancı",
                isActive: true,
              ),
              CardAppoResult.result(
                date: "10-10-2021",
                departmentName: "Endokronoloji",
                doctorName: "Cüneyt Akın",
                tenantName: "Güven Hastanesi Ayrancı",
                isActive: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
