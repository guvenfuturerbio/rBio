import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../model/model.dart';

import '../../symptoms_result_page/viewmodel/symptoms_result_page_vm.dart';

enum Mode { PARTSELECTION, SYMPTOMADD, SYMPTOMSUBSTRACT }

class BodySublocationsVm extends ChangeNotifier {
  BuildContext mContext;
  List<GetBodySublocationResponse> _bodySubLocations;
  GetBodySublocationResponse _selectedBodySubLocation;
  LoadingProgress _progress;
  LoadingProgress _symptomControl;
  List<ExpandableController> _expControllerList = [];
  List<List<GetBodySymptomsResponse>> _allBodySymptoms = [];
  List<GetBodySymptomsResponse> _selectedSymptoms;
  List<GetBodySymptomsResponse> tmpSelectedSymptoms = [];
  int _selectedGenderId;
  String _yearOfBirth;
  String bodyLocNames = "";
  List<String> bodyLocNamesList = [];
  GetBodyLocationResponse _selectedBodyLocation;

  //Add and remove symptom variables for voice command
  bool didToggle = false;
  Mode mode = Mode.PARTSELECTION;
  int partIndexHolder;
  List<String> symptomNamesList = [];
  List<String> selectedPartSymptomList = [];

  BodySublocationsVm(
      {BuildContext context,
      int bodyLocationId,
      int genderId,
      bool isFromVoicePage,
      String yearOfBirth,
      GetBodyLocationResponse selectedBodyLocation}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchBodySubLocations(bodyLocationId, genderId);
      //initializeRecord();
      _selectedGenderId = genderId;
      _yearOfBirth = yearOfBirth;
      _selectedBodyLocation = selectedBodyLocation;
    });
  }

  GetBodySublocationResponse get selectedBodySubLocation =>
      this._selectedBodySubLocation;
  List<GetBodySublocationResponse> get bodySubLocations =>
      this._bodySubLocations ?? [];
  LoadingProgress get progress => this._progress;
  LoadingProgress get symptomControl => this._symptomControl;
  List<ExpandableController> get expControllerList => this._expControllerList;
  List<List<GetBodySymptomsResponse>> get allBodySymptoms =>
      this._allBodySymptoms;
  List<GetBodySymptomsResponse> get selectedSymptoms =>
      this._selectedSymptoms ?? [];

  expControllerCreator() {
    List<ExpandableController> tmpList = [];
    for (int i = 0; i < this._bodySubLocations.length; i++) {
      //initialExpanded true olursa ExpandablePanel kapalı geliyor.
      tmpList.add(ExpandableController(initialExpanded: true));
    }
    this._expControllerList = tmpList;
  }

  //Vücudun alt bölgelerini çeken method.
  fetchBodySubLocations(int id, int genderId) async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      List<GetBodySublocationResponse> bodySubLocations =
          await getIt<SymptomRepository>().getBodySubLocations(id);
      this._bodySubLocations = bodySubLocations;
      this._progress = LoadingProgress.DONE;
      await expControllerCreator();
      notifyListeners();
      await fetchBodySymptoms(bodySubLocations, genderId);
    } catch (e) {
      print(e);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  //Vücudun semptomlarını çeken method.
  fetchBodySymptoms(
      List<GetBodySublocationResponse> subLocObjects, int genderId) async {
    this._symptomControl = LoadingProgress.LOADING;
    notifyListeners();
    try {
      List<List<GetBodySymptomsResponse>> tmpAllSymp = List();
      for (int i = 0; i < subLocObjects.length; i++) {
        List<GetBodySymptomsResponse> bodySymptoms =
            await getIt<SymptomRepository>()
                .getBodySymptoms(subLocObjects[i].id, genderId);
        tmpAllSymp.add(bodySymptoms);
      }
      this._allBodySymptoms = tmpAllSymp;
      this._symptomControl = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      this._symptomControl = LoadingProgress.ERROR;
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
    this._selectedSymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }

  //Seçilen semptommları listeden silen metod.
  removeSemptomFromList(GetBodySymptomsResponse symptom) async {
    if (tmpSelectedSymptoms.contains(symptom)) {
      tmpSelectedSymptoms.remove(symptom);
    }
    this._selectedSymptoms = tmpSelectedSymptoms;
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
