import 'dart:async';

import 'package:flutter/material.dart';

import '../features/symptom_checker/symptoms_body_sublocations_page/viewmodel/symptoms_body_sublocations_vm.dart';
import '../model/model.dart';

// ignore: must_be_immutable
class RbioConfig extends InheritedWidget {
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

  RbioConfig({
    Key? key,
    required this.child,
  }) : super(key: key, child: child);

  static RbioConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RbioConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
