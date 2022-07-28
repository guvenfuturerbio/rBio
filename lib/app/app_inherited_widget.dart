import 'dart:async';

import 'package:flutter/material.dart';

import '../core/core.dart';
import '../features/mediminder/mediminder.dart';
import '../features/symptom_checker/symptoms_body_location/model/get_bodylocations_response.dart';
import '../features/symptom_checker/symptoms_body_sublocations_page/viewmodel/symptoms_body_sublocations_vm.dart';
import '../features/symptom_checker/symptoms_result_page/model/get_body_symptoms_response.dart';

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
  late LocalNotificationManager localNotificationManager;

  StreamSubscription<String>? _localNotificationStream;
  void listenLocalNotification() {
    // Uygulama kapalıyken bildirime dokunup, uygulama açıldığında.
    if (selectedNotificationPayload != null) {
      if (selectedNotificationPayload!.isNotEmpty) {
        _selectNotification(selectedNotificationPayload!);
      }
    }

    // Uygulama açıkken bildirime dokunursa.
    _localNotificationStream = localNotificationManager
        .selectNotificationSubject
        ?.listen(_selectNotification);
  }

  void _selectNotification(String payload) {
    if (payload.isEmpty) return;
    final model = LocalNotificationModel.chechIsModel(payload);
    if (model != null) {
      switch (model.type) {
        case LocalNotificationType.reminder:
          {
            final reminderNotifiModel =
                ReminderNotificationModel.chechIsModel(model.data);
            if (reminderNotifiModel != null) {
              Atom.show(
                ReminderAlertDialog(
                  notificationModel: reminderNotifiModel,
                ),
              );
            }
            break;
          }
        default:
          break;
      }
    }
  }

  void cancelStreamLocalNotification() {
    _localNotificationStream?.cancel();
    _localNotificationStream = null;
  }

  AppInheritedWidget({
    Key? key,
    this.listBodySympRsp,
    required this.child,
    required this.localNotificationManager,
  }) : super(key: key, child: child);

  static AppInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
