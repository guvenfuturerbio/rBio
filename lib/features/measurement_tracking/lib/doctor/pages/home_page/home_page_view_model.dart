import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/notification_handler_new.dart';

import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../utils/critic_measurement_info.dart';

class HomePageViewModel extends ChangeNotifier {
  BuildContext context;
  bool _patientSelected, _appointmentSelected;
  PageController _pageController;
  HomePageViewModel({BuildContext context, PageController pageController}) {
    this.context = context;
    this._patientSelected = false;
    this._appointmentSelected = true;
    this._pageController = pageController;
    PushedNotificationHandlerNew().addListener(() async {
      var message = PushedNotificationHandlerNew().message;
      showCriticalMeasurement(
          message['name'] + " için kritik ölçüm " + message['value'] + " mg/dL",
          message['type'] == "4" ? R.color.very_low : R.color.very_high);
    });
  }

  setSelectedPatient() {
    this._patientSelected = true;
    this._appointmentSelected = false;
    _pageController.animateToPage(1,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
    notifyListeners();
  }

  setSelectedAppointment() {
    this._patientSelected = false;
    this._appointmentSelected = true;
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
    notifyListeners();
  }

  bool get patientSelected => this._patientSelected;

  bool get appointmentSelected => this._appointmentSelected;

  /// MGH2
  showCriticalMeasurement(String text, Color color) {
    if (ModalRoute.of(context).isCurrent) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return CriticMeasurement(
                LocaleProvider.current.warning, text, color);
          }).then((value) {
        if (value != null) {
          setSelectedPatient();
        }
      });
    }
  }
}
