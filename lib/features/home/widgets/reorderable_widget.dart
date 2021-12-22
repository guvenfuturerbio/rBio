import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:spring/spring.dart';

import '../viewmodel/home_vm.dart';

class MyReorderableWidget extends StatelessWidget {
  final Widget body;

  const MyReorderableWidget({
    Key key,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(
      builder: (BuildContext context, HomeVm vm, Widget child) {
        final Widget child = ReorderableWidget(
          key: key,
          reorderable: vm.status.isShaken,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              //
              Spring.rotate(
                springController: vm.springController,
                alignment: Alignment.center, //def=center
                startAngle: vm.startAngle, //def=0
                endAngle: vm.endAngle, //def=360
                animDuration: const Duration(milliseconds: 150), //def=1s
                animStatus: (AnimStatus status) {},
                curve: Curves.linear, //def=Curves.easInOut
                child: body,
              ),

              //
              Visibility(
                visible: vm.status.isShaken,
                child: GestureDetector(
                  onTap: () {
                    vm.removeWidget(key);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(.6),
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        if (!vm.status.isShaken && !vm.isForDelete) {
          return InkWell(
            onLongPress: () {
              vm.changeStatus();
            },
            onTap: () {},
            child: child,
          );
        } else {
          return child;
        }
      },
    );
  }
}
