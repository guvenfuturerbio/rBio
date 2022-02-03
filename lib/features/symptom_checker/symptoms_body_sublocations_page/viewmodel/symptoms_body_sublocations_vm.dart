import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class BodySublocationsVm extends ChangeNotifier {
  late BuildContext mContext;
  late List<GetBodySublocationResponse> bodySubLocations;
  late GetBodySublocationResponse selectedBodySubLocation;
  late LoadingProgress progress;
  late LoadingProgress symptomControl;
  List<ExpandableController> expControllerList = [];
  List<List<GetBodySymptomsResponse>> allBodySymptoms = [];
  late List<GetBodySymptomsResponse> selectedSymptoms;
  List<GetBodySymptomsResponse> tmpSelectedSymptoms = [];
  late int selectedGenderId;
  late String yearOfBirth;
  String bodyLocNames = "";
  List<String> bodyLocNamesList = [];
  late GetBodyLocationResponse selectedBodyLocation;

  //Add and remove symptom variables for voice command
  bool didToggle = false;
  late int partIndexHolder;
  List<String> symptomNamesList = [];
  List<String> selectedPartSymptomList = [];

  BodySublocationsVm(
      {BuildContext? context,
      int? bodyLocationId,
      int? genderId,
      bool? isFromVoicePage,
      String? yearOfBirth,
      GetBodyLocationResponse? selectedBodyLocation}) {
    mContext = context!;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await fetchBodySubLocations(bodyLocationId!, genderId!);
      //initializeRecord();
      selectedGenderId = genderId;
      yearOfBirth = yearOfBirth;
      selectedBodyLocation = selectedBodyLocation;
    });
  }

  expControllerCreator() {
    List<ExpandableController> tmpList = [];
    for (int i = 0; i < bodySubLocations.length; i++) {
      //initialExpanded true olursa ExpandablePanel kapalı geliyor.
      tmpList.add(ExpandableController(initialExpanded: true));
    }
    expControllerList = tmpList;
  }

  //Vücudun alt bölgelerini çeken method.
  fetchBodySubLocations(int id, int genderId) async {
    progress = LoadingProgress.loading;
    notifyListeners();
    try {
      List<GetBodySublocationResponse> bodySubLocations =
          await getIt<SymptomRepository>().getBodySubLocations(id);
      bodySubLocations = bodySubLocations;
      progress = LoadingProgress.done;
      await expControllerCreator();
      notifyListeners();
      await fetchBodySymptoms(bodySubLocations, genderId);
    } catch (e) {
      print(e);
      progress = LoadingProgress.error;
      notifyListeners();
    }
  }

  //Vücudun semptomlarını çeken method.
  fetchBodySymptoms(
      List<GetBodySublocationResponse> subLocObjects, int genderId) async {
    symptomControl = LoadingProgress.loading;
    notifyListeners();
    try {
      List<List<GetBodySymptomsResponse>> tmpAllSymp = [];
      for (int i = 0; i < subLocObjects.length; i++) {
        List<GetBodySymptomsResponse> bodySymptoms =
            await getIt<SymptomRepository>()
                .getBodySymptoms(subLocObjects[i].id!, genderId);
        tmpAllSymp.add(bodySymptoms);
      }
      allBodySymptoms = tmpAllSymp;
      symptomControl = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      symptomControl = LoadingProgress.error;
      notifyListeners();
      print(e);
    }
  }

  addSemptomToList(GetBodySymptomsResponse symptom) async {
    if (!tmpSelectedSymptoms.contains(symptom)) {
      tmpSelectedSymptoms.add(symptom);
      if (symptom.hasRedFlag ?? false) {
        showGradientDialog(mContext, LocaleProvider.current.emergency_lbl,
            LocaleProvider.current.emergency);
      }
    }
    selectedSymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }

  //Seçilen semptommları listeden silen metod.
  removeSemptomFromList(GetBodySymptomsResponse? symptom) async {
    if (tmpSelectedSymptoms.contains(symptom)) {
      tmpSelectedSymptoms.remove(symptom);
    }
    selectedSymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WarningDialog(title, text);
        });
  }
}
