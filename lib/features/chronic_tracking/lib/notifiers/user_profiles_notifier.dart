import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/core.dart';
import '../../../../core/data/service/chronic_service/chronic_storage_service.dart';
import '../../../../core/locator.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/user_profiles/user_profiles.dart';

class UserProfilesNotifier with ChangeNotifier {
  UserProfiles profiles = UserProfiles();
  Person selection;

  static final UserProfilesNotifier _instance =
      UserProfilesNotifier._internal();

  factory UserProfilesNotifier() {
    return _instance;
  }

  UserProfilesNotifier._internal();

  void changeName(String name) {
    selection.name = name;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  void changeGender(String gender) {
    print("Changing gender type to $gender");
    selection.gender = gender;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  Future<void> addProfile(Person person) async {
    profiles.person.add(person);
    await getIt<ProfileStorageImpl>().write(person, shouldSendToServer: true);
    notifyListeners();
  }

  void deleteProfile(Person person) {
    if (person == profiles.active) profiles.active = profiles.person[0];
    profiles.person.remove(person);
    selection = profiles.active;
    notifyListeners();
  }

  void changeBirthdate(String date) {
    selection.birthDate = date;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  void changeHeight(String selectedheight) {
    selection.height = selectedheight;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  List<Text> heightParameters() {
    List<Text> heightWidget = [];
    for (int i = 0; i < 250; i++) {
      heightWidget.add(Text((i).toString() + " cm."));
    }
    return heightWidget;
  }

  List<Text> weightParameters() {
    List<Text> weightWidget = [];
    for (int i = 0; i < 500; i++) {
      weightWidget.add(Text((i).toString() + " kg."));
    }
    return weightWidget;
  }

  List<String> years100 = [];

  List<Text> yearParameters() {
    List<Text> years = [];
    for (int i = DateTime.now().year; i > DateTime.now().year - 101; i--) {
      years.add(Text((i).toString()));
      years100.add((i).toString());
    }
    return years;
  }

  List<Text> hypoParameters() {
    List<Text> hypoWidget = [];
    for (int i = 0; i <= selection.rangeMin ~/ 10; i++) {
      hypoWidget.add(Text((i * 10).toString() + " mg/dL."));
    }
    return hypoWidget;
  }

  List<Text> hyperParameters() {
    List<Text> hyperWidget = [];
    for (int i = selection.rangeMax; i < 1000; i = i + 10) {
      hyperWidget.add(Text((i).toString() + " mg/dL."));
    }
    return hyperWidget;
  }

  List<int> hyperParametersAsInt() {
    List<int> hyperWidget = [];
    for (int i = selection.rangeMax; i < 1000; i = i + 10) {
      hyperWidget.add(i);
    }
    return hyperWidget;
  }

  void changeWeight(String selectedWeight) {
    selection.weight = selectedWeight;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  void changeDiabetesType(String selectedType) {
    print("Changing diabetes type to $selectedType");
    selection.diabetesType = selectedType;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  Future changeRange(RangeValues values) async {
    int newMax = values.end.toInt();
    int newMin = values.start.toInt();
    selection.rangeMax =
        (newMax >= selection.hyper) ? (selection.hyper - 1) : (newMax);
    selection.rangeMin =
        (newMin <= selection.hypo) ? (selection.hypo + 1) : (newMin);
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  Future changeHypo(selectedhypo) async {
    selection.hypo = selectedhypo > selection.rangeMin
        ? selection.rangeMin - 1
        : selectedhypo;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  Future changeHyper(selectedhyper) async {
    selection.hyper = selectedhyper < selection.rangeMax
        ? selection.rangeMax + 1
        : selectedhyper;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  void changeBirthDate(selectedBirthDate) {
    selection.birthDate = selectedBirthDate;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  void changeDeviceUUID(String deviceUUId) {
    print("changeDeviceUUID ${deviceUUId}");
    selection.deviceUUID = deviceUUId;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  void changeSelectedYear(selectedYear) {
    selection.yearOfDiagnosis = int.parse(selectedYear);
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  void changeSelectedSmoker(selectedSmoker) {
    bool result =
        selectedSmoker == LocaleProvider.current.smoker ? true : false;
    selection.smoker = result;
    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  void changeDeviceManufacturerId(int manufacturerId) {
    selection.manufacturerId = manufacturerId;

    getIt<ProfileStorageImpl>().update(selection, selection.key);
    notifyListeners();
  }

  /// REMOTE UPDATE FUNCTIONS
  Future<bool> updateProfileOfPerson(Person person) async {
    person.isFirstUser = false;
    return await getIt<ProfileStorageImpl>().update(person, person.key);
  }

  Future<void> getGlucoseDataOfProfile(Person pd) async {
    await getIt<GlucoseStorageImpl>().getBloodGlucoseDataOfPerson(pd);
  }

  /// END REMOTE UPDATE FUNCTIONS

  DateTime getDateFromStringddMMyyyy() {
    List<String> nums = selection.birthDate.split(".");
    print(nums);
    DateTime dt = new DateTime(
        int.parse(nums[2]), int.parse(nums[1]), int.parse(nums[0]));
    return dt;
  }

  updateProfile(Person person) {
    print(person.name);
    selection = person;
    notifyListeners();
  }
}
