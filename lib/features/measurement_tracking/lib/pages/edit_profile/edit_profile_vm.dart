import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/repository/profile_repository.dart';
import '../../doctor/utils/progress/progress_dialog.dart';
import '../../generated/l10n.dart';
import '../../models/user_profiles/person.dart';
import '../../notifiers/user_profiles_notifier.dart';
import '../../services/user_service.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/gradient_dialog.dart';
import '../../widgets/utils/base_provider_repository.dart';
import '../../widgets/utils/custom_dialog_for_settings.dart';
import '../profile_page/profile_picture_page.dart';

class EditProfileVm extends ChangeNotifier {
  final mContext;
  bool isLoading = false;
  TextEditingController nameController;
  ProgressDialog progressDialog;
  Person selectedPerson = Person();
  var genderSelect;

  EditProfileVm({this.mContext}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ProfileRepository().addListener(() async {
        await changeRange();
      });
      await getProfiles();
      nameController = TextEditingController(text: selectedPerson.name);
    });
  }
  getProfiles() async {
    try {
      showLoadingDialog();
      selectedPerson = (await UserService().getAllProfile())[0];

      hideDialog();
    } catch (e) {
      hideDialog();
      showInformationDialog('${LocaleProvider.current.sorry_dont_transaction}');
    }
  }

  navigateToImagePage() {
    Navigator.push(
      mContext,
      MaterialPageRoute(
        builder: (context) => ProfileImageViewerScreen(
            selectedPerson.imageURL ?? selectedPerson.profileImage.path,
            LocaleProvider.current.profile_picture_name),
        settings: RouteSettings(name: 'ProfileImageViewerScreen'),
      ),
    );
  }

  bool isSend = false;
  Future<void> changeName() async {
    if (nameController.text.length > 6) {
      selectedPerson.name = nameController.text;
      await ProfileRepository()
          .updateNameById(selectedPerson.id, nameController.text);
    }
    notifyListeners();
  }

  _showBottomSheet(
      {List<Widget> children,
      initialItem,
      Function(dynamic) onSelectedItemChanged,
      Function() pick,
      String type = 'picker'}) {
    return showModalBottomSheet(
        context: mContext,
        builder: (BuildContext builder) {
          return CustomBottomSheet(
            children: children,
            type: type,
            initalItem: initialItem,
            onSelectedItemChanged: onSelectedItemChanged,
            pick: pick,
          );
        });
  }

  _showDialog(
    List<Widget> children,
    initialItem,
    Function(dynamic) onSelectedItemChanged,
    Function() pick,
  ) {
    return showDialog(
        context: mContext,
        builder: (_) => CustomDialog(
            onSelectedItemChanged: onSelectedItemChanged,
            children: children,
            initalItem: initialItem,
            pick: pick));
  }

  showGenderSheet(List<Widget> children) {
    try {
      var selectedGender;
      _showBottomSheet(
        children: children,
        initialItem: getInitialItem('gender'),
        onSelectedItemChanged: (value) {
          if (value == null) {
            selectedGender = selectedPerson.gender == null
                ? 0
                : selectedPerson.gender == LocaleProvider.of(mContext).male
                    ? 1
                    : 2;
          } else {
            selectedGender = value;
          }
        },
        pick: () async {
          var localeProvider = LocaleProvider.current;
          switch (selectedGender) {
            case 1:
              changeGender('${localeProvider.male}');
              break;
            case 2:
              changeGender('${localeProvider.female}');
              break;
            default:
              changeGender('${localeProvider.other}');
          }
          Navigator.pop(mContext, 'dialog');
        },
      );
    } catch (e) {
      print(e);
    }
  }

  changeGender(String gender) {
    selectedPerson.gender = gender;
    ProfileRepository().updateGenderById(selectedPerson.id, gender);

    notifyListeners();
  }

  showHeightSheet(List<Widget> children) {
    var selectedHeight;
    try {
      _showBottomSheet(
        children: children,
        initialItem: getInitialItem('height'),
        onSelectedItemChanged: (value) => selectedHeight = value,
        pick: () {
          changeHeight(selectedHeight);
          Navigator.pop(mContext, 'dialog');
        },
      );
    } catch (e, stack) {
      print(e);
      debugPrintStack(stackTrace: stack);
    }
  }

  changeHeight(int height) {
    selectedPerson.height = height.toString();
    ProfileRepository().updateHeightById(selectedPerson.id, height);

    notifyListeners();
  }

  showWeightSheet(List<Widget> children) {
    var selectedWeight;
    _showBottomSheet(
      children: children,
      initialItem: getInitialItem('weight'),
      onSelectedItemChanged: (value) => selectedWeight = value,
      pick: () {
        changeWeight(selectedWeight);
        Navigator.pop(mContext, 'dialog');
      },
    );
  }

  changeWeight(int weight) {
    selectedPerson.weight = weight.toString();
    ProfileRepository().updateWeightById(selectedPerson.id, weight);

    notifyListeners();
  }

  showDiagnosisSheet(List<Widget> children) {
    {
      var selectedYear;
      _showBottomSheet(
        children: children,
        initialItem: getInitialItem('diagnosis'),
        onSelectedItemChanged: (value) =>
            selectedYear = DateTime.now().year - value,
        pick: () {
          changeDiagnosis(selectedYear);
          Navigator.pop(mContext, 'dialog');
        },
      );
    }
  }

  changeDiagnosis(int diagnosis) {
    selectedPerson.yearOfDiagnosis = diagnosis;
    ProfileRepository().updateYearOfDiagnosis(selectedPerson.id, diagnosis);

    notifyListeners();
  }

  showSmokerSheet(List<Widget> children) {
    var selectedType;
    _showBottomSheet(
      children: children,
      initialItem: getInitialItem('smoker'),
      onSelectedItemChanged: (value) {
        if (value != null) {
          selectedType = selectedPerson.smoker == null
              ? 0
              : selectedPerson.smoker
                  ? 0
                  : 1;
        } else {
          selectedType = value;
        }
      },
      pick: () async {
        var localeProvider = await LocaleProvider.load(Locale('en-GB'));
        localeProvider.male;
        switch (selectedType) {
          case 0:
            changeSmokerType(false);
            break;
          default:
            changeSmokerType(true);
        }
        Navigator.pop(mContext, 'dialog');
      },
    );
  }

  changeRange() async {
    if (!selectedPerson.compareTo(ProfileRepository().activeProfile)) {
      selectedPerson = ProfileRepository().activeProfile;
      UserProfilesNotifier().updateProfile(selectedPerson);
      await updateProfileOfPerson(selectedPerson);
      notifyListeners();
    }
  }

  changeSmokerType(bool type) {
    selectedPerson.smoker = type;
    ProfileRepository().updateIsSmoker(selectedPerson.id, type);

    notifyListeners();
  }

  showDiabetsSheet(List<Widget> children) {
    var selectedType;
    _showBottomSheet(
      children: children,
      initialItem: getInitialItem('diabets'),
      onSelectedItemChanged: (value) {
        if (value == null) {
          selectedType = selectedPerson.diabetesType == null
              ? 0
              : selectedPerson.diabetesType == 'Type 1'
                  ? 1
                  : selectedPerson.diabetesType == 'Type 2'
                      ? 2
                      : 0;
        } else {
          selectedType = value;
        }
      },
      pick: () async {
        var localeProvider = await LocaleProvider.load(Locale('en-GB'));
        localeProvider.male;
        switch (selectedType) {
          case 1:
            changeDiabetsType('${localeProvider.diabetes_type_1}');
            break;
          case 2:
            changeDiabetsType('${localeProvider.diabetes_type_2}');
            break;
          default:
            changeDiabetsType('${localeProvider.non_diabetes}');
        }
        Navigator.pop(mContext, 'dialog');
      },
    );
  }

  changeDiabetsType(String type) {
    selectedPerson.diabetesType = type;
    ProfileRepository().updateDiabetesTypeById(selectedPerson.id, type);

    notifyListeners();
  }

  showDateSheet() {
    var selectedDate;
    _showBottomSheet(
        type: 'date',
        initialItem: getInitialItem('ageDate'),
        onSelectedItemChanged: (val) {
          selectedDate = DateFormat("dd.MM.yyyy").format(val);
        },
        pick: () {
          changeDate(selectedDate);
        });
  }

  changeDate(String date) async {
    if (date != null) {
      var convertedDate = date.toString().substring(0, 10);
      selectedPerson.birthDate = convertedDate;
      await ProfileRepository()
          .updateBirthDateById(selectedPerson.id, convertedDate);

      notifyListeners();
    }
    Navigator.pop(mContext);
  }

  showHyperSheet(List<Widget> children) {
    var _selectedHyper;
    _showDialog(
        children,
        getInitialItem('hyper'),
        (val) => val = _selectedHyper = getHyperInitialValue()[val],
        () => changeHyper(_selectedHyper));
  }

  changeHyper(int selectedHyper) async {
    selectedPerson.hyper = selectedHyper < selectedPerson.rangeMax
        ? selectedPerson.rangeMax + 1
        : selectedHyper;
    await ProfileRepository().updateHyper(selectedPerson.id, selectedHyper);
    notifyListeners();
    Navigator.pop(mContext, 'dialog');
  }

  List<int> getHyperInitialValue() {
    List<int> hyperWidget = [];
    for (int i = selectedPerson.rangeMax; i < 1000; i = i + 10) {
      hyperWidget.add(i);
    }
    return hyperWidget;
  }

  showHypoSheet(List<Widget> children) {
    var _selectedHypo;
    _showDialog(children, getInitialItem('hypo'), (val) => _selectedHypo = val,
        () => changeHypo(_selectedHypo));
  }

  changeHypo(int selectedHypo) {
    if (selectedHypo != null) {
      var _tempHypo = selectedHypo * 10;
      selectedPerson.hypo = _tempHypo > selectedPerson.rangeMin
          ? selectedPerson.rangeMin - 1
          : _tempHypo;
      ProfileRepository().updateHypo(selectedPerson.id, _tempHypo);

      notifyListeners();
    }
    Navigator.pop(mContext, 'dialog');
  }

  getInitialItem(String type) {
    try {
      switch (type) {
        case 'gender':
          return (selectedPerson.gender == null ||
                  selectedPerson.gender == LocaleProvider.current.other)
              ? 0
              : selectedPerson.gender == LocaleProvider.of(mContext).male
                  ? 1
                  : 2;
        case 'height':
          return int.parse(selectedPerson.height) ?? 150;
        case 'weight':
          return selectedPerson.weight == 'null'
              ? 0
              : int.parse(selectedPerson.weight) ?? 50;
        case 'diagnosis':
          return selectedPerson.yearOfDiagnosis != null
              ? DateTime.now().year - selectedPerson.yearOfDiagnosis
              : 0;
        case 'smoker':
          return selectedPerson.smoker == null
              ? 0
              : selectedPerson.smoker
                  ? 1
                  : 0;
        case 'diabets':
          return selectedPerson.diabetesType == "Type 1"
              ? 1
              : (selectedPerson.diabetesType == "Type 2" ? 2 : 0);
        case 'ageDate':
          List<String> nums = selectedPerson.birthDate.split(".");
          DateTime dt = new DateTime(
              int.parse(nums[2]), int.parse(nums[1]), int.parse(nums[0]));
          return dt;
        case 'hyper':
          return getHyperInitialValue().indexOf(selectedPerson.hyper);

        case 'hypo':
          return selectedPerson.hypo ~/ 10;
        case 'range':
          return;

        default:
          throw Exception('getInitialItem');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProfileOfPerson(Person person) async {
    return await BaseProviderRepository().updateProfile(person, person.userId);
  }

  showLoadingDialog() {
    isLoading = true;
    showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            progressDialog = progressDialog ?? ProgressDialog());
    notifyListeners();
  }

  hideDialog() {
    isLoading = false;
    if (progressDialog != null && progressDialog.isShowing()) {
      Navigator.of(mContext).pop();
      progressDialog = null;
    }
    notifyListeners();
  }

  Future showInformationDialog(String text) async {
    await showDialog(
        context: mContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }

  void updateProfile() {
    selectedPerson = UserProfilesNotifier().selection;
    notifyListeners();
  }
}
