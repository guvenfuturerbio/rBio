import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/data/imports/cronic_tracking.dart';
import '../../../../core/locator.dart';
import '../database/datamodels/glucose_data.dart';
import '../database/repository/glucose_repository.dart';
import '../database/repository/profile_repository.dart';
import '../database/repository/scale_repository.dart';
import '../generated/l10n.dart';
import '../helper/resources.dart';
import '../models/user_profiles/person.dart';
import '../models/user_profiles/user_profiles.dart';
import '../pages/root_page.dart';
import '../widgets/utils/base_provider_repository.dart';
import 'bg_measurements_notifiers.dart';
import 'ble_operators/ble_scanner.dart';
import 'shared_preferences_handler.dart';
import 'user_notifier.dart';

class UserProfilesNotifier with ChangeNotifier {
  UserProfiles profiles = UserProfiles();
  Person selection;
  void changeProfile(Person profile) async {
    profiles.active = profile;
    GlucoseRepository().getLatestMeasurement();
    GlucoseRepository().notifyListeners();
    ProfileRepository().getProfileDataByUserId(profile.id);
    GlucoseRepository().initialize();
    ScaleRepository().initialize();
    BgMeasurementsNotifier().fetchBgMeasurements();
    notifyListeners();
    await BaseProviderRepository().changeProfile(profile.id);
    notifyListeners();
  }

  static final UserProfilesNotifier _instance =
      UserProfilesNotifier._internal();

  factory UserProfilesNotifier() {
    return _instance;
  }

  UserProfilesNotifier._internal() {
    //loadProfiles();
    //TokenProvider().acquireAuthToken();
  }

  void changeActiveProfile(Person person) async {
    selection = person;
    changeProfile(person);
  }

  void changeName(String name) {
    selection.name = name;
    ProfileRepository().updateNameById(selection.id, name);
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  void changeGender(String gender) {
    print("Changing gender type to $gender");
    selection.gender = gender;
    ProfileRepository().updateGenderById(selection.id, gender);
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  void addProfile(Person person) {
    profiles.person.add(person);
    ProfileRepository().addProfile(person, true);
    ProfileRepository().getProfileDataByUserId(person.id);
    notifyListeners();
  }

  void deleteProfile(Person person) {
    if (person == profiles.active) profiles.active = profiles.person[0];
    profiles.person.remove(person);
    selection = profiles.active;
    notifyListeners();
  }

  void logout(Person person, BuildContext context) async {
    await UserNotifier().signOut();
    await BleScannerOps().stopScan();
    await UserNotifier().deleteInformationForAutoLogin();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (contextTrans) => RootPage()),
      ModalRoute.withName(Routes.ROOT_PAGE),
    );
    notifyListeners();
  }

  Future<bool> loadProfiles(String uid, BuildContext context) async {
    final personList =
        await getIt<ChronicTrackingRepository>().getAllProfiles();

    String lastUid = await SharedPreferencesHandler().getLastLoggedUserUid();
    print("Last logged UID: $lastUid");

    if (lastUid == null || lastUid == "") {
      // There is the first login from device
      await SharedPreferencesHandler().saveLastLoggedUserUid(uid);
    } else {
      // Second or further logins here
      if (lastUid == uid) {
        // currently logged user is the same with previous user we just need to update current profile
        for (int i = 0; i < personList.length; i++) {
          if (i == 0) {
            personList[i].isFirstUser = true;
          } else {
            personList[i].isFirstUser = false;
          }
          await ProfileRepository().updateProfile(personList[
              i]); // Update existing pd in case if there are updates from doctor app
        }
      } else {
        // currently logged user is completely new, fetch everything again
        await SharedPreferencesHandler().saveLastLoggedUserUid(uid);
        await ProfileRepository().deleteAllProfiles();
        await GlucoseRepository()
            .deleteAllGlucoseData(); // Remove all previous glucosedata if user has logged with a new account
      }
    }

    // First check database if there are any data to work with
    List<Person> profileDataList = await ProfileRepository().getAllProfiles();
    // If db is empty, check remote server for sync data
    if (profileDataList == null || profileDataList.length < 1) {
      if (personList.length > 0) {
        // There is data on remote server for this user
        for (int i = 0; i < personList.length; i++) {
          if (i == 0) {
            personList[i].isFirstUser = true;
          } else {
            personList[i].isFirstUser = false;
          }
          await ProfileRepository().addProfile(personList[i],
              false); // Data is already in the server do not send it
          getGlucoseDataOfProfile(personList[i]);
        }
      } else {
        // Remote is empty set default data and add first profile
        Person defaultPerson = new Person().fromDefault();
        defaultPerson.isFirstUser = true;
        /*final resp = await baseProvider.setDefaultProfile(defaultPerson);
          print(resp);*/
        await ProfileRepository().addProfile(new Person().fromDefault(), true);
      }
    }

    // At this point db is not empty, populate profiles with data from db
    profileDataList = await ProfileRepository().getAllProfiles();
    profiles.person.clear();
    for (int i = 0; i < profileDataList.length; i++) {
      // Parse database profiledata to person data to be able to show it to user during runtime
      profiles.person.add(profileDataList[i]);
      if (i == 0) {
        UserProfilesNotifier().selection = profileDataList[i];
      }
    }

    ProfileRepository().getProfileDataByUserId(profileDataList[0].id);
    profiles.active = profiles.person[0];
    selection = profiles.active;
    notifyListeners();
    return true;
  }

