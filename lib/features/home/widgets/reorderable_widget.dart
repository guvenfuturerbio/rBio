import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:spring/spring.dart';

import '../viewmodel/home_vm.dart';

class MyReorderableWidget extends StatelessWidget {
  final Widget body;
  final EdgeInsets padding;

  const MyReorderableWidget({
    Key key,
    this.body,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ListItemVm>(
      builder: (_, val, __) {
        final Widget chiddd = Container(
          padding: padding,
          child: ReorderableWidget(
            key: key,
            reorderable: val.status.isShaken,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Spring.rotate(
                    springController: val.springController,
                    alignment: Alignment.center, //def=center
                    startAngle: val.startAngle, //def=0
                    endAngle: val.endAngle, //def=360
                    animDuration: const Duration(milliseconds: 150), //def=1s
                    animStatus: (AnimStatus status) {},
                    curve: Curves.linear, //def=Curves.easInOut
                    child: body),
                Visibility(
                  visible: val.status.isShaken,
                  child: GestureDetector(
                    onTap: () {
                      val.removeWidget(key);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(.6)),
                      height: 30,
                      width: 30,
                      child: const Icon(Icons.remove,
                          color: Colors.white, size: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
        );

        if (!val.status.isShaken) {
          return InkWell(
            onLongPress: () {},
            onTap: () {
              print("MyReorderableWidget Tap");
            },
            child: chiddd,
          );
        } else {
          return chiddd;
        }
      },
    );
  }
}
