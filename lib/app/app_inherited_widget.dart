import 'dart:async';

import 'package:flutter/material.dart';

import '../features/symptom_checker/symptoms_body_sublocations_page/viewmodel/symptoms_body_sublocations_vm.dart';
import '../model/model.dart';

class AppInheritedWidget extends InheritedWidget {
  @override
  final Widget child;

  final Orientation defaultOrientation = Orientation.portrait;
  StreamController<Orientation> orientationController =
      StreamController<Orientation>.broadcast();
  void changeOrientation(Orientation value) {
    orientationController.sink.add(value);
  }

  GetBodyLocationResponse? bodyLocationRsp;
  List<GetBodySymptomsResponse>? listBodySympRsp;
  BodySublocationsVm? sublocationVm;

  AppInheritedWidget({
    Key? key,
    this.listBodySympRsp,
    required this.child,
  }) : super(key: key, child: child);

  static AppInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
