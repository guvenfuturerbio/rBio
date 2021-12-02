import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../symptoms_body_sublocations_page/viewmodel/symptoms_body_sublocations_vm.dart';

class BodySymptomSelectionVm extends ChangeNotifier {
  BuildContext mContext;
  List<GetBodySymptomsResponse> tmpSelectedSymptoms = [];
  List<GetBodySymptomsResponse> _selectedBodySymptoms = [];
  List<GetBodySymptomsResponse> _proposedSymptomList = [];
  List<String> proposedSymptomsNamesList = [];
  List<String> selectedBodySymptomNamesList = [];
  LoadingProgress _progress;
  LoadingProgress _proposedProgress;
  BodySublocationsVm _myPv;
  String propSymp;
  bool _isFromVoice;

  int removeIndexHolder;

  BodySymptomSelectionVm(
      {BuildContext context,
      int genderId,
      List<GetBodySymptomsResponse> symptomList,
      bool accessedFromSubLocationPage,
      String year_of_birth,
      bool isFromVoice,
      BodySublocationsVm myPv}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _myPv = myPv;
      _isFromVoice = isFromVoice;
      await fetchBodySymptoms(symptomList);
      await fetchProposedSymptoms(
          selectedBodySymptoms, genderId, year_of_birth);
    });
  }

  List<GetBodySymptomsResponse> get selectedBodySymptoms =>
      this._selectedBodySymptoms ?? [];
  List<GetBodySymptomsResponse> get proposedSymptomList =>
      this._proposedSymptomList ?? [];
  LoadingProgress get progress => this._progress;
  LoadingProgress get proposedProgress => this._proposedProgress;
  bool get isFromVoice => this._isFromVoice;

  //Symptom equalizer
  fetchBodySymptoms(List<GetBodySymptomsResponse> symptomsList) async {
    try {
      symptomsList.forEach((element) {
        if (!this._selectedBodySymptoms.contains(element)) {
          this._selectedBodySymptoms.add(element);
        }
      });
      //this._selectedBodySymptoms = symptomsList;
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  fetchProposedSymptoms(List<GetBodySymptomsResponse> symptoms, int gender,
      String year_of_birth) async {
    this._proposedProgress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      List<int> tmpSymptomIdHolder = List();
      for (var element in symptoms) {
        tmpSymptomIdHolder.add(element.id);
      }
      List<GetBodySymptomsResponse> proposedSymptoms =
          await getIt<SymptomRepository>().getProposedSymptoms(
              tmpSymptomIdHolder.toString(),
              gender == 0 || gender == 2 ? 'male' : 'female',
              year_of_birth);
      this._proposedSymptomList = proposedSymptoms;
      this._proposedProgress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      print(e);
      this._proposedProgress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  removeSemptomFromList(GetBodySymptomsResponse symptom) async {
    selectedBodySymptomNamesList.clear();
    tmpSelectedSymptoms = this._selectedBodySymptoms;
    if (tmpSelectedSymptoms.contains(symptom)) {
      tmpSelectedSymptoms.remove(symptom);
    }
    tmpSelectedSymptoms.forEach((element) {
      selectedBodySymptomNamesList.add(element.name.toLowerCase());
    });
    this._selectedBodySymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }

  addSemptomToList(GetBodySymptomsResponse symptom) async {
    selectedBodySymptomNamesList.clear();
    tmpSelectedSymptoms = this._selectedBodySymptoms;
    if (!tmpSelectedSymptoms.contains(symptom)) {
      tmpSelectedSymptoms.add(symptom);
    }
    tmpSelectedSymptoms.forEach((element) {
      selectedBodySymptomNamesList.add(element.name.toLowerCase());
    });
    this._selectedBodySymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }
}
