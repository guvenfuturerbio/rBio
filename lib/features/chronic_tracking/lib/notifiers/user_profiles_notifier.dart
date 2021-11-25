import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/core.dart';
import '../../../../core/data/service/chronic_service/chronic_storage_service.dart';
import '../../../../core/locator.dart';
import '../../../../generated/l10n.dart';
import '../models/user_profiles/user_profiles.dart';

class UserProfilesNotifier with ChangeNotifier {
  UserProfiles profiles = UserProfiles();
  Person selection;
  /* void changeProfile(Person profile) async {
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
  } */

  static final UserProfilesNotifier _instance =
      UserProfilesNotifier._internal();

  factory UserProfilesNotifier() {
    return _instance;
  }

  UserProfilesNotifier._internal() {
    //loadProfiles();
    //TokenProvider().acquireAuthToken();
  }

  /* void changeActiveProfile(Person person) async {
    selection = person;
    changeProfile(person);
  } */

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

  /* void logout(Person person, BuildContext context) async {
    await UserNotifier().signOut();
    await BleScannerOps().stopScan();
    await UserNotifier().deleteInformationForAutoLogin();
    notifyListeners();
  } */

  /*  Future<bool> loadProfiles(String uid, BuildContext context) async {
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
          await getIt<ProfileStorageImpl>().update(
              personList[i],
              personList[i]
                  .key); // Update existing pd in case if there are updates from doctor app
        }
      } else {
        // currently logged user is completely new, fetch everything again
        await SharedPreferencesHandler().saveLastLoggedUserUid(uid);
        await getIt<ProfileStorageImpl>().box.clear();
        await getIt<ProfileStorageImpl>()
            .box
            .clear(); // Remove all previous glucosedata if user has logged with a new account
      }
    }

    // First check database if there are any data to work with
    List<Person> profileDataList = getIt<ProfileStorageImpl>().getAll();
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
          getIt<ProfileStorageImpl>().write(personList[i],
              shouldSendToServer:
                  false); // Data is already in the server do not send it
          getGlucoseDataOfProfile(personList[i]);
        }
      } else {
        // Remote is empty set default data and add first profile
        Person defaultPerson = new Person().fromDefault();
        defaultPerson.isFirstUser = true;
        /*final resp = await baseProvider.setDefaultProfile(defaultPerson);
          print(resp);*/
        await getIt<ProfileStorageImpl>().write(
            Person().fromDefault(
                name: FirebaseAuth.instance.currentUser.displayName),
            shouldSendToServer: true);
      }
    }

    // At this point db is not empty, populate profiles with data from db
    profileDataList = getIt<ProfileStorageImpl>().getAll();
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
 */
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
