import 'package:atom/atom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../core/core.dart';
import '../viewmodel/home_vm.dart';
import '../widgets/card_appo_result.dart';

enum ShakeMod { shaken, notShaken }

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key key, @required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /// Alt kısım ana ekran tasarımı.
    /// ------------------------------------------
    return Consumer<ListItemVm>(
      builder: (BuildContext context, ListItemVm val, Widget child) =>
          GestureDetector(
        onLongPress: () {
          val.changeStatus();
        },
        child: Scaffold(
            appBar: RbioAppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    val.addItem();
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Atom.width * .02,
                vertical: Atom.height * .01,
              ),
              child: ReorderableWrap(
                alignment: WrapAlignment.center,
                /*buildItemsContainer: (_, __, children) {
                  print(children);
                  return Wrap(children: val.widgetsInUse);
                },*/
                buildDraggableFeedback: (_, __, children) {
                  return children;
                },
                spacing: Atom.width * .03,
                runSpacing: Atom.width * .03,
                needsLongPressDraggable: true,
                children: val.widgetsInUse,
                onReorder: val.onReorder,
              ),
            )),
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
