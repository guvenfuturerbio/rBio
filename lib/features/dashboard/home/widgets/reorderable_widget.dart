import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:spring/spring.dart';

import '../view/home_screen.dart';
import '../viewmodel/home_vm.dart';

class MyReorderableWidget extends StatelessWidget {
  final Widget body;
  final HomeWidgets type;
  final bool showDeleteIcon;
  final bool isVerticalCard;
  final VoidCallback? onTap;
  final bool isRemovedWidgets;

  const MyReorderableWidget({
    Key? key,
    required this.body,
    required this.type,
    required this.isRemovedWidgets,
    this.onTap,
    this.isVerticalCard = true,
    this.showDeleteIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioOrientationBuilder(
      builder: (BuildContext context, AsyncSnapshot<Orientation> snapshot) {
        if (snapshot.hasData) {
          return Consumer<HomeVm>(
            builder: (BuildContext context, HomeVm vm, Widget? child) {
              final Widget child = ReorderableWidget(
                key: key!,
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
                      child: !isVerticalCard
                          ? body
                          : GestureDetector(
                              onTap: () {
                                if (vm.showDeletedAlert) {
                                  vm.addWidget(type);
                                } else if (vm.status == ShakeMod.notShaken) {
                                  if (onTap != null) {
                                    onTap!();
                                  }
                                }
                              },
                              child: body,
                            ),
                    ),

                    //
                    if (showDeleteIcon) ...[
                      Visibility(
                        visible: vm.status.isShaken,
                        child: GestureDetector(
                          onTap: () {
                            vm.removeWidget(type);
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
                  ],
                ),
              );

              if (!vm.status.isShaken && !vm.showDeletedAlert) {
                return InkWell(
                  onLongPress: () {
                    if (kIsWeb) return;
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

        return const SizedBox();
      },
    );
  }
}
