import 'package:flutter/cupertino.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/mediminder/models/person_model.dart';

class HealthInformationVm extends ChangeNotifier {
  bool _isSmoke = false;
  BuildContext mContext;

  PersonModel _selection = PersonModel(
    userId: 56265,
    id: 1627287863112,
    imageURL:
        'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png',
    name: 'Mustafa TÜRKMEN',
    birthDate: '09.11.1997',
    gender: 'Male',
    height: '170',
    weight: '50',
    diabetesType: 'Type 1',
    hypo: 36,
    rangeMin: 76,
    target: 120,
    rangeMax: 151,
    hyper: 301,
    deviceUUID: "",
    manufacturerId: 0,
    yearOfDiagnosis: 2021,
    smoker: true,
    isFirstUser: false,
  );

  PersonModel get selection => _selection;

  HealthInformationVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  void smokerToggle(String value) {
    if (value == LocaleProvider.current.yes) {
      _selection.smoker = true;
    } else {
      _selection.smoker = false;
    }
    notifyListeners();
  }
}