  void changeBirthdate(String date) {
    selection.birthDate = date;
    ProfileRepository().updateBirthDateById(selection.id, date);
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  void changeHeight(String selectedheight) {
    selection.height = selectedheight;
    ProfileRepository()
        .updateHeightById(selection.id, (int.parse(selectedheight) ?? 0.0));
    updateProfileOfPerson(selection);
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
    ProfileRepository()
        .updateWeightById(selection.id, (int.parse(selectedWeight) ?? 0.0));
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  void changeDiabetesType(String selectedType) {
    print("Changing diabetes type to $selectedType");
    selection.diabetesType = selectedType;
    ProfileRepository().updateDiabetesTypeById(selection.id, selectedType);
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  Future changeRange(RangeValues values) async {
    int newMax = values.end.toInt();
    int newMin = values.start.toInt();
    selection.rangeMax =
        (newMax >= selection.hyper) ? (selection.hyper - 1) : (newMax);
    selection.rangeMin =
        (newMin <= selection.hypo) ? (selection.hypo + 1) : (newMin);
    await ProfileRepository().updateMinAndMax(
        selection.id, values.start.toInt(), values.end.toInt());
    await updateProfileOfPerson(selection);
    notifyListeners();
  }

  Future changeHypo(selectedhypo) async {
    selection.hypo = selectedhypo > selection.rangeMin
        ? selection.rangeMin - 1
        : selectedhypo;
    await ProfileRepository().updateHypo(selection.id, selectedhypo);
    await updateProfileOfPerson(selection);
    notifyListeners();
  }

  Future changeHyper(selectedhyper) async {
    selection.hyper = selectedhyper < selection.rangeMax
        ? selection.rangeMax + 1
        : selectedhyper;
    await ProfileRepository().updateHyper(selection.id, selectedhyper);
    await updateProfileOfPerson(selection);
    notifyListeners();
  }

  void changeBirthDate(selectedBirthDate) {
    selection.birthDate = selectedBirthDate;
    ProfileRepository().updateBirthDateById(selection.id, selectedBirthDate);
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  void changeDeviceUUID(String deviceUUId) {
    print("changeDeviceUUID ${deviceUUId}");
    selection.deviceUUID = deviceUUId;
    ProfileRepository().updateDeviceUUIDById(selection.id, deviceUUId);
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  void changeSelectedYear(selectedYear) {
    selection.yearOfDiagnosis = int.parse(selectedYear);
    ProfileRepository()
        .updateYearOfDiagnosis(selection.id, int.parse(selectedYear));
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  void changeSelectedSmoker(selectedSmoker) {
    bool result =
        selectedSmoker == LocaleProvider.current.smoker ? true : false;
    selection.smoker = result;
    ProfileRepository().updateIsSmoker(selection.id, result);
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  void changeDeviceManufacturerId(int manufacturerId) {
    selection.manufacturerId = manufacturerId;
    ProfileRepository()
        .updateDeviceManufacturerIdById(selection.id, manufacturerId);
    updateProfileOfPerson(selection);
    notifyListeners();
  }

  /// REMOTE UPDATE FUNCTIONS
  Future<bool> updateProfileOfPerson(Person person) async {
    person.isFirstUser = false;
    return await BaseProviderRepository().updateProfile(person, person.id);
  }

  Future<void> getGlucoseDataOfProfile(Person pd) async {
    List<GlucoseData> glucoseDataList =
        await BaseProviderRepository().getBloodGlucoseDataOfPerson(pd);
    for (GlucoseData glucoseData in glucoseDataList) {
      GlucoseRepository().addNewGlucoseData(
        glucoseData,
        false,
      ); // Data is already in the server don't send it to server
    }
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
